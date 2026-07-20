\--------------------------------------------------------------------------------

- title: WSL
- url: https://wsl.dev/
- date: 2026-07-15T19:31:24.307Z
- parsing method: node-html-markdown

[Skip to content](#wsl-open-source-documentation)

[]()

# WSL

## Technical documentation

\--------------------------------------------------------------------------------

Home


- [Home]()- Getting started Getting started
    - [Building and testing WSL](dev-loop/)- [Debugging WSL](debugging/)- [WSL architecture](technical-documentation/) WSL architecture
    - [wsl.exe](technical-documentation/wsl.exe/)- [wslg.exe](technical-documentation/wslg.exe/)- [wslconfig.exe](technical-documentation/wslconfig.exe/)- [wslhost.exe](technical-documentation/wslhost.exe/)- [wslrelay.exe](technical-documentation/wslrelay.exe/)- [wslservice.exe](technical-documentation/wslservice.exe/)- [mini\_init](technical-documentation/mini%5Finit/)- [init](technical-documentation/init/)- [session leader](technical-documentation/session-leader/)- [relay](technical-documentation/relay/)- [gns](technical-documentation/gns/)- [localhost](technical-documentation/localhost/)- [plan9](technical-documentation/plan9/)- Technical documentation Technical documentation
    - [Boot process](technical-documentation/boot-process/)- [Interop](technical-documentation/interop/)- [Drvfs & Plan9](technical-documentation/drvfs/)- [Systemd](technical-documentation/systemd/)- [API reference](api-reference/) API reference
    - [C API reference](api-reference/c/) C API reference \* [Structures](api-reference/c/structures/) Structures \* [Handle Types](api-reference/c/structures/handle-types/) \* [Constants](api-reference/c/structures/constants/) \* [WslcSessionSettings](api-reference/c/structures/wslcsessionsettings/) \* [WslcContainerSettings](api-reference/c/structures/wslccontainersettings/) \* [WslcProcessSettings](api-reference/c/structures/wslcprocesssettings/) \* [WslcVhdRequirements](api-reference/c/structures/wslcvhdrequirements/) \* [WslcSessionCrashDumpInfo](api-reference/c/structures/wslcsessioncrashdumpinfo/) \* [WslcContainerPortMapping](api-reference/c/structures/wslccontainerportmapping/) \* [WslcContainerVolume](api-reference/c/structures/wslccontainervolume/) \* [WslcContainerNamedVolume](api-reference/c/structures/wslccontainernamedvolume/) \* [WslcProcessCallbacks](api-reference/c/structures/wslcprocesscallbacks/) \* [WslcImageProgressDetail](api-reference/c/structures/wslcimageprogressdetail/) \* [WslcImageProgressMessage](api-reference/c/structures/wslcimageprogressmessage/) \* [WslcPullImageOptions](api-reference/c/structures/wslcpullimageoptions/) \* [WslcImportImageOptions](api-reference/c/structures/wslcimportimageoptions/) \* [WslcLoadImageOptions](api-reference/c/structures/wslcloadimageoptions/) \* [WslcImageInfo](api-reference/c/structures/wslcimageinfo/) \* [WslcTagImageOptions](api-reference/c/structures/wslctagimageoptions/) \* [WslcPushImageOptions](api-reference/c/structures/wslcpushimageoptions/) \* [WslcVersion](api-reference/c/structures/wslcversion/) \* [Callback Types](api-reference/c/callback-types/) Callback Types \* [WslcSessionCrashDumpCallback](api-reference/c/callback-types/wslcsessioncrashdumpcallback/) \* [WslcStdIOCallback](api-reference/c/callback-types/wslcstdiocallback/) \* [WslcProcessExitCallback](api-reference/c/callback-types/wslcprocessexitcallback/) \* [WslcContainerImageProgressCallback](api-reference/c/callback-types/wslccontainerimageprogresscallback/) \* [WslcInstallCallback](api-reference/c/callback-types/wslcinstallcallback/) \* [Session APIs](api-reference/c/session-apis/) Session APIs \* [WslcInitSessionSettings](api-reference/c/session-apis/wslcinitsessionsettings/) \* [WslcCreateSession](api-reference/c/session-apis/wslccreatesession/) \* [WslcSetSessionSettingsCpuCount](api-reference/c/session-apis/wslcsetsessionsettingscpucount/) \* [WslcSetSessionSettingsMemory](api-reference/c/session-apis/wslcsetsessionsettingsmemory/) \* [WslcSetSessionSettingsTimeout](api-reference/c/session-apis/wslcsetsessionsettingstimeout/) \* [WslcSetSessionSettingsVhd](api-reference/c/session-apis/wslcsetsessionsettingsvhd/) \* [WslcSetSessionSettingsFeatureFlags](api-reference/c/session-apis/wslcsetsessionsettingsfeatureflags/) \* [WslcGetSessionTerminationEvent](api-reference/c/session-apis/wslcgetsessionterminationevent/) \* [WslcGetSessionTerminationReason](api-reference/c/session-apis/wslcgetsessionterminationreason/) \* [WslcRegisterSessionCrashDumpCallback](api-reference/c/session-apis/wslcregistersessioncrashdumpcallback/) \* [WslcReleaseCrashDumpSubscription](api-reference/c/session-apis/wslcreleasecrashdumpsubscription/) \* [WslcTerminateSession](api-reference/c/session-apis/wslcterminatesession/) \* [WslcReleaseSession](api-reference/c/session-apis/wslcreleasesession/) \* [WslcSessionAuthenticate](api-reference/c/session-apis/wslcsessionauthenticate/) \* [Container APIs](api-reference/c/container-apis/) Container APIs \* [WslcInitContainerSettings](api-reference/c/container-apis/wslcinitcontainersettings/) \* [WslcCreateContainer](api-reference/c/container-apis/wslccreatecontainer/) \* [WslcStartContainer](api-reference/c/container-apis/wslcstartcontainer/) \* [WslcSetContainerSettingsName](api-reference/c/container-apis/wslcsetcontainersettingsname/) \* [WslcSetContainerSettingsInitProcess](api-reference/c/container-apis/wslcsetcontainersettingsinitprocess/) \* [WslcSetContainerSettingsNetworkingMode](api-reference/c/container-apis/wslcsetcontainersettingsnetworkingmode/) \* [WslcSetContainerSettingsHostName](api-reference/c/container-apis/wslcsetcontainersettingshostname/) \* [WslcSetContainerSettingsDomainName](api-reference/c/container-apis/wslcsetcontainersettingsdomainname/) \* [WslcSetContainerSettingsFlags](api-reference/c/container-apis/wslcsetcontainersettingsflags/) \* [WslcSetContainerSettingsPortMappings](api-reference/c/container-apis/wslcsetcontainersettingsportmappings/) \* [WslcSetContainerSettingsVolumes](api-reference/c/container-apis/wslcsetcontainersettingsvolumes/) \* [WslcSetContainerSettingsNamedVolumes](api-reference/c/container-apis/wslcsetcontainersettingsnamedvolumes/) \* [WslcCreateContainerProcess](api-reference/c/container-apis/wslccreatecontainerprocess/) \* [WslcGetContainerID](api-reference/c/container-apis/wslcgetcontainerid/) \* [WslcGetContainerInitProcess](api-reference/c/container-apis/wslcgetcontainerinitprocess/) \* [WslcInspectContainer](api-reference/c/container-apis/wslcinspectcontainer/) \* [WslcGetContainerState](api-reference/c/container-apis/wslcgetcontainerstate/) \* [WslcStopContainer](api-reference/c/container-apis/wslcstopcontainer/) \* [WslcDeleteContainer](api-reference/c/container-apis/wslcdeletecontainer/) \* [WslcReleaseContainer](api-reference/c/container-apis/wslcreleasecontainer/) \* [Process APIs](api-reference/c/process-apis/) Process APIs \* [WslcInitProcessSettings](api-reference/c/process-apis/wslcinitprocesssettings/) \* [WslcSetProcessSettingsWorkingDirectory](api-reference/c/process-apis/wslcsetprocesssettingsworkingdirectory/) \* [WslcSetProcessSettingsCmdLine](api-reference/c/process-apis/wslcsetprocesssettingscmdline/) \* [WslcSetProcessSettingsEnvVariables](api-reference/c/process-apis/wslcsetprocesssettingsenvvariables/) \* [WslcSetProcessSettingsCallbacks](api-reference/c/process-apis/wslcsetprocesssettingscallbacks/) \* [WslcGetProcessPid](api-reference/c/process-apis/wslcgetprocesspid/) \* [WslcGetProcessExitEvent](api-reference/c/process-apis/wslcgetprocessexitevent/) \* [WslcGetProcessState](api-reference/c/process-apis/wslcgetprocessstate/) \* [WslcGetProcessExitCode](api-reference/c/process-apis/wslcgetprocessexitcode/) \* [WslcSignalProcess](api-reference/c/process-apis/wslcsignalprocess/) \* [WslcGetProcessIOHandle](api-reference/c/process-apis/wslcgetprocessiohandle/) \* [WslcReleaseProcess](api-reference/c/process-apis/wslcreleaseprocess/) \* [Image APIs](api-reference/c/image-apis/) Image APIs \* [WslcPullSessionImage](api-reference/c/image-apis/wslcpullsessionimage/) \* [WslcImportSessionImage](api-reference/c/image-apis/wslcimportsessionimage/) \* [WslcImportSessionImageFromFile](api-reference/c/image-apis/wslcimportsessionimagefromfile/) \* [WslcLoadSessionImage](api-reference/c/image-apis/wslcloadsessionimage/) \* [WslcLoadSessionImageFromFile](api-reference/c/image-apis/wslcloadsessionimagefromfile/) \* [WslcDeleteSessionImage](api-reference/c/image-apis/wslcdeletesessionimage/) \* [WslcListSessionImages](api-reference/c/image-apis/wslclistsessionimages/) \* [WslcTagSessionImage](api-reference/c/image-apis/wslctagsessionimage/) \* [WslcPushSessionImage](api-reference/c/image-apis/wslcpushsessionimage/) \* [Storage APIs](api-reference/c/storage-apis/) Storage APIs \* [WslcCreateSessionVhdVolume](api-reference/c/storage-apis/wslccreatesessionvhdvolume/) \* [WslcDeleteSessionVhdVolume](api-reference/c/storage-apis/wslcdeletesessionvhdvolume/) \* [Install and Version APIs](api-reference/c/install-and-version-apis/) Install and Version APIs \* [WslcGetMissingComponents](api-reference/c/install-and-version-apis/wslcgetmissingcomponents/) \* [WslcGetVersion](api-reference/c/install-and-version-apis/wslcgetversion/) \* [WslcInstallWithDependencies](api-reference/c/install-and-version-apis/wslcinstallwithdependencies/) \* [Enumerations](api-reference/c/enumerations/) Enumerations \* [WslcContainerNetworkingMode](api-reference/c/enumerations/wslccontainernetworkingmode/) \* [WslcVhdType](api-reference/c/enumerations/wslcvhdtype/) \* [WslcVhdRequirementsFlags](api-reference/c/enumerations/wslcvhdrequirementsflags/) \* [WslcSessionFeatureFlags](api-reference/c/enumerations/wslcsessionfeatureflags/) \* [WslcSessionTerminationReason](api-reference/c/enumerations/wslcsessionterminationreason/) \* [WslcPortProtocol](api-reference/c/enumerations/wslcportprotocol/) \* [WslcContainerFlags](api-reference/c/enumerations/wslccontainerflags/) \* [WslcContainerStartFlags](api-reference/c/enumerations/wslccontainerstartflags/) \* [WslcContainerState](api-reference/c/enumerations/wslccontainerstate/) \* [WslcSignal](api-reference/c/enumerations/wslcsignal/) \* [WslcDeleteContainerFlags](api-reference/c/enumerations/wslcdeletecontainerflags/) \* [WslcProcessIOHandle](api-reference/c/enumerations/wslcprocessiohandle/) \* [WslcProcessState](api-reference/c/enumerations/wslcprocessstate/) \* [WslcImageProgressStatus](api-reference/c/enumerations/wslcimageprogressstatus/) \* [WslcComponentFlags](api-reference/c/enumerations/wslccomponentflags/) \* [Error Codes](api-reference/c/error-codes/) \* [Not Yet Implemented APIs](api-reference/c/not-yet-implemented-apis/) \* [End-to-End Example](api-reference/c/end-to-end-example/)- [C++ API reference](api-reference/cpp/) C++ API reference \* [Data Classes](api-reference/cpp/data-classes/) Data Classes \* [ImageInfo](api-reference/cpp/data-classes/imageinfo/) \* [ImageProgress](api-reference/cpp/data-classes/imageprogress/) \* [InstallProgress](api-reference/cpp/data-classes/installprogress/) \* [ContainerPortMapping](api-reference/cpp/data-classes/containerportmapping/) \* [ContainerVolume](api-reference/cpp/data-classes/containervolume/) \* [ContainerNamedVolume](api-reference/cpp/data-classes/containernamedvolume/) \* [Referenced](api-reference/cpp/data-classes/referenced/) \* [Settings Classes](api-reference/cpp/settings-classes/) Settings Classes \* [SessionSettings](api-reference/cpp/settings-classes/sessionsettings/) \* [ContainerSettings](api-reference/cpp/settings-classes/containersettings/) \* [ProcessSettings](api-reference/cpp/settings-classes/processsettings/) \* [VhdOptions](api-reference/cpp/settings-classes/vhdoptions/) \* [Core Classes](api-reference/cpp/core-classes/) Core Classes \* [Session](api-reference/cpp/core-classes/session/) \* [Container](api-reference/cpp/core-classes/container/) \* [Process](api-reference/cpp/core-classes/process/) \* [Service Class](api-reference/cpp/service-class/) Service Class \* [WslcService](api-reference/cpp/service-class/wslcservice/) \* [Delegates and Events](api-reference/cpp/delegates-and-events/) Delegates and Events \* [SessionTerminationHandler](api-reference/cpp/delegates-and-events/sessionterminationhandler/) \* [ProcessCrashHandler](api-reference/cpp/delegates-and-events/processcrashhandler/) \* [ProcessOutputHandler](api-reference/cpp/delegates-and-events/processoutputhandler/) \* [ProcessExitHandler](api-reference/cpp/delegates-and-events/processexithandler/) \* [Enumerations](api-reference/cpp/enumerations/) Enumerations \* [Component](api-reference/cpp/enumerations/component/) \* [DeleteContainerOption](api-reference/cpp/enumerations/deletecontaineroption/) \* [Error](api-reference/cpp/enumerations/error/) \* [ContainerNetworkingMode](api-reference/cpp/enumerations/containernetworkingmode/) \* [PortProtocol](api-reference/cpp/enumerations/portprotocol/) \* [ContainerState](api-reference/cpp/enumerations/containerstate/) \* [Signal](api-reference/cpp/enumerations/signal/) \* [ProcessOutputHandle](api-reference/cpp/enumerations/processoutputhandle/) \* [ProcessOutputMode](api-reference/cpp/enumerations/processoutputmode/) \* [ProcessState](api-reference/cpp/enumerations/processstate/) \* [VhdType](api-reference/cpp/enumerations/vhdtype/) \* [ImageProgressStatus](api-reference/cpp/enumerations/imageprogressstatus/) \* [SessionTerminationReason](api-reference/cpp/enumerations/sessionterminationreason/) \* [Not Yet Implemented and Known Gaps](api-reference/cpp/not-yet-implemented-and-known-gaps/) \* [End-to-End Example](api-reference/cpp/end-to-end-example/)- [C# API reference](api-reference/csharp/) C# API reference \* [Overview](api-reference/csharp/overview/) \* [Projected Namespace](api-reference/csharp/projected-namespace/) \* [Common CsWinRT Type Mappings](api-reference/csharp/common-cswinrt-type-mappings/) \* [Data Classes](api-reference/csharp/data-classes/) Data Classes \* [ContainerPortMapping](api-reference/csharp/data-classes/containerportmapping/) \* [ContainerVolume](api-reference/csharp/data-classes/containervolume/) \* [ContainerNamedVolume](api-reference/csharp/data-classes/containernamedvolume/) \* [ImageInfo](api-reference/csharp/data-classes/imageinfo/) \* [ImageProgress](api-reference/csharp/data-classes/imageprogress/) \* [InstallProgress](api-reference/csharp/data-classes/installprogress/) \* [ProcessCrashInformation](api-reference/csharp/data-classes/processcrashinformation/) \* [ServiceVersion](api-reference/csharp/data-classes/serviceversion/) \* [VhdOwner](api-reference/csharp/data-classes/vhdowner/) \* [Settings Classes](api-reference/csharp/settings-classes/) Settings Classes \* [SessionSettings](api-reference/csharp/settings-classes/sessionsettings/) \* [VhdOptions](api-reference/csharp/settings-classes/vhdoptions/) \* [PullImageOptions](api-reference/csharp/settings-classes/pullimageoptions/) \* [PushImageOptions](api-reference/csharp/settings-classes/pushimageoptions/) \* [TagImageOptions](api-reference/csharp/settings-classes/tagimageoptions/) \* [ContainerSettings](api-reference/csharp/settings-classes/containersettings/) \* [ProcessSettings](api-reference/csharp/settings-classes/processsettings/) \* [Core Classes](api-reference/csharp/core-classes/) Core Classes \* [Session](api-reference/csharp/core-classes/session/) \* [Container](api-reference/csharp/core-classes/container/) \* [Process](api-reference/csharp/core-classes/process/) \* [Service Class](api-reference/csharp/service-class/) Service Class \* [WslcService](api-reference/csharp/service-class/wslcservice/) \* [Delegates and Events](api-reference/csharp/delegates-and-events/) \* [Enumerations](api-reference/csharp/enumerations/) Enumerations \* [Component](api-reference/csharp/enumerations/component/) \* [DeleteContainerOption](api-reference/csharp/enumerations/deletecontaineroption/) \* [Error](api-reference/csharp/enumerations/error/) \* [ContainerNetworkingMode](api-reference/csharp/enumerations/containernetworkingmode/) \* [PortProtocol](api-reference/csharp/enumerations/portprotocol/) \* [ContainerState](api-reference/csharp/enumerations/containerstate/) \* [Signal](api-reference/csharp/enumerations/signal/) \* [ProcessOutputHandle](api-reference/csharp/enumerations/processoutputhandle/) \* [ProcessOutputMode](api-reference/csharp/enumerations/processoutputmode/) \* [ProcessState](api-reference/csharp/enumerations/processstate/) \* [VhdType](api-reference/csharp/enumerations/vhdtype/) \* [ImageProgressStatus](api-reference/csharp/enumerations/imageprogressstatus/) \* [SessionTerminationReason](api-reference/csharp/enumerations/sessionterminationreason/) \* [Known Gaps](api-reference/csharp/known-gaps/) \* [End-to-End Example](api-reference/csharp/end-to-end-example/)

WSL open source documentation

This site contains the developer documentation for the Windows Subsystem for Linux.

For user documentation, including installation and configuration, see [https://learn.microsoft.com/windows/wsl/](https://www.google.com/url?sa=E&q=https%3A%2F%2Flearn.microsoft.com%2Fwindows%2Fwsl%2F).

To get started developing (building, testing and deploying), see [Getting started](dev-loop/).

To learn more about how WSL works, see [technical documentation](technical-documentation/).

Back to top


\--------------------------------------------------------------------------------

- title: Building and testing WSL - WSL
- url: https://wsl.dev/dev-loop/
- date: 2026-07-15T19:31:24.307Z
- parsing method: node-html-markdown

[Skip to content](#building-wsl)

\--------------------------------------------------------------------------------

Building and testing WSL


    - Building and testing WSL [Building and testing WSL]() Table of content
	[Prerequisites](#prerequisites) \* [ARM64 development](#arm64-development) \* [Building WSL](#building-wsl%5F1) \* [Deploying WSL](#deploying-wsl) \* [Running tests](#running-tests) \* [Debugging tests](#debugging-tests) \* [Tips and tricks](#tips-and-tricks)
	
	- [Debugging WSL](debugging/)- [WSL architecture](technical-documentation/) WSL architecture
    
    
    

Table of contents

- [Prerequisites](#prerequisites)
    - [ARM64 development](#arm64-development)- [Building WSL](#building-wsl%5F1)- [Deploying WSL](#deploying-wsl)- [Running tests](#running-tests)- [Debugging tests](#debugging-tests)- [Tips and tricks](#tips-and-tricks)

Building WSL

Prerequisites

All prerequisites can be installed automatically by running:

`[](#%5F%5Fcodelineno-0-1)tools\setup-dev-env.ps1`

This uses [WinGet Configuration](https://www.google.com/url?sa=E&q=https%3A%2F%2Flearn.microsoft.com%2Fwindows%2Fpackage-manager%2Fconfiguration%2F) to install Developer Mode, CMake, Visual Studio 2022, and the required workloads from [.vsconfig](https://www.google.com/url?sa=E&q=https%3A%2F%2Fgithub.com%2Fmicrosoft%2FWSL%2Fblob%2Fmaster%2F.vsconfig). If VS 2022 is already installed, the script detects your edition (Community, Professional, or Enterprise) and uses the matching configuration. If no VS 2022 is found, it defaults to Community.

You can also run a WinGet configuration directly for your edition:

`[](#%5F%5Fcodelineno-1-1)winget configure --enable [](#%5F%5Fcodelineno-1-2)winget configure -f .config/configuration.winget # Community (default) [](#%5F%5Fcodelineno-1-3)winget configure -f .config/configuration.vsProfessional.winget # Professional [](#%5F%5Fcodelineno-1-4)winget configure -f .config/configuration.vsEnterprise.winget # Enterprise`

**Note:** `winget configure --enable` is required to enable the configuration feature. The `setup-dev-env.ps1` script runs this automatically.

Manual installationIf you prefer to install prerequisites manually: - CMake >= 3.25 - Can be installed with \`winget install Kitware.CMake\` - Visual Studio 2022 with the required components: - Use VS Installer → More → Import configuration and select \[\`.vsconfig\`\](https://github.com/microsoft/WSL/blob/master/.vsconfig) - Or: \`winget install Microsoft.VisualStudio.2022.Community --override "--wait --quiet --config .vsconfig"\` - Enable DeveloperMode(https://learn.microsoft.com/en-us/windows/apps/get-started/enable-your-device-for-development) in Windows Settings, or run builds with Administrator privileges (required for symbolic link support)

ARM64 development

When building on ARM64 Windows, the [WiX](https://www.google.com/url?sa=E&q=https%3A%2F%2Fwixtoolset.org%2F) toolset (`wix.exe`) requires the **x64 .NET 6.0 runtime** because it is an x64 binary. The ARM64 .NET runtime alone is not sufficient.

To install the x64 .NET 6.0 runtime, run the following commands in PowerShell:

`[](#%5F%5Fcodelineno-2-1)# Download the official dotnet-install script [](#%5F%5Fcodelineno-2-2)Invoke-WebRequest -Uri "https://dot.net/v1/dotnet-install.ps1" -OutFile "$env:TEMP\dotnet-install.ps1" [](#%5F%5Fcodelineno-2-3) [](#%5F%5Fcodelineno-2-4)# Install the x64 .NET 6.0 runtime [](#%5F%5Fcodelineno-2-5)powershell -ExecutionPolicy Bypass -File "$env:TEMP\dotnet-install.ps1" -Channel 6.0 -Runtime dotnet -Architecture x64 -InstallDir "C:\Program Files\dotnet\x64"`

Then set the `DOTNET_ROOT_X64` environment variable so the runtime is discoverable:

`[](#%5F%5Fcodelineno-3-1)# Set for the current session [](#%5F%5Fcodelineno-3-2)$env:DOTNET_ROOT_X64 = "C:\Program Files\dotnet\x64" [](#%5F%5Fcodelineno-3-3) [](#%5F%5Fcodelineno-3-4)# Set permanently for your user [](#%5F%5Fcodelineno-3-5)[System.Environment]::SetEnvironmentVariable("DOTNET_ROOT_X64", "C:\Program Files\dotnet\x64", "User")`

**Note:** You may need to restart VS Code or open a new terminal for the environment variable to take effect.

Building WSL

Once you have cloned the repository, generate the Visual Studio solution by running:

`[](#%5F%5Fcodelineno-4-1)cmake .`

This will generate a `wsl.sln` file that you can build either with Visual Studio, or via `cmake --build .`.

Build parameters:

- `cmake . -A arm64`: Build a package for ARM64- `cmake . -DCMAKE_BUILD_TYPE=Release`: Build for release- `cmake . -DBUILD_BUNDLE=TRUE`: Build a bundle msix package (requires building ARM64 first)

Note: To build and deploy faster during development, see options in `UserConfig.cmake`.

Deploying WSL

Once the build is complete, you can install WSL by installing the MSI package found under `bin\<platform>\<target>\wsl.msi`, or by running `powershell tools\deploy\deploy-to-host.ps1`.

To deploy on a Hyper-V virtual machine, you can use `powershell tools\deploy\deploy-to-vm.ps1 -VmName <vm> -Username <username> -Password <password>`

Running tests

To run unit tests, run: `bin\<platform>\<target>\test.bat`. There's quite a lot of tests so you probably don't want to run everything. Here's a reasonable subset:`bin\<platform>\<target>\test.bat /name:*UnitTest*`

To run a specific test case run:`bin\<platform>\<target>\test.bat /name:<class>::<test>`Example: `bin\x64\debug\test.bat /name:UnitTests::UnitTests::ModernInstall`

To run the tests for WSL1, add `-Version 1`. Example: `bin\x64\debug\test.bat -Version 1`

After running the tests once, you can add `-f` to skip the package installation, which makes the tests faster (this requires test\_distro to be the default WSL distribution).

Example:

`[](#%5F%5Fcodelineno-5-1)wsl --set-default test_distro [](#%5F%5Fcodelineno-5-2)bin\x64\debug\test.bat /name:*UnitTest* -f`

Debugging tests

See [debugging](debugging/) for general debugging instructions.

To automatically attach WinDbgX to the unit test process, use: `/attachdebugger` when calling `test.bat`. To wait for a debugger to be manually attached, use: `/waitfordebugger`. Use `/breakonfailure` to automatically break on the first test failure.

Tips and tricks

**Building and deploying faster**

To iterate faster, create a copy of [UserConfig.cmake.sample](https://www.google.com/url?sa=E&q=https%3A%2F%2Fgithub.com%2Fmicrosoft%2FWSL%2Fblob%2Fmaster%2FUserConfig.cmake.sample):

`[](#%5F%5Fcodelineno-6-1)copy UserConfig.cmake.sample UserConfig.cmake`

And uncomment this line:

`[](#%5F%5Fcodelineno-7-1)# set(WSL_DEV_BINARY_PATH "C:/wsldev")`

This will change the build logic to build a smaller package that installs faster. Also see:

- `WSL_BUILD_THIN_PACKAGE` to build an even smaller package- `WSL_POST_BUILD_COMMAND` to automatically deploy the package during build

**Code formatting**

Every pull request needs to be clang-formatted before it can be merged.

The code can be manually formatted by running: `powershell .\FormatSource.ps1 -ModifiedOnly $false`.

To automatically check formatting before each commit, run CMake configure (e.g. `cmake .`) and then: `tools\SetupClangFormat.bat`

The pre-commit hook behavior can be configured by setting `WSL_PRE_COMMIT_MODE` in `UserConfig.cmake`:

- `warn` (default) – report formatting issues without blocking the commit- `error` – block the commit when formatting issues are found- `fix` – automatically fix formatting and re-stage files

Back to top


\--------------------------------------------------------------------------------

- title: Debugging WSL - WSL
- url: https://wsl.dev/debugging/
- date: 2026-07-15T19:31:24.307Z
- parsing method: node-html-markdown

[Skip to content](#debugging-wsl)

\--------------------------------------------------------------------------------

Debugging WSL


    
    
    

Table of contents

- [Logging](#logging)- [WSLg (graphical and audio applications) logs](#wslg-graphical-and-audio-applications-logs)- [Attaching debuggers](#attaching-debuggers)- [Linux debugging](#linux-debugging)- [Root namespace debugging](#root-namespace-debugging)

Debugging WSL

Logging

There are multiple sources of logging in WSL. The main one is the ETL trace that is emitted from Windows processes.

To collect an ETL trace, run ([link to wsl.wprp](https://www.google.com/url?sa=E&q=https%3A%2F%2Fgithub.com%2Fmicrosoft%2FWSL%2Fblob%2Fmaster%2Fdiagnostics%2Fwsl.wprp)):

`[](#%5F%5Fcodelineno-0-1)wpr -start wsl.wprp -filemode [](#%5F%5Fcodelineno-0-2) [](#%5F%5Fcodelineno-0-3)[reproduce the issue] [](#%5F%5Fcodelineno-0-4) [](#%5F%5Fcodelineno-0-5)wpr -stop logs.ETL`

The consolidated `wsl.wprp` file includes multiple profiles for different scenarios:

- `WSL` - General WSL tracing (default)- `WSL-Storage` - Enhanced storage tracing- `WSL-Networking` - Comprehensive networking tracing- `WSL-HvSocket` - HvSocket-specific tracing

To use a specific profile, append `!ProfileName` to the wprp file, e.g., `wpr -start wsl.wprp!WSL-Networking -filemode`

Once the log file is saved, you can use [WPA](https://www.google.com/url?sa=E&q=https%3A%2F%2Fapps.microsoft.com%2Fdetail%2F9n58qrw40dfw%3Fhl%3Den-US%26gl%3DUS) to view the logs.

Notable ETL providers:

- `Microsoft.Windows.Lxss.Manager`: Logs emitted from wslservice.exe Important events:
    - `GuestLog`: Logs from the vm's dmesg- `Error`: Unexpected errors- `CreateVmBegin`, `CreateVmEnd`: Virtual machine lifetime- `CreateNetworkBegin`, `CreateNetworkEnd`: Networking configuration- `SentMessage`, `ReceivedMessage`: Communication on the hvsocket channels with Linux.- `Microsoft.Windows.Subsystem.Lxss`: Other WSL executables (wsl.exe, wslg.exe, wslconfig.exe, wslrelay.exe, ...) Important events:
    - `UserVisibleError`: An error was displayed to the user- `Microsoft.Windows.Plan9.Server`: Logs from the Windows plan9 server (used when accessing /mnt/ shares and running Windows)

On the Linux side, the easiest way to access logs is to look at `dmesg` or use the debug console, which can be enabled by writing:

`[](#%5F%5Fcodelineno-1-1)[wsl2] [](#%5F%5Fcodelineno-1-2)debugConsole=true`

to `%USERPROFILE%/.wslconfig` and restarting WSL

WSLg (graphical and audio applications) logs

[WSLg](https://www.google.com/url?sa=E&q=https%3A%2F%2Fgithub.com%2Fmicrosoft%2Fwslg) runs graphical and audio Linux applications. It runs a system distro that hosts the `weston` Wayland compositor (with an RDP backend), `Xwayland`,`pulseaudio`, and `FreeRDP`. WSLg's source lives in a separate repository:[microsoft/wslg](https://www.google.com/url?sa=E&q=https%3A%2F%2Fgithub.com%2Fmicrosoft%2Fwslg).

WSLg writes its logs to `/mnt/wslg` (accessible from Windows via `\\wsl$\<Distro>\mnt\wslg`):

- `weston.log` - Weston compositor and RDP backend log- `wlog.log` - FreeRDP log- `pulseaudio.log` - PulseAudio log- `stderr.log` - `WSLGd` and child-process stderr- `versions.txt` - WSLg version and component git hashes

Crash dumps (e.g. `core.weston`) are written to `%TEMP%\wsl-crashes` on newer builds, or`/mnt/wslg/dumps` on older ones.

The [collect-wsl-logs.ps1](https://www.google.com/url?sa=E&q=https%3A%2F%2Fgithub.com%2Fmicrosoft%2FWSL%2Fblob%2Fmaster%2Fdiagnostics%2Fcollect-wsl-logs.ps1)script gathers the logs above automatically into a `wslg/` folder (crash dumps are included when run with `-Dump`). Note that `weston.log` is truncated on every system-distro boot, so it only contains the most recent boot.

Attaching debuggers

Usermode can be attached to WSL Windows processes (wsl.exe, wslservice.exe, wslrelay.exe, ...). The symbols are available under the `bin/<platform>/<target>` folder. You can also use [this trick](https://www.google.com/url?sa=E&q=https%3A%2F%2Fgithub.com%2Fmicrosoft%2FWSL%2Fblob%2Fmaster%2FCONTRIBUTING.md%2311-reporting-a-wsl-process-crash) to automatically collect crash dumps when processes crash.

Linux debugging

`gdb` can be attached to Linux processes (see [man gdb](https://www.google.com/url?sa=E&q=https%3A%2F%2Fman7.org%2Flinux%2Fman-pages%2Fman1%2Fgdb.1.html)).

The simplest way to debug a WSL process with gdb is to use the `/mnt` mountpoints to access the code from gdb. Once started, just use `dir /path/to/wsl/source` in gdb to connect the source files.

Root namespace debugging

Some WSL processes such as `gns` or `mini_init` aren't accessible from within WSL distributions. To attach a debugger to those, use the debug shell via:

`[](#%5F%5Fcodelineno-2-1)wsl --debug-shell`

You can then install `gdb` by running `tdnf install gdb` and start debugging processes.

Back to top


\--------------------------------------------------------------------------------

- title: Overview - WSL
- url: https://wsl.dev/technical-documentation/
- date: 2026-07-15T19:31:24.307Z
- parsing method: node-html-markdown

[Skip to content](#wsl-overview)

\--------------------------------------------------------------------------------

Overview


    
    
    

WSL Overview

WSL is comprised of a set of executables, APIs and protocols. This page offers an overview of the different components, and how they're connected. Click on any component to get more details.

```
%%{ init: {
    'flowchart': { 'curve': 'stepBefore' },
    'theme': 'neutral'
    }
}%%
graph
  subgraph Windows["

Windows

"]
      C:\Windows\System32\wsl.exe["C:\Windows\System32\wsl.exe"]---|"CreateProcess()"|wsl.exe;
      wsl.exe[wsl.exe]---|COM|wslservice.exe;
      wslg.exe[wslg.exe]---|COM|wslservice.exe;
      wslconfig.exe[wslconfig.exe]---|COM|wslservice.exe;
      wslapi.dll[wslapi.dll]---|COM|wslservice.exe;
      id[debian.exe, ubuntu.exe, ]---|"LoadLibrary()"|wslapi.dll;
      wslservice.exe[wslservice.exe]---|"CreateProcessAsUser()"|wslrelay.exe[wslrelay.exe];
      wslservice.exe---|"CreateProcessAsUser()"|wslhost.exe[wslhost.exe];
      fs["Windows filesystem (//wsl.localhost)"]
  end

  wslservice.exe -----|hvsocket| mini_init
  wslservice.exe -----|hvsocket| gns
  fs---|hvsocket|plan9

  wsl.exe---|hvsocket|relay

  subgraph Linux["

Linux

"]
      mini_init[mini_init]---|"exec()"|gns[gns]
      mini_init---|"exec()"|init[init];
      mini_init---|"exec()"|localhost[localhost];

      subgraph "Linux Distribution"["

Linux Distribution

"]

          init[init]---|"exec()"|plan9[plan9];
          init---|"exec()"|sid[session leader];
          sid[session leader]---|"exec()"|relay
          relay[relay]---|"exec()"|cid["User command (bash, curl)"]
      end

  end

```

Back to top


\--------------------------------------------------------------------------------

- title: wsl.exe - WSL
- url: https://wsl.dev/technical-documentation/wsl.exe/
- date: 2026-07-15T19:31:24.307Z
- parsing method: node-html-markdown

[Skip to content](#wslexe)

\--------------------------------------------------------------------------------

wsl.exe


    
    
    

wsl.exe

wsl.exe is the main command line entrypoint for WSL. Its job is to:

- Parse the command line arguments (See `src/windows/common/wslclient.cpp`)- Call [wslservice.exe](wslservice.exe/) via COM to launch WSL (see `src/windows/common/svccomm.cpp`)- Relay stdin / stdout / stderr from and to the linux process

Back to top


\--------------------------------------------------------------------------------

- title: wslg.exe - WSL
- url: https://wsl.dev/technical-documentation/wslg.exe/
- date: 2026-07-15T19:31:24.307Z
- parsing method: node-html-markdown

[Skip to content](#wslgexe)

\--------------------------------------------------------------------------------

wslg.exe


    
    
    

Wslg.exe

`wslg.exe` is a Windows executable that is used mostly to run graphical applications with WSL.

Its behavior is exactly the same as [wsl.exe](wsl.exe/) with the difference that it's a win32 application, and not a console application, which allows it to start without creating a console.

Back to top


\--------------------------------------------------------------------------------

- title: wslconfig.exe - WSL
- url: https://wsl.dev/technical-documentation/wslconfig.exe/
- date: 2026-07-15T19:31:24.307Z
- parsing method: node-html-markdown

[Skip to content](#wslconfigexe)

\--------------------------------------------------------------------------------

wslconfig.exe


Wslconfig.exe

`wslconfig.exe` is a Windows executable that can be used to configure WSL distributions.

Back to top


\--------------------------------------------------------------------------------

- title: wslhost.exe - WSL
- url: https://wsl.dev/technical-documentation/wslhost.exe/
- date: 2026-07-15T19:31:24.307Z
- parsing method: node-html-markdown

[Skip to content](#wslhostexe)

\--------------------------------------------------------------------------------

wslhost.exe


Table of contents

- [COM server](#com-server)- [Background processes](#background-processes)

Wslhost.exe

`wslhost.exe` is a Windows executable that's used to display desktop notifications, and run Linux processes in the background.

COM server

When running as COM server, `wslhost.exe` registers a [NotificationActivatorFactory](https://www.google.com/url?sa=E&q=https%3A%2F%2Flearn.microsoft.com%2Fdotnet%2Fapi%2Fmicrosoft.toolkit.uwp.notifications.notificationactivator%3Fview%3Dwin-comm-toolkit-dotnet-7.1), which is then used to display desktop notifications to the user.

Notifications can be used to:

- Notify the user about a WSL update- Warn the user about a configuration error- Notify the user about a proxy change

See: `src/windows/common/notifications.cpp`

Background processes

When [wsl.exe](wsl.exe/) terminates before the associated Linux process terminates, `wslhost.exe` takes over the lifetime of the Linux process.

This allows Linux processes to keep running Windows commands and access the terminal even after the associated `wsl.exe` terminates.

See `src/windows/wslhost/main.cpp` and [interop](interop/)

Back to top


\--------------------------------------------------------------------------------

- title: wslrelay.exe - WSL
- url: https://wsl.dev/technical-documentation/wslrelay.exe/
- date: 2026-07-15T19:31:24.307Z
- parsing method: node-html-markdown

[Skip to content](#wslrelayexe)

\--------------------------------------------------------------------------------

wslrelay.exe


Wslrelay.exe

`wslrelay.exe` is a windows executable that is used to relay network and debug console traffic from Linux to Windows.

It is responsible for:

- Relaying localhost traffic between Linux and Windows in NAT mode (see [localhost](localhost/))- Displaying the debug console output when `wsl2.debugConsole` is set to `true`

See `src/windows/wslrelay/main.cpp`

Back to top


\--------------------------------------------------------------------------------

- title: wslservice.exe - WSL
- url: https://wsl.dev/technical-documentation/wslservice.exe/
- date: 2026-07-15T19:31:24.307Z
- parsing method: node-html-markdown

[Skip to content](#wslserviceexe)

\--------------------------------------------------------------------------------

wslservice.exe


Table of contents

- [COM Interface](#com-interface)- [WSL2 Virtual machine](#wsl2-virtual-machine)- [WSL2 Distributions](#wsl2-distributions)

wslservice.exe

WslService is a session 0 service, running as SYSTEM. Its job is to manage WSL sessions, communicate with the WSL2 virtual machine and configure WSL distributions.

COM Interface

Clients can connect to WslService via its COM interface, ILxssUserSession. Its definition can be found in `src/windows/service/inc/wslservice.idl`.

When a COM client calls [CoCreateInstance()](https://www.google.com/url?sa=E&q=https%3A%2F%2Flearn.microsoft.com%2Fwindows%2Fwin32%2Fapi%2Fcombaseapi%2Fnf-combaseapi-cocreateinstance) on this interface, the service receives the requests via `LxssUserSessionFactory` (see `src/windows/service/LxssUserSessionFactory.cpp`) and returns an instance of `LxssUserSession` (see `src/windows/service/LxssUserSession.cpp`) per Windows user (calling CoCreateInstance() multiple times from the same Windows user accounts returns the same instance).

The client can then use its `ILxssUserSession` instance to call methods into the service, such as:

- `CreateInstance()`: Launch a WSL distribution- `CreateLxProcess()`: Launch a process inside a distribution- `RegisterDistribution()`: Register a new WSL distribution- `Shutdown()`: Terminate all WSL distributions

WSL2 Virtual machine

WslService manages the WSL2 Virtual Machine. The virtual machine management logic can be found in `src/windows/service/WslCoreVm.cpp`.

Once booted, WslService maintains an [hvsocket](https://www.google.com/url?sa=E&q=https%3A%2F%2Flearn.microsoft.com%2Fvirtualization%2Fhyper-v-on-windows%2Fuser-guide%2Fmake-integration-service) with the Virtual Machine which it uses to send various commands to Linux processes (see [mini\_init](mini%5Finit/) for more details).

WSL2 Distributions

Once the virtual machine is running, WSL distributions can be started by calling `WslCoreVm::CreateInstance`. Each running distribution is represented by a `WslCoreInstance` (see `src/windows/service/WslCoreInstance.cpp`).

Each `WslCoreInstance` maintains an hvsocket connection to [init](init/) which allows WslService to perform various tasks such as:

- Launching processes inside the distribution- Be notified when the distribution exits- Mount drvfs shares (/mnt/\*)- Stop the distribution

Back to top


\--------------------------------------------------------------------------------

- title: mini\_init - WSL
- url: https://wsl.dev/technical-documentation/mini\_init/
- date: 2026-07-15T19:31:24.307Z
- parsing method: node-html-markdown

[Skip to content](#mini%5Finit)

\--------------------------------------------------------------------------------

mini\_init


Table of contents

- [Virtual machine setup](#virtual-machine-setup)- [Networking configuration](#networking-configuration)- [Other tasks](#other-tasks)

mini\_init

mini\_init is the first executable that's launched when the WSL2 virtual machine starts. See [WSL2 boot process](boot-process/) for more details.

Virtual machine setup

mini\_init is started when the kernel is done booting, and calls `/init`, which is `mini_init`. Like other standard linux `init` executables, `mini_init` starts by mounting `/proc`, `/sys`, `/dev` and other standard mountpoints.

`mini_init` then performs various configuration such as enabling crash dump collection, configuring logging via `/dev/console` and tty configuration.

Once everything is ready, `mini_init` connects two hvsockets to [wslservice](wslservice.exe/).

One of them, called the "mini\_init" channel is used for messages sent by `wslservice.exe`. See `src/shared/inc/lxinitshared.h` for a list of messages and responses. Common messages are:

- `LxMiniInitMessageLaunchInit`: Mount a virtual disk and start a new distribution. See [init](init/) for more details- `LxMiniInitMessageMount`: Mount a disk in `/mnt/wsl` (used for wsl --mount)- `EJECT_VHD_MESSAGE`: Eject a disk- `LxMiniInitMessageImport`: Import a distribution- `LxMiniInitMessageExport`: Export a distribution

The other hvsocket channel is used to send notifications to [wslservice.exe](wslservice.exe/). This is used mainly to report when linux processes exit (which wslservice uses to know when distributions are terminated).

Networking configuration

As part of the boot process, `mini_init` also launches the [gns binary](gns/) which manages networking configuration

Other tasks

`mini_init` performs various other maintenance tasks such as:

- Reclaiming unused memory- Launching the debug shell tty- Synchronizing IO when the virtual machine terminates Resizing filesystem (for wsl --manage --resize)- Formatting disks (used when installing new distributions) Back to top


\--------------------------------------------------------------------------------

- title: init - WSL
- url: https://wsl.dev/technical-documentation/init/
- date: 2026-07-15T19:31:24.307Z
- parsing method: node-html-markdown

[Skip to content](#init)

\--------------------------------------------------------------------------------

init


Table of contents

- [WSL2 specific distributions startup](#wsl2-specific-distributions-startup)- [Distribution initialization](#distribution-initialization)- [Running the distribution](#running-the-distribution)

Init

Init is top level process of a WSL distribution. For WSL1 distributions, it is launched by [wslservice](wslservice.exe/) (see `src/windows/service/LxssInstance.cpp`) and for WSL2 distributions, it is launched by [mini\_init](mini%5Finit/).

WSL2 specific distributions startup

Each WSL2 distributions runs in a separate mount, pid and UTS namespace. This allows distributions to run in parallel, without "seeing" each other.

When a WSL2 distribution starts, [mini\_init](mini%5Finit/):

- Mounts the distribution VHD- Clones into a child namespace- Chroots in the VHD mountpoint- Executes init (see the `LxMiniInitMessageLaunchInit` message).

While each distribution runs in its own mount namespace, the `/mnt/wsl` mountpoint is shared between all distributions.

Distribution initialization

Once started, the `init` process performs various initialization tasks such as:

- Mounting `/proc`, `/sys` and `/dev`- Configuring cgroups- Registering the binfmt interpreter (see [interop](interop/))- Parsing [/etc/wsl.conf](https://www.google.com/url?sa=E&q=https%3A%2F%2Flearn.microsoft.com%2Fwindows%2Fwsl%2Fwsl-config)- Starting systemd (see [systemd](systemd/))- Mounting `drvfs` drives (See [drvfs](drvfs/))- Configuring `wslg` (see [wslg](https://www.google.com/url?sa=E&q=https%3A%2F%2Fgithub.com%2Fmicrosoft%2Fwslg))

Running the distribution

Once ready, `init` establishes either an `lxbus` (WSL1) or an `hvsocket` (WSL2) connection to [wslservice](wslservice.exe/). This channel is used to transmit various commands to `init` (see `src/shared/inc/lxinitshared.h`), such as:

- `LxInitMessageInitialize`: Configure the distribution- `LxInitMessageCreateSession`: Create a new session leader. See [session leader](session-leader/)- `LxInitMessageTerminateInstance`: Terminate the distribution

Back to top


\--------------------------------------------------------------------------------

- title: session leader - WSL
- url: https://wsl.dev/technical-documentation/session-leader/
- date: 2026-07-15T19:31:24.307Z
- parsing method: node-html-markdown

[Skip to content](#session-leader)

\--------------------------------------------------------------------------------

session leader


Table of contents

- [Creating linux processes](#creating-linux-processes)
    - [Creating a WSL1 process](#creating-a-wsl1-process)- [Creating a WSL2 process](#creating-a-wsl2-process)

Session leader

A session leader is a linux process, which is forked from [init](init/) after receiving a `LxInitMessageCreateSession` message (see `src/linux/init.cpp`)

Creating linux processes

Session leaders are used to create linux processes on behalf of the user. Each linux session leader is associated to a Windows console.

To create a user process, [wslservice.exe](wslservice.exe/) sends a `LxInitMessageCreateProcess` message (WSL1) or a `LxInitMessageCreateProcessUtilityVm` message (WSL2), which contains details about the process to create such as:

- Command line- Current directory- Environment variables- User name

Creating a WSL1 process

When running in a WSL1 distribution, the session leader forks(), and uses the child process to `exec()` into the user linux process. Before calling `exec()`, child configures various settings such as:

- The user and group id- The current directory- The standard file descriptors (stdin, stdout, stderr)

Creating a WSL2 process

When running in a WSL2 distribution, the session leader forks() to create a [relay](relay/) process, which is responsible for creating the user process and relaying its output back to [wsl.exe](wsl.exe/)

Back to top


\--------------------------------------------------------------------------------

- title: relay - WSL
- url: https://wsl.dev/technical-documentation/relay/
- date: 2026-07-15T19:31:24.307Z
- parsing method: node-html-markdown

[Skip to content](#relay)

\--------------------------------------------------------------------------------

relay


Table of contents

- [Creating a user process](#creating-a-user-process)

Relay

Relay is a WSL2 Linux process created by a [session leader](session-leader/). Its job is to create a Linux process on behalf of the user, and relay its output back to Windows.

Creating a user process

A relay is created when a `LxInitMessageCreateProcessUtilityVm` message is sent to a [session leader](session-leader/). Once created, the `relay` creates multiple `hvsocket` channels with [wslservice.exe](wslservice.exe/).

These channels are used to:

- Relay standard file descriptors (stdin, stdout, stderr)- Relay information about the terminal (for instance when the terminal window is resized from Windows)- Notify Windows when the Linux process exits

Once those channels are configured, the `relay` forks() into two processes:

- The parent, which will read & write to the child's standard file descriptors and relay it to Windows- The child, which calls `exec()` and starts the user process

Back to top


\--------------------------------------------------------------------------------

- title: gns - WSL
- url: https://wsl.dev/technical-documentation/gns/
- date: 2026-07-15T19:31:24.307Z
- parsing method: node-html-markdown

[Skip to content](#gns)

\--------------------------------------------------------------------------------

gns


Table of contents

- [Networking configuration](#networking-configuration)

GNS

`gns` is a process created by `mini_init`. Its job is to configure networking within the WSL2 virtual machine.

Networking configuration

Networking settings are shared by all WSL2 distributions. While WSL2 is running, `gns` maintains an hvsocket channel to [wslservice.exe](wslservice.exe/), which is used to send various networking related configurations such as:

- Interface IP configuration- Routing table entries- DNS configuration- MTU size configuration

When DNS tunneling is enabled, `gns` is also responsible for replying to DNS requests.

See `src/linux/init/GnsEngine.cpp` and `src/windows/service/exe/GnsChannel.cpp`

Back to top


\--------------------------------------------------------------------------------

- title: localhost - WSL
- url: https://wsl.dev/technical-documentation/localhost/
- date: 2026-07-15T19:31:24.307Z
- parsing method: node-html-markdown

[Skip to content](#localhost)

\--------------------------------------------------------------------------------

localhost


Table of contents

- [NAT networking](#nat-networking)- [Mirrored networking](#mirrored-networking)- [Consomme networking](#consomme-networking)

Localhost

`localhost` is a WSL2 Linux process, created by [mini\_init](mini%5Finit/). Its role is to forward network traffic between the WSL2 virtual machine, and Windows.

NAT networking

When `wsl2.networkingMode` is set to NAT, `localhost` will watch for bound TCP ports, and relay the network traffic to Windows via [wslrelay.exe](wslrelay.exe/)

Mirrored networking

In mirrored mode, `localhost` registers a BPF program to intercept calls to `bind()`, and forward the calls to Windows via [wslservice.exe](wslservice.exe/) so Windows can route the network traffic directly to the WSL2 virtual machine.

Consomme networking

When `wsl2.networkingMode` is set to `Consomme`, the VM is given a virtio-net adapter whose host side is backed by [Consomme](https://www.google.com/url?sa=E&q=https%3A%2F%2Fgithub.com%2Fmicrosoft%2Fopenvmm%2Ftree%2Fmain%2Fvm%2Fdevices%2Fnet%2Fnet%255Fconsomme%2Fconsomme), the user-mode NAT from the [OpenVMM](https://www.google.com/url?sa=E&q=https%3A%2F%2Fgithub.com%2Fmicrosoft%2Fopenvmm) project. The guest sees a normal network (a DHCP-assigned address, a default gateway, and working DNS), but rather than going through a host NAT or bridge, its raw Ethernet frames are parsed by a user-mode process on the host and translated into ordinary host sockets. Because all traffic flows through standard host sockets, host networking policies (firewall, VPN routing, proxy settings) apply just as they would for any other host application.

Bound guest ports are tracked and forwarded to the host, optionally via [wslrelay.exe](wslrelay.exe/).

See `src/windows/common/ConsommeNetworking.cpp`.

See `src/linux/init/localhost.cpp`.

Back to top


\--------------------------------------------------------------------------------

- title: plan9 - WSL
- url: https://wsl.dev/technical-documentation/plan9/
- date: 2026-07-15T19:31:24.307Z
- parsing method: node-html-markdown

[Skip to content](#plan-9)

\--------------------------------------------------------------------------------

plan9


Table of contents

- [WSL 1](#wsl-1)- [WSL2](#wsl2)- [Accessing the distribution files from Windows](#accessing-the-distribution-files-from-windows)

Plan 9

Plan9 is a Linux process that hosts a plan9 filesystem server for WSL1 and WSL2 distributions. It's created by [init](init/) in each distribution.

WSL 1

In WSL1 distributions, `plan9` serves its filesystem through a unix socket, which can then be connected to from Windows.

WSL2

In WSL2 distributions, `plan9` runs its filesystem through an `hvsocket`

Accessing the distribution files from Windows

From Windows, a special redirector driver (p9rdr.sys) registers both `\\wsl$` and `\\wsl.localhost`. When either of those paths are accessed, `p9rdr.sys` calls [wslservice.exe](wslservice.exe/) to list the available distributions for a given Windows user.

When a distribution path is accessed (like `\\wsl.localhost\debian`), `p9rdr.sys` calls into [wslservice.exe](wslservice.exe/) via COM to start the distribution, and connect to its plan9 server, which allows the files to be accessed from Windows.

See `src/linux/init/plan9.cpp`

Back to top


\--------------------------------------------------------------------------------

- title: Boot process - WSL
- url: https://wsl.dev/technical-documentation/boot-process/
- date: 2026-07-15T19:31:24.307Z
- parsing method: node-html-markdown

[Skip to content](#the-wsl2-boot-process)

\--------------------------------------------------------------------------------

Boot process


    - Boot process [Boot process]() Table of contents \* [Overview](#overview) \* [CreateInstance()](#createinstance) \* [Starting the WSL2 virtual machine](#starting-the-wsl2-virtual-machine) \* [The Linux boot process](#the-linux-boot-process) \* [Starting a Linux distribution](#starting-a-linux-distribution) \* [Relaying the Linux process's input and output to Windows](#relaying-the-linux-processs-input-and-output-to-windows)- [Interop](interop/)- [Drvfs & Plan9](drvfs/)- [Systemd](systemd/)- [API reference](api-reference/) API reference


Table of contents

- [Overview](#overview)- [CreateInstance()](#createinstance)- [Starting the WSL2 virtual machine](#starting-the-wsl2-virtual-machine)- [The Linux boot process](#the-linux-boot-process)- [Starting a Linux distribution](#starting-a-linux-distribution)- [Relaying the Linux process's input and output to Windows](#relaying-the-linux-processs-input-and-output-to-windows)

The WSL2 boot process

This page describes the steps in the WSL2 process, from the user invoking [wsl.exe](wsl.exe/) to the user's Linux shell (bash in this example), in the WSL2 distribution.

Overview

The below diagram shows the sequence of events to start bash within a WSL2 distribution. See [WSL architecture]() for details about what each process does.

```
sequenceDiagram
    wsl.exe->>wslservice.exe: CreateInstance()
    wslservice.exe->>wsl.exe: S_OK
    wsl.exe->>wslservice.exe: CreateLxProcess(, , , ...)
    create participant mini_init
    wslservice.exe->>mini_init: LxMiniInitMessageEarlyConfig
    create participant gns
    mini_init-->>gns: fork(), exec("/gns")
    wslservice.exe->>gns: LxGnsMessageInterfaceConfiguration
    gns->>wslservice.exe: LxGnsMessageResult
    wslservice.exe->>mini_init: LxMiniInitMessageInitialConfig
    wslservice.exe->>mini_init: LxMiniInitMessageLaunchInit
    create participant init
    mini_init-->>init: fork(), exec("/init")
    init->>wslservice.exe: LxMiniInitMessageCreateInstanceResult
    wslservice.exe->>init: LxInitMessageCreateSession
    create participant session leader
    init-->>session leader: fork()
    session leader->>wslservice.exe: LxInitMessageCreateSessionResponse
    wslservice.exe->>session leader: InitCreateProcessUtilityVm
    create participant relay
    session leader-->>relay: fork()
    relay->>wslservice.exe: LxMessageResultUint32 (hvsocket connect port)
    wslservice.exe->>relay: connect hvsockets for STDIN, STDOUT, STDERR
    create participant bash
    relay-->>bash: fork(), exec("/bin/bash")
    relay<<-->>bash: relay STDIN, STDOUT, STDERR
    wslservice.exe-->>wsl.exe: S_OK + hvsockets for STDIN, STDOUT, STDERR
    wsl.exe<<->>relay: Relay STDIN, STDOUT, STDERR
    destroy bash
    relay-->>bash: waitpid()
    relay->>wsl.exe: LxInitMessageExitStatus (process exit code)

```

CreateInstance()

When [wslservice.exe](wslservice.exe/) receives the CreateInstance() call via COM, it will:

- Identify which distribution the user wants to create. This is done by looking up the `DistributionRegistration` (see `src/windows/service/exe/DistributionRegistration.cpp`) in the Windows registry, matching either on the distribution ID, or using the default if none is provided.- Based on the type of distribution (WSL1 or WSL2), either create a WSL1 instance, or start up a WSL2 virtual machine.- Associate the newly creating distribution to the calling process (see `src/windows/service/exe/Lifetime.cpp`)

Starting the WSL2 virtual machine

To start a WSL2 distribution, [wslservice.exe](wslservice.exe/) needs a virtual machine. If the virtual machine isn't already running, it will be created as part of the `CreateInstance()` call.

The WSL2 virtual machine is created via the [Host Compute System (HCS) service](https://www.google.com/url?sa=E&q=https%3A%2F%2Flearn.microsoft.com%2Fvirtualization%2Fapi%2Fhcs%2Foverview) (see `src/windows/service/exe/WslCoreVm.cpp`).

To create a new virtual machine, [wslservice.exe](wslservice.exe/) generates a JSON string, which describes the virtual machine configuration. This JSON is then passed to [HcsCreateComputeSystem()](https://www.google.com/url?sa=E&q=https%3A%2F%2Flearn.microsoft.com%2Fvirtualization%2Fapi%2Fhcs%2Freference%2Fhcscreatecomputesystem) to create a new virtual machine.

See `src/windows/common/hcs_schema.h` for more details on the HCS JSON schema.

Part of the JSON configuration includes:

- The kernel: WSL will use its built-in kernel, usually installed in `C:\Program Files\WSL\tools\kernel`, or a custom kernel if overridden via [.wslconfig](https://www.google.com/url?sa=E&q=https%3A%2F%2Flearn.microsoft.com%2Fwindows%2Fwsl%2Fwsl-config)- The initramfs: WSL uses its own initramfs (usually installed in `C:\Program Files\WSL\tools\initrd.img`). It's an image that only contains the [mini\_init](mini%5Finit/) binary- The resources accessible to the virtual machine such as CPU, RAM, GPU, etc

When started, the virtual machine will boot into the provided kernel, and then execute [mini\_init](mini%5Finit/).

The Linux boot process

[mini\_init](mini%5Finit/) is the process that performs usermode initialization inside the virtual machine. After performing various configurations, `mini_init` receives a `LxMiniInitMessageEarlyConfig` message from the [wslservice.exe](wslservice.exe/) which contains the following information:

- Identifiers for the system VHD, swap VHD and kernel modules VHD if any- The machine's hostname- The configured memory reclaim mode and page reporting order

[mini\_init](mini%5Finit/) then creates the [gns process](gns/), which is responsible for networking configuration and then receives a `LxMiniInitMessageInitialConfig` message, which contains:

- An entropy buffer, to seed the virtual machine's entropy- Information about the GPU drivers shares to mount, if any- Whether [wslg](https://www.google.com/url?sa=E&q=https%3A%2F%2Fgithub.com%2Fmicrosoft%2Fwslg) is enabled

After applying all the configuration requested by [wslservice.exe](wslservice.exe/), the virtual machine is ready to start Linux distributions.

Starting a Linux distribution

To start a new distribution, [wslservice.exe](wslservice.exe/) sends a `LxMiniInitMessageLaunchInit` message to [mini\_init](mini%5Finit/), which then mounts the distribution vhd and starts [init](init/). See [init](init/) for more details on WSL2 distributions configuration.

Once running, [wslservice.exe](wslservice.exe/) can then send a `LxInitMessageCreateSession` message to start a new [session leader](session-leader/) inside that distribution, which can be used to launch Linux processes

Relaying the Linux process's input and output to Windows

Once the user's Linux process has been created, [wslservice.exe](wslservice.exe/) can return from `CreateLxProcess()` back to [wsl.exe](wsl.exe/). In the case of WSL2, [wsl.exe](wsl.exe/) receives the following HANDLES:

- STDIN- STDOUT- STDERR- Control channel- Interop channel

The `STDIN`, `STDOUT` and `STDERR` handles are used to relay input and output from the Linux process to the Windows terminal. Depending on the type of handle (terminal, pipe, file, ...), [wsl.exe](wsl.exe/) will apply different relaying logics (see `src/windows/common/relay.cpp`) to achieve the best compatibility between Windows & Linux.

The `Control channel` is used to notify the Linux process of a change in the terminal (for instance when [wsl.exe's](wsl.exe/) terminal window is resized) so these changes can be applied to the Linux process as well.

The `Interop channel` has two usages:

- Create Windows processes from Linux (see [interop](interop/))- Notify [wsl.exe](wsl.exe/) when the Linux process has exited (see `LxInitMessageExitStatus`)

Once the Linux process has exited, [wsl.exe](wsl.exe/) flushes all remaining IO, and exits with the same exit code as the Linux process.

If [wsl.exe](wsl.exe/) is terminated before the Linux process exits, [wslhost.exe](wslhost.exe/) will take over the `Interop channel` and continue to handle requests to execute Windows processes.

Back to top


\--------------------------------------------------------------------------------

- title: Interop - WSL
- url: https://wsl.dev/technical-documentation/interop/
- date: 2026-07-15T19:31:24.307Z
- parsing method: node-html-markdown

[Skip to content](#running-windows-executables-from-linux)

\--------------------------------------------------------------------------------

Interop


Table of contents

- [binfmt interpreters for Windows executables](#binfmt-interpreters-for-windows-executables)- [Connecting to interop servers](#connecting-to-interop-servers)

Running Windows executables from Linux

The ability to launch Windows processes from Linux is controlled by 2 different levels of settings:

- The `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LxssManager\DistributionFlags` registry value, which controls the settings for all Windows users (setting the lowest significance bit disables interop)- The `[interop]` section in [/etc/wsl.conf](https://www.google.com/url?sa=E&q=https%3A%2F%2Flearn.microsoft.com%2Fwindows%2Fwsl%2Fwsl-config%23wslconf), which controls the setting for a given WSL distribution.

binfmt interpreters for Windows executables

To allow Windows process creation from Linux, WSL registers a [binfmt interpreter](https://www.google.com/url?sa=E&q=https%3A%2F%2Fdocs.kernel.org%2Fadmin-guide%2Fbinfmt-misc.html), which tells the kernel to execute an arbitrary command when a specific type of executable is launched via `exec*()` system calls.

To perform the registration, WSL writes to `/proc/sys/fs/binfmt_misc` and creates a `WSLInterop` entry, which points to `/init`. For WSL1 registration, the entry is written by [init](init/) for each distribution, for WSL2 [mini\_init](mini%5Finit/) registers the binfmt interpreter at the virtual machine level.

Note: The `/init` executable is the entrypoint for different WSL processes ([init](init/), [plan9](plan9/), [localhost](localhost/), etc). This executable looks at `argv[0]` to determine which logic to run. In the case of interop, `/init` will run the Windows process creation logic if its `argv[0]` value doesn't match any of the known entrypoints.

See: `WslEntryPoint()` in `src/linux/init.cpp`.

Connecting to interop servers

When the user tries to execute a Windows process, the kernel will launch `/init` with the Windows process's command line as arguments.

To start a new Windows process `/init` needs to connect to an interop server. Interop servers are special Linux processes that act as bridges between Linux and Windows. They maintain secure communication channels (through hvsocket connections) with Windows processes ([wsl.exe](wsl.exe/) or [wslhost.exe](wslhost.exe/)) to launch Windows executables.

Inside Linux, each [session leader](session-leader/), and each instance of [init](init/) has an associated interop server, which is serving via an unix socket under `/run/WSL`.

`/init` uses the `$WSL_INTEROP` environment variable to know which server to connect to. If the variable is not set, `/init` will try to connect to `/run/WSL/${pid}_interop`, with its own PID. If that doesn't work, `/init` will try its parent's pid, and then will continue to go up the chain until it reached [init](init/).

Once connected `/init` sends a `LxInitMessageCreateProcess` (WSL1) or a `LxInitMessageCreateProcessUtilityVm` (WSL2), which then forwards that message to the associated Windows process, which will launch the requested command and relay its output to `/init`.

See `src/linux/init/binfmt.cpp`

Back to top


\--------------------------------------------------------------------------------

- title: Drvfs & Plan9 - WSL
- url: https://wsl.dev/technical-documentation/drvfs/
- date: 2026-07-15T19:31:24.307Z
- parsing method: node-html-markdown

[Skip to content](#accessing-windows-drives-from-linux)

\--------------------------------------------------------------------------------

Drvfs & Plan9


Table of contents

- [Elevated vs non-elevated mountpoints](#elevated-vs-non-elevated-mountpoints)- [Mounting a Windows drive](#mounting-a-windows-drive)- [Mounting a drive from Linux](#mounting-a-drive-from-linux)

Accessing Windows drives from Linux

WSL offers mountpoints to access Windows drives from Linux. These mountpoints are mounted under `/mnt` by default, and point to the root of Windows drives.

Elevated vs non-elevated mountpoints

Within a distribution, WSL separates between Linux processes that have been created from an elevated (as in administrator level) and from a non-elevated (user level) context.

This is done by having two separate [mount namespaces](https://www.google.com/url?sa=E&q=https%3A%2F%2Fman7.org%2Flinux%2Fman-pages%2Fman7%2Fmount%255Fnamespaces.7.html) within the distribution. One of them offers an elevated access to Windows drives, and the other offers a non-elevated access to Windows drives.

When a Linux process is created, [wslservice.exe](wslservice.exe/) determines its elevation status, and then tells [init](init/) to create the process in the appropriate mount namespace.

Mounting a Windows drive

\*Note: This section only applies to WSL2 distributions. \*

When a [session leader](session-leader/) is created, [wslservice.exe](wslservice.exe/) starts a [plan9](https://www.google.com/url?sa=E&q=https%3A%2F%2F9fans.github.io%2Fplan9port%2Fman%2Fman9%2Fintro.html) file server. This file server can be connected to from the WSL2 virtual machine to mount Windows drives.

When the WSL distribution is created, [wslservice.exe](wslservice.exe/) uses the `LX_INIT_CONFIGURATION_INFORMATION` message to indicate whether the process that created the distribution is elevated or not. Based on this, [init](init/) will mount either the elevated, or un-elevated version of the plan9 server.

Later when the first command is created in the namespace that hasn't been mounted yet, (either elevated, or non-elevated), [wslservice.exe](wslservice.exe/) sends a `LxInitMessageRemountDrvfs` to [init](init/), which tells `init` to mount the other namespace.

See: `src/windows/service/exe/WslCoreInstance.cpp` and `src/linux/drvfs.cpp`.

Mounting a drive from Linux

As long as the Windows plan9 server is running, drives can be mounted simply by calling [mount](https://www.google.com/url?sa=E&q=https%3A%2F%2Flinux.die.net%2Fman%2F8%2Fmount). For instance mounting the C: drive manually can be done via:

`[](#%5F%5Fcodelineno-0-1)mount -t drvfs C: /tmp/my-mount-point`

Internally, this is handled by `/usr/sbin/mount.drvfs`, which is a symlink to `/init`. When `/init` starts, it looks at `argv[0]` to determine which entrypoint to run. If `argv[0]` is `mount.drvfs`, then `/init` runs the `mount.drvfs` entrypoint (see `MountDrvfsEntry()` in `src/linux/init/drvfs.cpp`).

Depending on the distribution configuration, `mount.drvfs` will either mount the drive as `drvfs` (WSL1), or `plan9`, `virtio-plan9` or `virtiofs` (WSL), depending on [.wslconfig](https://www.google.com/url?sa=E&q=https%3A%2F%2Flearn.microsoft.com%2Fwindows%2Fwsl%2Fwsl-config).

Back to top

