<#
    .DESCRIPTION
    A script that builds multiple solutions according to the given environment
    parameter.

    .PARAMETER Env
    Specify the target environment to build the solutions for.

    .EXAMPLE
    PS> # Builds the solutions for "dev" environment.
    PS> .\build -Env dev

    .EXAMPLE
    PS> # Builds the solutions for "prod" environment.
    PS> .\build -Env prod
#>

param (
    [parameter(mandatory)][string]$Env
)

.\build-solution.ps1 -Path "EnvPOC1" -Env $Env
.\build-solution.ps1 -Path "EnvPOC2" -Env $Env
