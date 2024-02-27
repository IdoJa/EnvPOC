<#
  .DESCRIPTION
  A script that builds multiple solutions according to the given environment parameter.

  .PARAMETER Env
  Specify the target environment to build the solutions for.

  .EXAMPLE
  PS> # Builds the solutions for "dev" environment.
  PS> .\build -Env dev

  .EXAMPLE
  PS> # Builds the solutions for "prod" environment.
  PS> .\build -Env prod
#>

param (
    [parameter(mandatory)][string]$Env
)


### Rewrite appsettings.json with the given parameter.

cd EnvPOC1

# Read appsettings.json to `$appsettings`.
$appsettings = Get-Content -Path EnvPOC\appsettings.json -Raw | ConvertFrom-Json

# Deep copy `$appsettings` to `$appsettingsTemp`.
$appsettingsTemp = $appsettings | ConvertTo-Json | ConvertFrom-Json

# Set the Environemnt key of `$appsettings` the given `$Env` parameter.
$appsettings.Environment = $Env

Write-Output $appsettingsTemp
Write-Output $appsettings

# Overwrite `$appsettings` to appsettings.json.
$appsettings | ConvertTo-Json | Set-Content -Path EnvPOC\appsettings.json

# Build EnvPOC1
dotnet build

# Restore appsettings.json to its original state
$appsettingsTemp | ConvertTo-Json | Set-Content -Path EnvPOC\appsettings.json

cd ..






# Build EnvPOC2
cd EnvPOC2
dotnet build
cd ..
