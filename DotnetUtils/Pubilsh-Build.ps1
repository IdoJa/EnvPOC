function Publish-Build {
    <#
        .SYNOPSIS
        Publishes a build to Azure, according to a given build path, and environment
        parameter.

        .PARAMETER Path
        Specify the target build path to publish to Azure.

        .PARAMETER Env
        Specify the target environment to pubilsh the build for.

        .EXAMPLE
        PS> # Publishes to Azure, the build which is located at "MyFirstBuildPath" for "dev" environment.
        PS> Publish-Build -Path "MyFirstBuildPath" -Env dev

        .EXAMPLE
        PS> # Publishes to Azure, the build which is located at "MySecondBuildPath" for "prod" environment.
        PS> Publish-Build -Path "MySecondBuildPath" -Env prod
    #>

    param (
        [parameter(mandatory)][string]$Path,
        [parameter(mandatory)][string]$Env
    )

    # Save current path, and navigate to the given solution path.
    $currentPath = $(Get-Location).Path
    cd $Path

    # Do something...

    # Restore the original path.
    cd $currentPath
}
