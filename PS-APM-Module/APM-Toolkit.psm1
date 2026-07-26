# APMToolkit.psm1
# Root module that imports and re-exports GitHelpers, PackagingHelpers, SkillHelpers.

$moduleRoot = $PSScriptRoot

# Import submodules
Import-Module (Join-Path $moduleRoot "GitHelpers.psm1") -Force
Import-Module (Join-Path $moduleRoot "PackagingHelpers.psm1") -Force
Import-Module (Join-Path $moduleRoot "SkillHelpers.psm1") -Force

# Export all public functions from submodules
Export-ModuleMember -Function * -Alias *
