<#
    .DESCRIPTION
    A script that builds multiple solutions or projects according to the given
    environment parameter and build configuration, and then publishes them to Azure.

    .PARAMETER Env
    Specify the target environment to build and publish the solutions or
    projects for.

    .PARAMETER Configuration
    Specify the target build configuration to pubilsh the build for.
    May be `Release` or `Debug`. The default value is `Release`.

    .PARAMETER Continue
    Set the `-Continue` option, to not prompt the "Press any key to continue..."
    message at the end of the script.

    .EXAMPLE
    PS> # Builds the solutions or projects for "dev" environment, with the build configuration of "Debug", and then publishes to Azure.
    PS> .\Publish -Env dev -Configuration Debug

    .EXAMPLE
    PS> # Builds the solutions or projects for "prod" environment, with the build configuration of "Release", and then publishes to Azure, and does not prompt the "Press any key to continue..." message at the end of the script.
    PS> .\Publish -Env prod -Continue
#>

param (
    [parameter(mandatory)][string]$Env,
    [parameter()][ValidateSet('Release', 'Debug')][string]$Configuration = "Release",
    [parameter()][switch]$Continue
)

# ----------------------------------- Imports ---------------------------------

. "$PSScriptRoot\DotnetUtils\Publish-Build.ps1"
. "$PSScriptRoot\DotnetUtils\Utils.ps1"

# ------------------------------------ Code -----------------------------------

.\Build.ps1 -Env $Env -Configuration $Configuration -Continue

Publish-Build -Path "EnvPOC2" -Env $Env

if ($Continue -eq $false)
{
    PressAnyKeyToContinue
}
