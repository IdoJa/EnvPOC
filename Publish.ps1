<#
    .DESCRIPTION
    A script that builds multiple solutions according to the given environment
    parameter, and then publishes it to Azure.

    .PARAMETER Env
    Specify the target environment to build and publish the solutions for.

    .PARAMETER Continue
    Set the `-Continue` option, to not prompt the "Press any key to continue..."
    message at the end of the script.

    .EXAMPLE
    PS> # Builds the solutions for "dev" environment, and then publishes to Azure.
    PS> .\Publish -Env dev

    .EXAMPLE
    PS> # Builds the solutions for "prod" environment, and then publishes to Azure, and does not prompt the "Press any key to continue..." message at the end of the script.
    PS> .\Publish -Env prod -Continue
#>

param (
    [parameter(mandatory)][string]$Env,
    [parameter()][switch]$Continue
)

# ----------------------------------- Imports ---------------------------------

. "$PSScriptRoot\DotnetUtils\Publish-Build.ps1"
. "$PSScriptRoot\DotnetUtils\Utils.ps1"

# ------------------------------------ Code -----------------------------------

.\Build.ps1 -Env $Env -Continue

Publish-Build -Path "PATH_OF_BUILD_TO_PUBLISH" -Env $Env

if ($Continue -eq $false)
{
    PressAnyKeyToContinue
}
