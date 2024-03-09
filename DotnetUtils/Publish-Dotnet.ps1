function Publish-Dotnet {
    <#
        .SYNOPSIS
        Publishes a given build to Azure, according to a given solution or project
        path, environment parameter, and build configuration.

        .PARAMETER Path
        Specify the target solution or project path to publish to Azure, which
        has already been built with the same `$Configuration` as this function.

        .PARAMETER Env
        Specify the target environment to pubilsh the build for.

        .PARAMETER Configuration
        Specify the target build configuration to pubilsh the build for.
        May be `Release` or `Debug`. The default value is `Release`.

        .EXAMPLE
        PS> # Receives the solution located in "path\to\dotnet\solution.sln" with the build configuration of "Release" and the environment of "dev", and publishes it to Azure for "dev" environment.
        PS> Publish-Dotnet -Path "path\to\dotnet\solution.sln" -Env dev

        .EXAMPLE
        PS> # Receives the project located in "path\to\dotnet\project.csproj" with the build configuration of "Debug" and the environment of "prod", and publishes it to Azure for "prod" environment.
        PS> Publish-Dotnet -Path "path\to\dotnet\project.csproj" -Env prod -Configuration Debug
    #>

    param (
        [parameter(mandatory)][string]$Path,
        [parameter(mandatory)][string]$Env,
        [parameter()][ValidateSet('Release', 'Debug')][string]$Configuration = 'Release'
    )

    # Find the path to the $Env.pubxml of the publish profile to use.
    $solutionOrProjectDirectoryPath = (Get-Item "$Path").Directory.FullName
    $publishProfileRelativePath = Get-ChildItem -Path "$solutionOrProjectDirectoryPath" -Filter *.$Env.pubxml -Recurse -ErrorAction SilentlyContinue -Force -Name
    if (!$publishProfileRelativePath)
    {
        Write-Host "A file with '$Env.pubxml' extension was not found within the path of '$solutionOrProjectDirectoryPath' or its subdirectories."
        [Environment]::Exit(1)
    }

    $publishProfilePath = Join-Path -Path "$solutionOrProjectDirectoryPath" -ChildPath "$publishProfileRelativePath"

    # Execute publish to Azure.
    dotnet publish "$Path" --no-build -c $Configuration /p:PublishProfile="$publishProfilePath"
}
