function Build-Solution {
    <#
        .SYNOPSIS
        Builds a solution or project according to a given path, and environment
        parameter, and build configuration.

        .DESCRIPTION
        1. Finds the appsettings of the given solution path, and changes its
           `Environment` key value to the given environemnt parameter.
        2. Builds the solution to the given build configuration.

        .PARAMETER Path
        Specify the target solution path to build the solution for.

        .PARAMETER Env
        Specify the target environment to build the solution for.

        .PARAMETER Configuration
        Specify the target build configuration to pubilsh the build for.
        May be `Release` or `Debug`. The default value is `Debug`.

        .EXAMPLE
        PS> # Builds the solution or project which is located at "MyFirstSolutionOrProjectPath" for "dev" environment, with the build configuration of "Debug".
        PS> Build-Solution -Path "MyFirstSolutionOrProjectPath" -Env dev

        .EXAMPLE
        PS> # Builds the solution or project which is located at "MyFirstSecondSolutionPath" for "prod" environment, with the build configuration of "Release".
        PS> Build-Solution -Path "MyFirstSecondSolutionPath" -Env prod -Configuration Release
    #>

    param (
        [parameter(mandatory)][string]$Path,
        [parameter(mandatory)][string]$Env,
        [parameter()][ValidateSet('Release', 'Debug')][string]$Configuration = "Debug",
    )

    # Find the path to the appsettings.json of the source code.
    $appsettingsPath = Get-ChildItem -Path "$Path" -Filter appsettings.json -Recurse -ErrorAction SilentlyContinue -Force -Name |  Where { $_ -NotMatch "bin" } | Where { $_ -NotMatch "obj" }

    # Read appsettings.json to `$appsettings`.
    $appsettings = Get-Content -Path "$appsettingsPath" -Raw | ConvertFrom-Json

    # Set the Environemnt key of `$appsettings` the given `$Env` parameter.
    $appsettings.Environment = $Env

    # Overwrite `$appsettings` to appsettings.json.
    $appsettings | ConvertTo-Json | Set-Content -Path "$appsettingsPath"

    Write-Host "Building with"
    Write-Host "Environment: $($appsettings.Environment)" 

    # Build solution.
    dotnet build "$Path" -c $Configuration
}
