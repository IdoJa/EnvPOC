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


# Rewrite appsettings.json with the given parameter.

# Build EnvPOC1
cd EnvPOC1
dotnet build
cd ..

# Build EnvPOC2
cd EnvPOC2
dotnet build
cd ..
