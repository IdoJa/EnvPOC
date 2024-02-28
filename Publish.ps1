<#
    .DESCRIPTION
    A script that builds multiple solutions according to the given environment
    parameter, and then publishes it to Azure.

    .PARAMETER Env
    Specify the target environment to build and publish the solutions for.

    .EXAMPLE
    PS> # Builds the solutions for "dev" environment, and then publishes to Azure.
    PS> .\Publish -Env dev

    .EXAMPLE
    PS> # Builds the solutions for "prod" environment, and then publishes to Azure.
    PS> .\Publish -Env prod
#>

param (
    [parameter(mandatory)][string]$Env
)

.\Build.ps1 -Env $Env
