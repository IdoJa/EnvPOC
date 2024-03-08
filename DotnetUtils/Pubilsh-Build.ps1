function Publish-Build {
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
        PS> # Receives the solution or project located in "MyFirstSolutionOrProjectPath" with the build configuration of "Release" and the environment of "dev", and publishes it to Azure for "dev" environment.
        PS> Publish-Build -Path "MyFirstSolutionOrProjectPath" -Env dev

        .EXAMPLE
        PS> # Receives the solution or project located in "MySecondSolutionOrProjectPath" with the build configuration of "Debug" and the environment of "prod", and publishes it to Azure for "prod" environment.
        PS> Publish-Build -Path "MySecondSolutionOrProjectPath" -Env prod -Configuration Debug
    #>

    param (
        [parameter(mandatory)][string]$Path,
        [parameter(mandatory)][string]$Env,
        [parameter()][ValidateSet('Release', 'Debug')][string]$Configuration = 'Release'
    )

    # Find the path to the $Env.pubxml of the publish profile to use.
    # Verify `$publishProfilePath` is not null.
    $publishProfilePath = Get-ChildItem -Path . -Filter *.$Env.pubxml -Recurse -ErrorAction SilentlyContinue -Force -Name
    if (!$publishProfilePath) 
    {
        Write-Host "File with $Env.pubxml extension was not found in the current directory."
    }

    # Execute publish to Azure.
    dotnet publish "$Path" --no-build -c $Configuration /p:PublishProfile="$publishProfilePath"
}
