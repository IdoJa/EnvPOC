<#
    .DESCRIPTION
    A script that builds multiple solutions or projects according to the given
    environment parameter.

    .PARAMETER Env
    Specify the target environment to build the solutions for.

    .PARAMETER Continue
    Set the `-Continue` option, to not prompt the "Press any key to continue..."
    message at the end of the script.

    .EXAMPLE
    PS> # Builds the solutions or projects for "dev" environment.
    PS> .\Build -Env dev

    .EXAMPLE
    PS> # Builds the solutions or projects for "prod" environment, and does not prompt the "Press any key to continue..." message at the end of the script.
    PS> .\Build -Env prod -Continue
#>

param (
    [parameter(mandatory)][string]$Env,
    [parameter()][switch]$Continue
)

# ----------------------------------- Imports ---------------------------------

. "$PSScriptRoot\DotnetUtils\Build-Solution.ps1"
. "$PSScriptRoot\DotnetUtils\Utils.ps1"

# ------------------------------------ Code -----------------------------------

Build-Solution -Path "EnvPOC1" -Env $Env
Build-Solution -Path "EnvPOC2" -Env $Env

if ($Continue -eq $false)
{
    PressAnyKeyToContinue
}
