# EnvPOC

Build & Publish Multiple Dotnet Solutions Or Projects To Azure.

## Stage 1: Create a seperate appsettings.json for every environment

> See [Guide](https://biswakalyan-das.medium.com/multiple-appsettings-json-in-net-core-without-using-an-environment-variable-d4161c4b56bc)

1. Add `appsettings.json` in the path of your `.csproj`, with the following format:

   ```json
   {
       "Environment":  "dev"
   }
   ```

   and add it to `.gitignore`.

1. For each environment, create a new file in the path of your `.csproj`, with the naming format of `appsettings.<environment>.json`.

   **For example:**

   In case you have the following environments:

   - `dev`
   - `test`
   - `prod`
   - `dev-local`

   Then you represent them with the corresponding files:

   - `appsettings.dev.json`
   - `appsettings.test.json`
   - `appsettings.prod.json`
   - `appsettings.dev-local.json`
   
   Each file bundles the settings for each environment.

## Stage 2: CI - [Build.ps1](/Build.ps1)

The [Build.ps1](/Build.ps1) script changes the `appsettings.json`'s `Environment` key of pre-defined solutions or projects to a desired environment, and builds them.

### Edit the script to your needs

In [Build.ps1](/Build.ps1), starting from line 39, set / add `Build-Dotnet` command lines to match the building execution order of your needs, where only the `-Path` parameter is editable.

**For example:**

```ps1
Build-Dotnet -Path "path\to\dotnet\solution.sln" -Env $Env -Configuration $Configuration
Build-Dotnet -Path "path\to\dotnet\project.csproj" -Env $Env -Configuration $Configuration
...
```

### Usage

#### By CLI

```ps1
PowerShell.exe -NoLogo -ExecutionPolicy Bypass -Command .\Build.ps1 -Env <String> [-Configuration <Debug | Release>]
```

![](https://i.imgur.com/G313A2b.gif)

#### By GUI

RightClick on the PowerShell script -> Run with PowerShell

![](https://i.imgur.com/0sDaK0h.png)

### Help

To view the full documentation of the script, run:

```ps1
PowerShell.exe -NoLogo -ExecutionPolicy Bypass -Command Get-Help .\Build.ps1 -Full
```

## Stage 3: CD - [Publish.ps1](/Publish.ps1)

The [Publish.ps1](/Publish.ps1) script builds pre-defined solutions or projects stated in [Build.ps1](/Build.ps1), and then publishes those solutions or projects to a particular Azure desired environment, using a corresponding publish profile `*.<environment>.pubxml`.

1. For each environment you wish to publish, you are required to attach a `.pubxml` file (exported from Azure), that states the settings for publishing it.
   There are several ways to get it. The most obvious one is to get it from the portal by navigating to the blade of your Web app and then clicking on "More" and finally on "Get publish profile".

   ![](https://i.stack.imgur.com/mFpdx.png)

1. For each environment you wish to publish, export its `.pubxml` file from Azure, and save it to the same path as of [Publish.ps1](/Publish.ps1) (or an inner directory in that path), with the naming format of `your-publish-profile-name.<environment>.pubxml`.

   **For example:**

   In case you have the following environments:

   - `dev`
   - `test`
   - `prod`
   - `dev-local`

   Then you represent them with the corresponding files:

   - `my-publish-profile.dev.pubxml`
   - `publish-profiles/my-publish-profile2.dev.pubxml`
   - `publish-profiles/john-doe/my-publish-profile3.dev.pubxml`
   - `my-publish-profile.test.pubxml`
   - `my-publish-profile2.test.pubxml`
   - `my-publish-profile.prod.pubxml`
   - `publish-profiles-for-testing/my-publish-profile.dev-local.pubxml`
   
   Each file bundles the settings for each environment.

### Edit the script to your needs

In [Publish.ps1](/Publish.ps1), starting from line 42, set / add `Publish-Dotnet` command lines to match the publishing execution order of your needs, where only the `-Path` parameter is editable.

**For example:**

```ps1
Publish-Dotnet -Path "path\to\dotnet\solution.sln" -Env $Env -Configuration $Configuration
Publish-Dotnet -Path "path\to\dotnet\project.csproj" -Env $Env -Configuration $Configuration
...
```

### Usage

#### By CLI

```ps1
PowerShell.exe -NoLogo -ExecutionPolicy Bypass -Command .\Publish.ps1 -Env <String> [-Configuration <Debug | Release>]
```

#### By GUI

RightClick on the PowerShell script -> Run with PowerShell

![](https://i.imgur.com/J4U87sd.png)

### Help

To view the full documentation of the script, run:

```ps1
PowerShell.exe -NoLogo -ExecutionPolicy Bypass -Command Get-Help .\Publish.ps1 -Full
```
