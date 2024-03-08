<#
    .DESCRIPTION
    A script that builds multiple solutions or projects according to the given
    environment parameter, and build configuration.

    .PARAMETER Env
    Specify the target environment to build the solutions for.

    .PARAMETER Configuration
    Specify the target build configuration to pubilsh the build for.
    May be `Release` or `Debug`. The default value is `Release`.

    .PARAMETER Continue
    Set the `-Continue` option, to not prompt the "Press any key to continue..."
    message at the end of the script.

    .EXAMPLE
    PS> # Builds the solutions or projects for "dev" environment, with the build configuration of "Debug".
    PS> .\Build -Env dev

    .EXAMPLE
    PS> # Builds the solutions or projects for "prod" environment, with the build configuration of "Release", and does not prompt the "Press any key to continue..." message at the end of the script.
    PS> .\Build -Env prod -Configuration Release -Continue
#>

param (
    [parameter(mandatory)][string]$Env,
    [parameter()][ValidateSet('Release', 'Debug')][string]$Configuration = 'Debug',
    [parameter()][switch]$Continue
)

# ----------------------------------- Imports ---------------------------------

. "$PSScriptRoot\DotnetUtils\Build-Solution.ps1"
. "$PSScriptRoot\DotnetUtils\Utils.ps1"

# ------------------------------------ Code -----------------------------------

Build-Solution -Path "EnvPOC1" -Env $Env -Configuration $Configuration
Build-Solution -Path "EnvPOC2" -Env $Env -Configuration $Configuration

if ($Continue -eq $false)
{
    PressAnyKeyToContinue
}
