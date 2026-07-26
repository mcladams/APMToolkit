# SkillHelpers.psm1
# Microsoft-style module: reusable functions only. No script-level execution.

function Get-SkillMetadata {
    <#
    .SYNOPSIS
        Reads and returns metadata from a skill package.

    .DESCRIPTION
        Loads skill.json, LICENSE, SKILL.md, and the .provenance history
        (parsed as an array of JSON-Lines records) from a skill directory.

    .PARAMETER Path
        Path to the skill package directory.

    .EXAMPLE
        Get-SkillMetadata -Path "./skills/windows-wsl-coordination"
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Path
    )

    if (-not (Test-Path $Path)) {
        throw "Skill path '$Path' does not exist."
    }

    $metadata = [ordered]@{
        Path       = $Path
        Manifest   = $null
        License    = $null
        SkillText  = $null
        Provenance = @()
    }

    $manifestPath = Join-Path $Path "skill.json"
    if (Test-Path $manifestPath) {
        $metadata.Manifest = Get-Content $manifestPath -Raw | ConvertFrom-Json -AsHashtable
    }

    $licensePath = Join-Path $Path "LICENSE"
    if (Test-Path $licensePath) {
        $metadata.License = Get-Content $licensePath -Raw
    }

    $skillPath = Join-Path $Path "SKILL.md"
    if (Test-Path $skillPath) {
        $metadata.SkillText = Get-Content $skillPath -Raw
    }

    $provPath = Join-Path $Path ".provenance"
    if (Test-Path $provPath) {
        $metadata.Provenance = Get-Content $provPath | Where-Object { $_.Trim() } | ForEach-Object {
            try { $_ | ConvertFrom-Json -AsHashtable } catch { @{ raw = $_ } }
        }
    }

    [pscustomobject]$metadata
}

function New-SkillManifest {
    <#
    .SYNOPSIS
        Generates or updates a skill.json manifest.

    .DESCRIPTION
        Creates a new manifest or updates an existing one with required
        fields, including license.

        Loads existing JSON with -AsHashtable rather than the default
        PSCustomObject. The Copilot draft used plain ConvertFrom-Json, then
        did `$manifest.updated = (Get-Date)`. That throws
        "The property 'updated' cannot be found on this object. Verify that
        the property exists and can be set." the first time it runs against
        a manifest that doesn't already have an 'updated' key — which is
        exactly what happens when New-SkillManifest is run against a
        skill.json that New-SkillPackage created, since PSCustomObject
        (unlike a hashtable) won't let you add a brand-new property via dot
        assignment; it needs Add-Member. Reading with -AsHashtable sidesteps
        the whole problem, since hashtable keys can be added freely.

    .PARAMETER Path
        Path to the skill package directory.

    .PARAMETER Name
        Name of the skill (optional if manifest exists).

    .PARAMETER Description
        Description of the skill.

    .PARAMETER License
        SPDX license identifier.

    .PARAMETER Version
        Version string (default: 1.0.0).

    .EXAMPLE
        New-SkillManifest -Path "./skills/wsl" -Name "windows-wsl-coordination" -Description "WSL coordination skill" -License "GPL-3.0"
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Path,

        [Parameter()]
        [string]$Name,

        [Parameter()]
        [string]$Description,

        [Parameter()]
        [string]$License,

        [Parameter()]
        [string]$Version = "1.0.0"
    )

    if (-not (Test-Path $Path)) {
        throw "Skill path '$Path' does not exist."
    }

    $manifestPath = Join-Path $Path "skill.json"

    if (Test-Path $manifestPath) {
        $manifest = Get-Content $manifestPath -Raw | ConvertFrom-Json -AsHashtable
    }
    else {
        $manifest = [ordered]@{}
    }

    if ($Name)        { $manifest.name        = $Name }
    if ($Description) { $manifest.description = $Description }
    if ($License)     { $manifest.license      = $License }
    $manifest.version = $Version
    $manifest.updated = (Get-Date).ToString("o")

    $manifest | ConvertTo-Json -Depth 10 | Set-Content -Path $manifestPath -Encoding UTF8
    Write-Verbose "Manifest updated at '$manifestPath'"
}

function Test-SkillStructure {
    <#
    .SYNOPSIS
        Validates the structural integrity of a skill package.

    .DESCRIPTION
        Ensures SKILL.md, LICENSE, skill.json, and .provenance exist, and
        that the manifest carries the required fields (including license).

        This is now the single validator for the toolkit. The Copilot draft
        had a near-identical Test-SkillPackage in PackagingHelpers; that
        duplicate is removed so there's one place to update when the rules
        change, rather than two copies quietly diverging.

        Returns a structured [pscustomobject] rather than a bare $true/$false,
        so callers get machine-readable detail (which files, which fields)
        instead of having to scrape Write-Warning text. This also matters if
        these functions end up wrapped by an MCP server later: tool results
        need structured data, not console warnings.

    .PARAMETER Path
        Path to the skill package directory.

    .EXAMPLE
        Test-SkillStructure -Path "./skills/wsl"
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Path
    )

    if (-not (Test-Path $Path)) {
        throw "Skill path '$Path' does not exist."
    }

    $requiredFiles = @("SKILL.md", "LICENSE", "skill.json", ".provenance")
    $missingFiles = $requiredFiles | Where-Object { -not (Test-Path (Join-Path $Path $_)) }

    $missingFields = @()
    $manifestPath = Join-Path $Path "skill.json"
    if (Test-Path $manifestPath) {
        $manifest = Get-Content $manifestPath -Raw | ConvertFrom-Json -AsHashtable
        $requiredFields = @("name", "version", "description", "license")
        $missingFields = $requiredFields | Where-Object { -not $manifest[$_] }
    }

    $isValid = ($missingFiles.Count -eq 0) -and ($missingFields.Count -eq 0)

    if (-not $isValid) {
        if ($missingFiles.Count -gt 0)  { Write-Warning "Missing required files: $($missingFiles -join ', ')" }
        if ($missingFields.Count -gt 0) { Write-Warning "Manifest missing fields: $($missingFields -join ', ')" }
    }
    else {
        Write-Verbose "Skill structure at '$Path' is valid."
    }

    [pscustomobject]@{
        Path          = $Path
        IsValid       = $isValid
        MissingFiles  = $missingFiles
        MissingFields = $missingFields
    }
}

function Convert-SkillToAgentFormat {
    <#
    .SYNOPSIS
        Converts a skill package into agent-ready metadata.

    .DESCRIPTION
        Reads SKILL.md and skill.json, extracts headings, summary, name and
        license, and emits structured metadata for agentic workflows.

    .PARAMETER Path
        Path to the skill package directory.

    .EXAMPLE
        Convert-SkillToAgentFormat -Path "./skills/wsl"
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Path
    )

    $skillPath = Join-Path $Path "SKILL.md"
    if (-not (Test-Path $skillPath)) {
        throw "SKILL.md not found at '$Path'"
    }

    $text = Get-Content $skillPath -Raw
    $headings = ($text -split "`n") | Where-Object { $_ -match '^#' }

    $manifestPath = Join-Path $Path "skill.json"
    $manifest = if (Test-Path $manifestPath) {
        Get-Content $manifestPath -Raw | ConvertFrom-Json -AsHashtable
    } else { @{} }

    [pscustomobject]@{
        name      = $manifest["name"]
        license   = $manifest["license"]
        headings  = $headings
        summary   = ($text -split "`n")[0]
        generated = (Get-Date).ToString("o")
    }
}
