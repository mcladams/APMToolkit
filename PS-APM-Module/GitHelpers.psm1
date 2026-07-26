# GitHelpers.psm1
# Microsoft-style module: reusable functions only. No script-level execution.

function Invoke-GitPullShallowDir {
    <#
    .SYNOPSIS
        Performs a shallow sparse checkout of a single directory from a remote
        GitHub repository, plus its LICENSE file and a provenance record.

    .DESCRIPTION
        Detects the remote's default branch (unless -Branch is given), fetches
        only the requested directory via sparse checkout, retrieves the
        LICENSE (if present), flattens the directory to the target root, and
        writes a provenance record. Every git invocation's exit code is
        checked and failures throw rather than continuing silently. The
        caller's original location is always restored, even on error.

    .PARAMETER RepoUrl
        The HTTPS URL of the GitHub repository (e.g. https://github.com/user/repo.git).

    .PARAMETER RemoteDir
        The directory path inside the remote repository to extract.

    .PARAMETER TargetDir
        The local directory name to place the extracted files into.
        Defaults to the same name as RemoteDir.

    .PARAMETER Branch
        The remote branch to pull from. If omitted, the remote's default
        branch is detected automatically via its HEAD symref.

    .EXAMPLE
        Invoke-GitPullShallowDir -RepoUrl "https://github.com/user/repo.git" `
                                  -RemoteDir "skills/windows-wsl-coordination" `
                                  -TargetDir "windows-wsl-coordination"

    .NOTES
        Author: Michael
        Purpose: APM skill extraction with provenance tracking.

        Changed from the Copilot draft:
        - Default branch is detected (git ls-remote --symref) instead of
          hardcoding "main"; the original silently produced an empty/failed
          checkout against any repo whose default branch is "master" or
          something else.
        - Every git call's $LASTEXITCODE is checked and throws on failure.
          Previously a failed fetch/checkout would fall through to
          Get-ChildItem on a directory that was never created.
        - begin/process/end blocks were removed. They added no real pipeline
          behaviour here (no ValueFromPipeline parameters) and, more
          importantly, meant Set-Location $startDir in `end` would never run
          if `process` threw. A single try/finally guarantees the caller's
          shell location is restored regardless of outcome.
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$RepoUrl,

        [Parameter(Mandatory)]
        [string]$RemoteDir,

        [Parameter()]
        [string]$TargetDir,

        [Parameter()]
        [string]$Branch
    )

    if ([string]::IsNullOrWhiteSpace($TargetDir)) {
        $TargetDir = $RemoteDir
    }

    $rawBase = $RepoUrl -replace '^https://github\.com/', '' -replace '\.git$', ''
    $startDir = Get-Location

    if ([string]::IsNullOrWhiteSpace($Branch)) {
        Write-Verbose "No -Branch given; detecting remote default branch..."
        $symref = git ls-remote --symref $RepoUrl HEAD 2>$null
        if ($LASTEXITCODE -eq 0 -and $symref -match 'refs/heads/(\S+)') {
            $Branch = $Matches[1]
            Write-Verbose "Detected default branch: $Branch"
        }
        else {
            Write-Warning "Could not detect default branch; falling back to 'main'."
            $Branch = 'main'
        }
    }

    New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

    try {
        Set-Location $TargetDir

        # --- Fetch LICENSE file ---
        Write-Verbose "Fetching LICENSE files from GitHub..."
        $licenseNames = @("LICENSE", "LICENSE.md", "LICENSE.txt")
        $licenseFound = $false

        foreach ($name in $licenseNames) {
            $url = "https://raw.githubusercontent.com/$rawBase/$Branch/$name"
            try {
                $response = Invoke-WebRequest -Uri $url -UseBasicParsing -ErrorAction Stop
                $response.Content | Set-Content -Path $name -Encoding UTF8
                Write-Verbose "Retrieved LICENSE file: $name"
                $licenseFound = $true
                break
            }
            catch {
                if (Test-Path $name) { Remove-Item $name -Force }
            }
        }
        if (-not $licenseFound) {
            Write-Warning "No LICENSE file found in remote repository."
        }

        # --- Sparse checkout ---
        git init -q
        if ($LASTEXITCODE -ne 0) { throw "git init failed." }

        git remote add origin $RepoUrl
        if ($LASTEXITCODE -ne 0) { throw "git remote add failed." }

        git config core.sparseCheckout true
        $RemoteDir | Out-File -FilePath ".git/info/sparse-checkout" -Encoding UTF8 -Append

        git fetch --depth=1 --filter=blob:none origin $Branch
        if ($LASTEXITCODE -ne 0) { throw "git fetch failed for branch '$Branch'." }

        git checkout $Branch
        if ($LASTEXITCODE -ne 0) { throw "git checkout failed for branch '$Branch'." }

        if (-not (Test-Path $RemoteDir)) {
            throw "'$RemoteDir' was not found after checkout. Confirm the path exists on branch '$Branch'."
        }

        # --- Flatten remote directory to target root ---
        $remoteTop = $RemoteDir.Split('/')[0]
        Get-ChildItem -Path $RemoteDir -Force | ForEach-Object {
            Move-Item -Path $_.FullName -Destination . -Force
        }
        if (Test-Path $remoteTop) {
            Remove-Item $remoteTop -Recurse -Force
        }
        Remove-Item .git -Recurse -Force

        # --- Provenance: one JSON object per line ---
        [ordered]@{
            action    = "extract"
            source    = $RepoUrl
            path      = $RemoteDir
            branch    = $Branch
            timestamp = (Get-Date).ToString("o")
        } | ConvertTo-Json -Compress | Add-Content -Path ".provenance" -Encoding UTF8

        Write-Verbose "Extraction complete: '$TargetDir'"
    }
    finally {
        Set-Location $startDir
    }
}
