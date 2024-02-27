<#
    .SYNOPSIS
    Builds a solution according to a given solution path, and environment
    parameter.

    .DESCRIPTION
    1. Finds the appsettings of the given solution path, and changes its
        `Environment` key value, by the given environemnt parameter.
    2. Builds the solution.
    3. Restores the appsettings to its original state.

    .PARAMETER Path
    Specify the target solution path to build the solution for.

    .PARAMETER Env
    Specify the target environment to build the solution for.

    .EXAMPLE
    PS> # Builds the solution which is located at "MyFirstSolutionPath" for "dev" environment.
    PS> Build-Solution -Path "MyFirstSolutionPath" -Env dev

    .EXAMPLE
    PS> # Builds the solution which is located at "MyFirstSecondSolutionPath" for "prod" environment.
    PS> Build-Solution -Path "MyFirstSecondSolutionPath" -Env prod
#>

param (
    [parameter(mandatory)][string]$Path,
    [parameter(mandatory)][string]$Env
)

function Build-Solution {
    param (
        [parameter(mandatory)][string]$Path,
        [parameter(mandatory)][string]$Env
    )

    # Save current path, and navigate to the given solution path.
    $currentPath = $(Get-Location).Path
    cd $Path

    # Find the path to the appsettings.json of the source code.
    $appsettingsPath = Get-ChildItem -Path . -Filter appsettings.json -Recurse -ErrorAction SilentlyContinue -Force -Name |  Where { $_ -NotMatch "bin" } | Where { $_ -NotMatch "obj" }

    # Read appsettings.json to `$appsettings`.
    $appsettings = Get-Content -Path $appsettingsPath -Raw | ConvertFrom-Json

    # Deep copy `$appsettings` to `$appsettingsTemp`.
    $appsettingsTemp = $appsettings | ConvertTo-Json | ConvertFrom-Json

    # Set the Environemnt key of `$appsettings` the given `$Env` parameter.
    $appsettings.Environment = $Env

    # Overwrite `$appsettings` to appsettings.json.
    $appsettings | ConvertTo-Json | Set-Content -Path $appsettingsPath

    # Build solution.
    dotnet build

    # Restore appsettings.json to its original state.
    $appsettingsTemp | ConvertTo-Json | Set-Content -Path $appsettingsPath

    # Restore the original path.
    cd $currentPath
}

Build-Solution -Path $Path -Env $Env
