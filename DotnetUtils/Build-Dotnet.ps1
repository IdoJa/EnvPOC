function Build-Dotnet {
    <#
        .SYNOPSIS
        Builds a solution or project according to a given path, and environment
        parameter, and build configuration.

        .DESCRIPTION
        1. Finds the appsettings of the given solution path, and changes its
           `Environment` key value to the given environemnt parameter.
        2. Builds the solution or project to the given build configuration.

        .PARAMETER Path
        Specify the target solution or project path to build.

        .PARAMETER Env
        Specify the target environment to build.

        .PARAMETER Configuration
        Specify the target build configuration to pubilsh the build for.
        May be `Release` or `Debug`. The default value is `Debug`.

        .EXAMPLE
        PS> # Builds the solution which is located at "path\to\dotnet\solution.sln" for "dev" environment, with the build configuration of "Debug".
        PS> Build-Dotnet -Path "path\to\dotnet\solution.sln" -Env dev

        .EXAMPLE
        PS> # Builds the project which is located at "path\to\dotnet\project.csproj" for "prod" environment, with the build configuration of "Release".
        PS> Build-Dotnet -Path "path\to\dotnet\project.csproj" -Env prod -Configuration Release
    #>

    param (
        [parameter(mandatory)][string]$Path,
        [parameter(mandatory)][string]$Env,
        [parameter()][ValidateSet('Release', 'Debug')][string]$Configuration = 'Debug'
    )

    # Find the path to the appsettings.json of the source code.
    $solutionOrProjectDirectoryPath = (Get-Item "$Path").Directory.FullName
    $appsettingsRelativePath = Get-ChildItem -Path "$solutionOrProjectDirectoryPath" -Filter appsettings.json -Recurse -ErrorAction SilentlyContinue -Force -Name |  Where { $_ -NotMatch "bin" } | Where { $_ -NotMatch "obj" }
    if (!$appsettingsRelativePath)
    {
        Write-Host "An 'appsettings.json' file was not found within the path of '$solutionOrProjectDirectoryPath' or its subdirectories."
        [Environment]::Exit(1)
    }

    # Read appsettings.json to `$appsettings`.
    $appsettingsPath = Join-Path -Path "$solutionOrProjectDirectoryPath" -ChildPath "$appsettingsRelativePath"
    $appsettings = Get-Content -Path "$appsettingsPath" -Raw | ConvertFrom-Json

    # Set the Environemnt key of `$appsettings` the given `$Env` parameter.
    $appsettings.Environment = $Env

    # Overwrite `$appsettings` to appsettings.json.
    $appsettings | ConvertTo-Json | Set-Content -Path "$appsettingsPath"

    Write-Host "Building with"
    Write-Host "Environment: $($appsettings.Environment)" 
    Write-Host "Configuration: $Configuration"

    # Build solution.
    dotnet build "$Path" -c $Configuration
}
