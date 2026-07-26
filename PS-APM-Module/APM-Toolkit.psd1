@{
    RootModule        = 'APMToolkit.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = 'a1b2c3d4-e5f6-7890-abcd-1234567890ff'
    Author            = 'Michael'
    CompanyName       = 'APM Toolkit'
    Description       = 'Agentic PowerShell Module for skill packaging, provenance, and Git-based extraction.'
    FunctionsToExport = '*'
    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()
    PrivateData       = @{
        PSData = @{
            Tags = @('agentic', 'skills', 'apm', 'automation', 'toolkit')
            LicenseUri = 'https://opensource.org/licenses/MIT'
            ProjectUri = 'https://github.com/yourrepo/APMToolkit'
        }
    }
}
