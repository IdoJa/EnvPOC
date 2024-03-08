function Publish-Build {
    <#
        .SYNOPSIS
        Builds and publishes to Azure, according to a given solution or project
        path, environment parameter, and build configuration.

        .PARAMETER Path
        Specify the target solution or project or project path to build and publish to Azure.

        .PARAMETER Env
        Specify the target environment to pubilsh the build for.

        .PARAMETER Configuration
        Specify the target build configuration to pubilsh the build for.
        May be `Release` or `Debug`. The default value is `Release`.

        .EXAMPLE
        PS> # Builds the solution or project located in "MyFirstSolutionOrProjectPath" with the configuration of "Release" and the environment of "dev", and publishes to Azure for "dev" environment.
        PS> Publish-Build -Path "MyFirstSolutionOrProjectPath" -Env dev

        .EXAMPLE
        PS> # Builds the solution or project located in "MySecondSolutionOrProjectPath" with the configuration of "Debug" and the environment of "prod", and publishes to Azure for "prod" environment.
        PS> Publish-Build -Path "MySecondSolutionOrProjectPath" -Env prod -Configuration Debug
    #>

    param (
        [parameter(mandatory)][string]$Path,
        [parameter(mandatory)][string]$Env,
        [parameter()][ValidateSet('Release', 'Debug')][string]$Configuration = "Release",
    )

    # Find the path to the $Env.pubxml of the publish profile to use.
    # Verify `$publishProfilePath` is not null.
    $publishProfilePath = Get-ChildItem -Path . -Filter *.$Env.pubxml -Recurse -ErrorAction SilentlyContinue -Force -Name
    if (!$publishProfilePath) 
    {
        Write-Host "File with $Env.pubxml extension was not found in the current directory."
    }

    # Read `publish.config` env variables.
    Get-Content publish.config | ForEach {
        $name, $value = $_.Split('=')
        Set-Content env:\$name $value
    }

    # Get the first user password from the $publishProfilePath.
    $userPWD = Select-Xml -Path "$publishProfilePath" -XPath '/publishData/publishProfile' | Select -First 1 | ForEach-Object { $_.Node.userPWD }

    # Execute build and publish to Azure.
    . "$env:MSBUILD_PATH" "$Path" /p:DeployOnBuild=true /p:PublishProfile="$publishProfilePath" /p:Configuration=$Configuration /p:Password=$userPWD
}
