@{
    RootModule        = 'SkillHelpers.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = 'f2a3b4c5-d6e7-4890-9abc-123456789def'
    Author            = 'Michael'
    CompanyName       = 'APM Toolkit'
    Description       = 'Skill helper functions for APM agentic development.'
    PowerShellVersion = '7.0'
    FunctionsToExport = @(
        'Get-SkillMetadata',
        'New-SkillManifest',
        'Test-SkillStructure',
        'Convert-SkillToAgentFormat'
    )
    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()
}
