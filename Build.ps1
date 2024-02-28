<#
    .DESCRIPTION
    A script that builds multiple solutions according to the given environment
    parameter.

    .PARAMETER Env
    Specify the target environment to build the solutions for.

    .EXAMPLE
    PS> # Builds the solutions for "dev" environment.
    PS> .\Build -Env dev

    .EXAMPLE
    PS> # Builds the solutions for "prod" environment.
    PS> .\Build -Env prod
#>

param (
    [parameter(mandatory)][string]$Env
)

# ----------------------------------- Imports ---------------------------------

. "$PSScriptRoot\Build-Solution.ps1"
. "$PSScriptRoot\Utils.ps1"

# ------------------------------------ Code -----------------------------------

Build-Solution -Path "EnvPOC1" -Env $Env
Build-Solution -Path "EnvPOC2" -Env $Env

PressAnyKeyToContinue
