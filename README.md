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

1. For each environment, create a new file in the path of your `.csproj` (or an inner directory in that path), with the naming format of `appsettings.<environment>.json`.
   Each file bundles the settings for each environment.

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

   You can also place them in a directory or hierarchy of directories:

   - `<directory>/appsettings.dev.json`
   - `<directory>/appsettings.test.json`
   - `<directory>/appsettings.prod.json`
   - `<directory>/appsettings.dev-local.json`

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
PowerShell.exe -NoLogo -ExecutionPolicy Bypass -Command .\Build.ps1 -Env <String> [-Configuration <Debug | Release>] [-Continue]
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

The [Publish.ps1](/Publish.ps1) script builds pre-defined solutions or projects stated in [Build.ps1](/Build.ps1), and then publishes those solutions or projects to a particular Azure desired environment, using a corresponding "PublishProfile" `*.<environment>.pubxml`.

For each environment you wish to publish, you are required to attach a "PublishProfile" `.pubxml` file, that states the settings for publishing it.

See [How to genererate a PublishProfile .pubxml](https://learn.microsoft.com/en-us/aspnet/core/host-and-deploy/visual-studio-publish-profiles?view=aspnetcore-8.0#publish-profiles).

Once you generate a `.pubxml` file, it will be located under the path of your `.csproj` at `Properties/PublishProfiles/{PROFILE NAME}.pubxml`.

Rename the `.pubxml` file to the format of `<your-publish-profile-name>.<environment>.pubxml`.

Each "PublishProfile" bundles the settings for each environment.

**For example:**

In case you have the following environments:

- `dev`
- `test`
- `prod`
- `dev-local`

Then you represent them with the corresponding files:

- `my-publish-profile.dev.pubxml`
- `my-publish-profile.test.pubxml`
- `my-publish-profile.prod.pubxml`
- `my-publish-profile.dev-local.pubxml`

You can also place them in a directory or hierarchy of directories:

- `<directory>/my-publish-profile.dev.pubxml`
- `<directory>/my-publish-profile.test.pubxml`
- `<directory>/my-publish-profile.prod.pubxml`
- `<directory>/my-publish-profile.dev-local.pubxml`

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
PowerShell.exe -NoLogo -ExecutionPolicy Bypass -Command .\Publish.ps1 -Env <String> [-Configuration <Debug | Release>] [-Continue]
```

#### By GUI

RightClick on the PowerShell script -> Run with PowerShell

![](https://i.imgur.com/6POEq20.png)

### Help

To view the full documentation of the script, run:

```ps1
PowerShell.exe -NoLogo -ExecutionPolicy Bypass -Command Get-Help .\Publish.ps1 -Full
```
