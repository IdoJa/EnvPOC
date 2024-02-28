# EnvPOC

Build & Publish Multiple Dotnet Solutions To Azure.

## Stage 1: Seperate appsettings.json to 4 files

> See [guide](https://biswakalyan-das.medium.com/multiple-appsettings-json-in-net-core-without-using-an-environment-variable-d4161c4b56bc) 

> ### Prerequisites
> - TODO: for projects that have multiple settings that needs to be changed for the build example Credentials.cs (on Security) will be merged to appsettings

Seperate appsettings.json to 4 files
do this for security and gmt

- appsettings.dev.json

- appsettings.test.json

- appsettings.prod.json

- appsettings.local-dev.json

do this for Security & GMT

## Stage 2: CD

> ### Prerequisites
> save the password of publish to azure on PC or env file

Write script that changes all the appsettings environment to the desired environment
and builds the solutions and publishes to Azure (only if the desired environment is "azure" based (i.e. dev, test, prod))

Params: build & publish,
Use cases for params examples:
- GMT have changes, but Security doesnt have changes, build & publish for GMT only
- Both Security & GMT has changes, build & publish both

### Execute Inline Without Cloning

```ps1
& ([scriptblock]::Create((iwr "https://raw.githubusercontent.com/IdoJa/EnvPOC/master/Build.ps1" -useb))) -Env <String>
```

### Execute Offline

#### By CLI

```ps1
powershell.exe -NoLogo -ExecutionPolicy Bypass -Command .\Build.ps1 -Env <String>
```

#### By GUI

RightClick on the PowerShell script -> Run with PowerShell

![](https://i.imgur.com/ENrlHF7.png)

> References:
> - [Using Windows PowerShell scripts to publish to dev and test environments in Azure](https://learn.microsoft.com/en-us/visualstudio/azure/vs-azure-tools-publishing-using-powershell-scripts?view=vs-2022)
> - [how-to-deploy-a-net-web-app-to-azure-using-powershell](https://stackoverflow.com/a/40702390)

### Help

To view the full documentation of the script, run:

```
powershell.exe -NoLogo -ExecutionPolicy Bypass -Command Get-Help .\Build.ps1 -Full
```
