@{
    RootModule        = 'PackagingHelpers.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = 'e3b2c4f1-9a22-4c5d-8b1e-abcdef123456'
    Author            = 'Michael'
    CompanyName       = 'APM Toolkit'
    Description       = 'Packaging helpers for APM agentic skill development.'
    PowerShellVersion = '7.0'
    FunctionsToExport = @(
        'New-SkillPackage',
        'Write-SkillProvenance'
    )
    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()
}
