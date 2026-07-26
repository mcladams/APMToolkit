# PackagingHelpers.psm1
# Microsoft-style module: reusable functions only. No script-level execution.
#
# Note: the Copilot draft included a Test-SkillPackage function here that
# duplicated SkillHelpers' Test-SkillStructure almost line for line (same
# required-file list, same missing-field check, different name). Two
# independent copies of the same validation rule will drift the first time
# either one is edited. Validation now lives only in SkillHelpers;
# PackagingHelpers creates and stamps provenance, it doesn't also validate.

function New-SkillPackage {
    <#
    .SYNOPSIS
        Creates a new APM skill package folder with required structure.

    .DESCRIPTION
        Generates a skill package directory containing SKILL.md, LICENSE,
        skill.json, and an initial provenance record.

    .PARAMETER Name
        The name of the skill package directory to create.

    .PARAMETER Path
        The parent directory where the skill package will be created.

    .PARAMETER License
        SPDX license identifier for this skill (e.g. "MIT", "GPL-3.0").
        Defaults to "UNLICENSED" so an unset license is visible in the
        manifest rather than silently absent, which was the previous
        behaviour (the draft's skill.json had no license field at all,
        despite the whole earlier half of this project's design work being
        about per-skill licensing).

    .EXAMPLE
        New-SkillPackage -Name "windows-wsl-coordination" -Path "./skills" -License "GPL-3.0"
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Path,

        [Parameter()]
        [string]$License = "UNLICENSED"
    )

    $target = Join-Path $Path $Name
    if (Test-Path $target) {
        throw "Target directory '$target' already exists."
    }

    New-Item -ItemType Directory -Path $target | Out-Null
    New-Item -ItemType File -Path (Join-Path $target "SKILL.md") | Out-Null
    New-Item -ItemType File -Path (Join-Path $target "LICENSE") | Out-Null

    [ordered]@{
        name        = $Name
        version     = "1.0.0"
        description = "Skill package created by PackagingHelpers"
        license     = $License
        created     = (Get-Date).ToString("o")
        updated     = (Get-Date).ToString("o")
    } | ConvertTo-Json -Depth 5 | Set-Content -Path (Join-Path $target "skill.json") -Encoding UTF8

    Write-SkillProvenance -Path $target -Source "local" -Note "Package scaffold created"

    Write-Verbose "Skill package '$Name' created at '$target'"
}

function Write-SkillProvenance {
    <#
    .SYNOPSIS
        Appends a provenance record to a skill package's .provenance file.

    .DESCRIPTION
        Writes one JSON object per line (JSON Lines / NDJSON). The file as a
        whole is never valid single-document JSON by design — read it back
        line by line and parse each line independently. The Copilot draft
        mixed a bare text line from New-SkillPackage with raw appended JSON
        blobs from this function, which is neither readable text nor valid
        JSON once combined.

    .PARAMETER Path
        The path to the skill package directory.

    .PARAMETER Source
        The upstream repository URL, or "local" for locally authored skills.

    .PARAMETER Commit
        The commit hash the skill was extracted from, if known.

    .PARAMETER Note
        Free-text note describing this provenance event.

    .EXAMPLE
        Write-SkillProvenance -Path "./skills/wsl" -Source "https://github.com/user/repo" -Commit "abc123"
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Path,

        [Parameter(Mandatory)]
        [string]$Source,

        [Parameter()]
        [string]$Commit,

        [Parameter()]
        [string]$Note
    )

    $entry = [ordered]@{
        timestamp = (Get-Date).ToString("o")
        source    = $Source
        commit    = $Commit
        note      = $Note
    } | ConvertTo-Json -Compress

    Add-Content -Path (Join-Path $Path ".provenance") -Value $entry -Encoding UTF8
    Write-Verbose "Provenance recorded for '$Path'"
}
