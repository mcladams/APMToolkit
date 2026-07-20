\--------------------------------------------------------------------------------

- title: WSL container API C++ reference - WSL
- url: https://wsl.dev/api-reference/cpp/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wsl-container-api-c-reference)

# WSL container API C++ reference

This reference documents the **C++/WinRT projection** in `Microsoft::WSL::Containers`.

**Preview notice:**`wslcsdk.h` explicitly marks this API as **preview** and subject to breaking changes.

**Header:**`#include <winrt/Microsoft.WSL.Containers.h>`

**Namespace:**`winrt::Microsoft::WSL::Containers`

The projection is layered as **Session → Container → Process**. Errors surface as `winrt::hresult_error`. Image and installation operations use `IAsyncActionWithProgress<T>`.

\--------------------------------------------------------------------------------

In this reference

- [Data Classes](data-classes/)- [Settings Classes](settings-classes/)- [Core Classes](core-classes/)- [Service Class](service-class/)- [Delegates and Events](delegates-and-events/)- [Enumerations](enumerations/)- [Not Yet Implemented and Known Gaps](not-yet-implemented-and-known-gaps/)- [End-to-End Example](end-to-end-example/)

\--------------------------------------------------------------------------------

- title: Data Classes - WSL
- url: https://wsl.dev/api-reference/cpp/data-classes/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#data-classes)

Data Classes

Members

- [ImageInfo](imageinfo/)- [ImageProgress](imageprogress/)- [InstallProgress](installprogress/)- [ContainerPortMapping](containerportmapping/)- [ContainerVolume](containervolume/)- [ContainerNamedVolume](containernamedvolume/)- [Referenced](referenced/)

\--------------------------------------------------------------------------------

- title: ImageInfo - WSL
- url: https://wsl.dev/api-reference/cpp/data-classes/imageinfo/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#imageinfo)

ImageInfo

Read-only wrapper created from `WslcImageInfo`.

**Properties**

- `Name()` → image name- `Sha256()` → 32-byte buffer- `Size()` → image size- `CreatedTimestamp()` → WinRT `DateTime`

```
auto images = session.GetImages();
for (auto const& image : images)
{
    auto name = image.Name();
    auto hash = image.Sha256();
    auto size = image.Size();
    auto created = image.CreatedTimestamp();
}
```

\--------------------------------------------------------------------------------

- title: ImageProgress - WSL
- url: https://wsl.dev/api-reference/cpp/data-classes/imageprogress/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#imageprogress)

ImageProgress

Progress item reported by image pull/import/load/push operations.

**Properties**

- `Id()`- `Status()`- `CurrentBytes()`- `TotalBytes()`

```
auto op = session.LoadImageAsync(L"C:\\images\\demo.tar");
op.Progress([](auto&&, ImageProgress const& p)
{
    printf("layer=%ws status=%d %llu/%llu\n",
        p.Id().c_str(),
        static_cast<int>(p.Status()),
        p.CurrentBytes(),
        p.TotalBytes());
});
co_await op;
```

\--------------------------------------------------------------------------------

- title: InstallProgress - WSL
- url: https://wsl.dev/api-reference/cpp/data-classes/installprogress/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#installprogress)

InstallProgress

Progress item reported by `WslcService::InstallWithDependenciesAsync()`.

**Properties**

- `Component()`- `Progress()`- `Total()`

```
auto install = WslcService::InstallWithDependenciesAsync();
install.Progress([](auto&&, InstallProgress const& p)
{
    printf("component=%d step=%u/%u\n",
        static_cast<int>(p.Component()),
        p.Progress(),
        p.Total());
});
co_await install;
```

\--------------------------------------------------------------------------------

- title: ContainerPortMapping - WSL
- url: https://wsl.dev/api-reference/cpp/data-classes/containerportmapping/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#containerportmapping)

ContainerPortMapping

Maps a Windows host port to a container port.

**Constructors / properties**

- `ContainerPortMapping(uint16_t windowsPort, uint16_t containerPort, PortProtocol protocol)`- `WindowsPort()` / setter- `ContainerPort()` / setter- `Protocol()` / setter- `WindowsAddress()` / setter

**Important notes**

- `WindowsAddress` is implemented.- The setter accepts only `Windows::Networking::HostName` values whose type is `Ipv4` or `Ipv6`.- `ToStruct()` uses `inet_pton` and stores a real `sockaddr_in` / `sockaddr_in6`.

```
using namespace winrt::Windows::Networking;

ContainerPortMapping mapping{ 8080, 80, PortProtocol::TCP };
mapping.WindowsAddress(HostName{ L"127.0.0.1" });

auto hostPort = mapping.WindowsPort();
auto guestPort = mapping.ContainerPort();
auto protocol = mapping.Protocol();
auto bindAddress = mapping.WindowsAddress();
```

\--------------------------------------------------------------------------------

- title: ContainerVolume - WSL
- url: https://wsl.dev/api-reference/cpp/data-classes/containervolume/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#containervolume)

ContainerVolume

Binds a Windows path into the container.

**Constructors / properties**

- `ContainerVolume(hstring windowsPath, hstring containerPath, bool readOnly)`- `WindowsPath()` / setter- `ContainerPath()` / setter- `ReadOnly()` / setter

```
ContainerVolume volume{ L"C:\\data", L"/workspace", false };
volume.ReadOnly(true);
volume.WindowsPath(L"C:\\data");
volume.ContainerPath(L"/workspace");
```

\--------------------------------------------------------------------------------

- title: ContainerNamedVolume - WSL
- url: https://wsl.dev/api-reference/cpp/data-classes/containernamedvolume/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#containernamedvolume)

ContainerNamedVolume

Attaches a named session VHD volume to a container.

**Constructors / properties**

- `ContainerNamedVolume(hstring name, hstring containerPath, bool readOnly)`- `Name()` / setter- `ContainerPath()` / setter- `ReadOnly()` / setter

```
ContainerNamedVolume named{ L"build-cache", L"/cache", false };
named.Name(L"build-cache");
named.ContainerPath(L"/cache");
named.ReadOnly(false);
```

\--------------------------------------------------------------------------------

- title: Referenced - WSL
- url: https://wsl.dev/api-reference/cpp/data-classes/referenced/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#referenced)

Referenced

- `Session::PullImageAsync(PullImageOptions)` forwards a struct whose C shape is `{ uri, progressCallback, progressCallbackContext, registryAuth }`.- `Session::PushImageAsync(PushImageOptions)` forwards a struct whose C shape is `{ image, registryAuth, progressCallback, progressCallbackContext }`.- `Session::TagImage(TagImageOptions)` forwards a struct whose C shape is `{ image, repo, tag }`.- `Session::CreateVhdVolume(VhdOptions)` and `SessionSettings::VhdRequirements(VhdOptions)` use `VhdOptions` properties `Name`, `Size`, `Type`, and `Owner`.- `WslcService::GetVersion()` returns a `ServiceVersion` created from C `major`, `minor`, and `revision` values.

```
PullImageOptions pullOptions = /* construct using the wrapper available in your build */;
auto pull = session.PullImageAsync(pullOptions);
pull.Progress([](auto&&, ImageProgress const& p) { /* ... */ });
co_await pull;

PushImageOptions pushOptions = /* construct using the wrapper available in your build */;
co_await session.PushImageAsync(pushOptions);

TagImageOptions tagOptions = /* construct using the wrapper available in your build */;
session.TagImage(tagOptions);

VhdOptions vhdOptions = /* construct using the wrapper available in your build */;
session.CreateVhdVolume(vhdOptions);

auto version = WslcService::GetVersion();
(void)version;
```

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: Settings Classes - WSL
- url: https://wsl.dev/api-reference/cpp/settings-classes/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#settings-classes)

Settings Classes

Settings objects become effectively immutable after the wrapper materializes the underlying C struct.

Members

- [SessionSettings](sessionsettings/)- [ContainerSettings](containersettings/)- [ProcessSettings](processsettings/)- [VhdOptions](vhdoptions/)

\--------------------------------------------------------------------------------

- title: SessionSettings - WSL
- url: https://wsl.dev/api-reference/cpp/settings-classes/sessionsettings/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#sessionsettings)

SessionSettings

**Constructor**

- `SessionSettings(hstring name, hstring storagePath)`- `name` must be non-empty. The name of the session to be created.- `storagePath` must be non-empty. Path to where the session storage should be written. If the path doesn't exist, it will be created.

Session names serve both as display names and as machine-wide keys used to identify sessions. If a session with the same name already exists, session creation will fail with `ERROR_ALREADY_EXISTS`.

Also note that the following information about a session is visible to all users on the machine:

- The session's name- The SID of the user that created the session- The PID of the process that created the session

Do not put credentials or other sensitive information in the session's name.

**Properties**

- `Name()` / setter- `StoragePath()` / setter- `CpuCount()` / setter (`0` rejected)- `MemorySizeInMB()` / setter (`0` rejected)- `Timeout()` / setter- cannot be zero- cannot be negative- converted to **milliseconds** and must fit in `uint32_t`- `VhdRequirements()` / setter- setter rejects `nullptr`- `EnableGpu()` / setter

```
SessionSettings settings{ L"demo", L"C:\\WSLC\\demo" };
settings.Name(L"demo");
settings.StoragePath(L"C:\\WSLC\\demo");
settings.CpuCount(winrt::box_value<uint32_t>(4).as<winrt::Windows::Foundation::IReference<uint32_t>>());
settings.MemorySizeInMB(winrt::box_value<uint32_t>(4096).as<winrt::Windows::Foundation::IReference<uint32_t>>());
settings.Timeout(winrt::box_value(winrt::Windows::Foundation::TimeSpan{ std::chrono::minutes(5) })
    .as<winrt::Windows::Foundation::IReference<winrt::Windows::Foundation::TimeSpan>>());
settings.EnableGpu(true);

auto name = settings.Name();
auto path = settings.StoragePath();
auto cpu = settings.CpuCount();
auto memory = settings.MemorySizeInMB();
auto timeout = settings.Timeout();
auto enableGpu = settings.EnableGpu();
```

\--------------------------------------------------------------------------------

- title: ContainerSettings - WSL
- url: https://wsl.dev/api-reference/cpp/settings-classes/containersettings/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#containersettings)

ContainerSettings

**Constructor**

- `ContainerSettings(hstring imageName)`- `imageName` must be non-empty.

**Properties**

- `ImageName()` / setter- `Name()` / setter- `InitProcess()` / setter- `NetworkingMode()` / setter (`None` and `Bridged` only)- `HostName()` / setter- `DomainName()` / setter- `EnableAutoRemove()` / setter- `EnableGpu()` / setter- `Privileged()` / setter- `PortMappings()` / setter- `Volumes()` / setter- `NamedVolumes()` / setter

**Important notes**

- Collection setters reject `nullptr`.- When converting to the C struct, null elements inside the collections are rejected.

\--------------------------------------------------------------------------------

- title: ProcessSettings - WSL
- url: https://wsl.dev/api-reference/cpp/settings-classes/processsettings/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#processsettings)

ProcessSettings

**Properties**

- `WorkingDirectory()` / setter- `CommandLine()` / setter- `EnvironmentVariables()` / setter- `OutputMode()` / setter

**Important notes**

- `CommandLine(nullptr)` and `EnvironmentVariables(nullptr)` are rejected.- `Process::Start()` later requires a **non-empty** `CommandLine()`.- `ProcessOutputMode::Event` installs C callbacks; `ProcessOutputMode::Stream` expects stream access; `Discard` is the default.

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: VhdOptions - WSL
- url: https://wsl.dev/api-reference/cpp/settings-classes/vhdoptions/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#vhdoptions)

VhdOptions

**Properties**

- `Name()` / setter- `Size()` / setter- `Type()` / setter- `Owner()` / setter

```
VhdOptions options;
options.Name(L"build-cache");
options.Size(10ull * 1024 * 1024 * 1024);
options.Type(VhdType::Dynamic);
options.Owner({ 1000, 1000 });
```

\--------------------------------------------------------------------------------

- title: Core Classes - WSL
- url: https://wsl.dev/api-reference/cpp/core-classes/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#core-classes)

Core Classes

Members

- [Session](session/)- [Container](container/)- [Process](process/)

\--------------------------------------------------------------------------------

- title: Session - WSL
- url: https://wsl.dev/api-reference/cpp/core-classes/session/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#session)

Session

**Constructor**

- `Session(SessionSettings settings)`- rejects `nullptr` settings.

**Methods**

- `Start()`- `Terminate()`- `CreateContainer(ContainerSettings containerSettings)`- `PullImage(PullImageOptions options)`- `PullImageAsync(PullImageOptions options)`- `ImportImage(hstring path, hstring imageName)`- `ImportImageAsync(hstring path, hstring imageName)`- `LoadImage(hstring path)`- `LoadImageAsync(hstring path)`- `PushImage(PushImageOptions options)`- `PushImageAsync(PushImageOptions options)`- `DeleteImage(hstring nameOrId)`- `TagImage(TagImageOptions options)`- `CreateVhdVolume(VhdOptions options)`- `DeleteVhdVolume(hstring name)`- `Authenticate(Uri serverAddress, hstring username, hstring password)`- `GetImages()`- event `Terminated`- event `ProcessCrashed`- `Close()`

**Behavior notes**

- `Start()` is one-shot; calling it twice throws.- Most methods call `EnsureStarted()` first.- `ImportImage` / `ImportImageAsync` and `LoadImage` / `LoadImageAsync` are path-based only.- `Authenticate` requires a non-null `Uri` and non-empty username.- `GetImages()` materializes WinRT `ImageInfo` objects from the C array returned by `WslcListSessionImages`.

**Examples**

```
Session session{ settings };
session.Terminated([](SessionTerminationReason reason)
{
    printf("session terminated: %d\n", static_cast<int>(reason));
});
session.ProcessCrashed([](ProcessCrashInformation const& info)
{
    printf("process crashed: %ws\n", info.ProcessName().c_str());
});
session.Start();
```
```
auto container = session.CreateContainer(containerSettings);
```
```
auto importOp = session.ImportImageAsync(L"C:\\images\\alpine.tar", L"demo/alpine:latest");
importOp.Progress([](auto&&, ImageProgress const& p) { /* progress */ });
co_await importOp;
```
```
auto loadOp = session.LoadImageAsync(L"C:\\images\\bundle.tar");
co_await loadOp;
```
```
session.DeleteImage(L"demo/alpine:latest");
```
```
auto token = session.Authenticate(
    winrt::Windows::Foundation::Uri{ L"https://registry.example.com" },
    L"user",
    L"password");
```
```
auto images = session.GetImages();
for (auto const& image : images)
{
    printf("%ws\n", image.Name().c_str());
}
```
```
PullImageOptions pullOptions = {};
auto pullOp = session.PullImageAsync(pullOptions);
pullOp.Progress([](auto&&, ImageProgress const& p) { /* progress */ });
co_await pullOp;

PushImageOptions pushOptions = {};
co_await session.PushImageAsync(pushOptions);

TagImageOptions tagOptions = {};
session.TagImage(tagOptions);

VhdOptions vhdOptions = {};
session.CreateVhdVolume(vhdOptions);
session.DeleteVhdVolume(L"build-cache");
```
```
session.Terminate();
```

\--------------------------------------------------------------------------------

- title: Container - WSL
- url: https://wsl.dev/api-reference/cpp/core-classes/container/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#container)

Container

**Methods**

- `Start()`- `Stop(Signal signal, TimeSpan timeout)`- `Delete(DeleteContainerOption options)`- `CreateProcess(ProcessSettings newProcessSettings)`- `Inspect()`- `Id()`- `InitProcess()`- `State()`- `Close()`

**Behavior notes**

- `Start()` automatically sets `WSLC_CONTAINER_START_FLAG_ATTACH` if an init process exists and its output mode is `Event` or `Stream`.- `Stop()` converts the timeout to **seconds**, rejects negative values, and rejects values that exceed `uint32_t`.- `InitProcess()` throws if the container was not configured with one.

**Examples**

```
container.Start();
```
```
container.Stop(static_cast<Signal>(15), std::chrono::seconds(10));
```
```
container.Delete(DeleteContainerOption::None);
```
```
auto proc = container.CreateProcess(procSettings);
```
```
auto inspectJson = container.Inspect();
auto id = container.Id();
auto state = container.State();
```
```
auto init = container.InitProcess();
```

\--------------------------------------------------------------------------------

- title: Process - WSL
- url: https://wsl.dev/api-reference/cpp/core-classes/process/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#process)

Process

`Process` objects are returned by `Container::CreateProcess()` and `Container::InitProcess()`.

**Methods / events**

- `Start()`- `Signal(Signal signal)`- `GetOutputStream(ProcessOutputHandle outputHandle)`- `GetInputStream()`- `Pid()`- `State()`- `ExitCode()`- event `OutputReceived`- event `ErrorReceived`- event `Exited`- `Close()`

**Behavior notes**

- `Start()` cannot be called on the init process.- `Start()` requires a non-empty `ProcessSettings::CommandLine()`.- `GetOutputStream()` requires `ProcessOutputMode::Stream`.- `OutputReceived` and `ErrorReceived` require `ProcessOutputMode::Event`.- `Exited` is raised by the exit callback in event mode, and by waiting on the process exit event in stream/discard mode.

**Examples**

```
auto proc = container.CreateProcess(procSettings);
proc.Exited([](int32_t exitCode)
{
    printf("process exited: %d\n", exitCode);
});
proc.Start();
```
```
auto pid = proc.Pid();
auto state = proc.State();
```
```
proc.Signal(static_cast<Signal>(2)); // SIGINT
```
```
auto stdinStream = proc.GetInputStream();
```
```
ProcessSettings streamSettings;
streamSettings.OutputMode(ProcessOutputMode::Stream);
// ... set CommandLine ...
auto streamProc = container.CreateProcess(streamSettings);
streamProc.Start();
auto stdoutStream = streamProc.GetOutputStream(static_cast<ProcessOutputHandle>(1));
auto stderrStream = streamProc.GetOutputStream(static_cast<ProcessOutputHandle>(2));
```
```
ProcessSettings eventSettings;
eventSettings.OutputMode(ProcessOutputMode::Event);
// ... set CommandLine ...
auto eventProc = container.CreateProcess(eventSettings);
eventProc.OutputReceived([](auto const& data)
{
    printf("stdout bytes: %zu\n", data.size());
});
eventProc.ErrorReceived([](auto const& data)
{
    printf("stderr bytes: %zu\n", data.size());
});
eventProc.Exited([](int32_t exitCode)
{
    printf("done: %d\n", exitCode);
});
eventProc.Start();
```
```
auto exitCode = proc.ExitCode();
```

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: Service Class - WSL
- url: https://wsl.dev/api-reference/cpp/service-class/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#service-class)

Service Class

Members

- [WslcService](wslcservice/)

\--------------------------------------------------------------------------------

- title: WslcService - WSL
- url: https://wsl.dev/api-reference/cpp/service-class/wslcservice/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcservice)

WslcService

Static entry points over the service-level C API.

**Methods**

- `GetMissingComponents()`- `GetVersion()`- `InstallWithDependencies()`- `InstallWithDependenciesAsync()`

**Behavior notes**

- `GetMissingComponents()` returns a `Component` bitmask.- `GetVersion()` returns a `ServiceVersion` constructed from `major`, `minor`, and `revision`.- `InstallWithDependencies()` installs dependencies synchronously.- `InstallWithDependenciesAsync()` runs on a background thread and reports `InstallProgress`.

```
auto missing = WslcService::GetMissingComponents();
if (missing != static_cast<Component>(0))
{
    auto install = WslcService::InstallWithDependenciesAsync();
    install.Progress([](auto&&, InstallProgress const& p)
    {
        printf("install %u/%u\n", p.Progress(), p.Total());
    });
    co_await install;
}
```
```
auto version = WslcService::GetVersion();
(void)version;
```

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: Delegates and Events - WSL
- url: https://wsl.dev/api-reference/cpp/delegates-and-events/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#delegates-and-events)

Delegates and Events

Members

- [SessionTerminationHandler](sessionterminationhandler/)- [ProcessCrashHandler](processcrashhandler/)- [ProcessOutputHandler](processoutputhandler/)- [ProcessExitHandler](processexithandler/)

\--------------------------------------------------------------------------------

- title: SessionTerminationHandler - WSL
- url: https://wsl.dev/api-reference/cpp/delegates-and-events/sessionterminationhandler/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#sessionterminationhandler)

SessionTerminationHandler

Observed use:

- `Session::Terminated` raises one argument: `SessionTerminationReason reason`.

```
session.Terminated([](SessionTerminationReason reason)
{
    printf("terminated: %d\n", static_cast<int>(reason));
});
```

\--------------------------------------------------------------------------------

- title: ProcessCrashHandler - WSL
- url: https://wsl.dev/api-reference/cpp/delegates-and-events/processcrashhandler/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#processcrashhandler)

ProcessCrashHandler

Observed use:

- `Session::ProcessCrashed` raises one `ProcessCrashInformation` argument.

```
session.ProcessCrashed([](ProcessCrashInformation const& info)
{
    printf("process crashed: %ws\n", info.ProcessName().c_str());
});
```

\--------------------------------------------------------------------------------

- title: ProcessOutputHandler - WSL
- url: https://wsl.dev/api-reference/cpp/delegates-and-events/processoutputhandler/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#processoutputhandler)

ProcessOutputHandler

Observed use:

- `Process::OutputReceived` and `Process::ErrorReceived` raise one argument containing raw output bytes.- The wrapper forwards a `winrt::array_view<const uint8_t>` produced from the C callback buffer.

```
process.OutputReceived([](auto const& data)
{
    std::string text(data.begin(), data.end());
    printf("stdout: %s\n", text.c_str());
});
```

\--------------------------------------------------------------------------------

- title: ProcessExitHandler - WSL
- url: https://wsl.dev/api-reference/cpp/delegates-and-events/processexithandler/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#processexithandler)

ProcessExitHandler

Observed use:

- `Process::Exited` raises one `int32_t exitCode`.

```
process.Exited([](int32_t exitCode)
{
    printf("exit code: %d\n", exitCode);
});
```

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: Enumerations - WSL
- url: https://wsl.dev/api-reference/cpp/enumerations/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#enumerations)

Enumerations

For enums that are directly `static_cast` to/from the C API, the numeric values match the corresponding `Wslc*` enum in `wslcsdk.h`.

Members

- [Component](component/)- [DeleteContainerOption](deletecontaineroption/)- [Error](error/)- [ContainerNetworkingMode](containernetworkingmode/)- [PortProtocol](portprotocol/)- [ContainerState](containerstate/)- [Signal](signal/)- [ProcessOutputHandle](processoutputhandle/)- [ProcessOutputMode](processoutputmode/)- [ProcessState](processstate/)- [VhdType](vhdtype/)- [ImageProgressStatus](imageprogressstatus/)- [SessionTerminationReason](sessionterminationreason/)

\--------------------------------------------------------------------------------

- title: Component - WSL
- url: https://wsl.dev/api-reference/cpp/enumerations/component/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#component)

Component

`WslcService::GetMissingComponents()` returns a `Component` bitmask.

Underlying values:

- `VirtualMachinePlatform = 1`- `WslPackage = 2`- `SdkNeedsUpdate = 4`

```
auto missing = WslcService::GetMissingComponents();
if (missing != static_cast<Component>(0))
{
    co_await WslcService::InstallWithDependenciesAsync();
}
```

\--------------------------------------------------------------------------------

- title: DeleteContainerOption - WSL
- url: https://wsl.dev/api-reference/cpp/enumerations/deletecontaineroption/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#deletecontaineroption)

DeleteContainerOption

`Container::Delete()` takes `DeleteContainerOption`.

Underlying values:

- `None = 0`- `Force = 1`

```
container.Delete(DeleteContainerOption::Force);
```

\--------------------------------------------------------------------------------

- title: Error - WSL
- url: https://wsl.dev/api-reference/cpp/enumerations/error/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#error)

Error

Underlying HRESULT values:

- `ImageNotFound = -2147219967`- `ContainerPrefixAmbiguous = -2147219966`- `ContainerNotFound = -2147219965`- `VolumeNotFound = -2147219964`- `ContainerNotRunning = -2147219963`- `ContainerIsRunning = -2147219962`- `SessionReserved = -2147219961`- `InvalidSessionName = -2147219960`- `NetworkNotFound = -2147219959`- `WindowsUpdateSearchFailed = -2147219958`- `SdkUpdateNeeded = -2147219957`- `ContainerDisabled = -2147219956`- `RegistryBlockedByPolicy = -2147219955`- `VolumeNotAvailable = -2147219954`

\--------------------------------------------------------------------------------

- title: ContainerNetworkingMode - WSL
- url: https://wsl.dev/api-reference/cpp/enumerations/containernetworkingmode/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#containernetworkingmode)

ContainerNetworkingMode

`winrt_ContainerSettings.cpp` explicitly validates only:

- `None`- `Bridged`

Underlying C values:

- `None = 0`- `Bridged = 1`

```
containerSettings.NetworkingMode(ContainerNetworkingMode::Bridged);
```

\--------------------------------------------------------------------------------

- title: PortProtocol - WSL
- url: https://wsl.dev/api-reference/cpp/enumerations/portprotocol/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#portprotocol)

PortProtocol

- `TCP` is the default in `winrt_ContainerPortMapping.h`.- The value is passed directly to `WslcContainerPortMapping::protocol`.

Underlying C values:

- `TCP = 0`- `UDP = 1`

```
ContainerPortMapping mapping{ 8080, 80, PortProtocol::TCP };
```

\--------------------------------------------------------------------------------

- title: ContainerState - WSL
- url: https://wsl.dev/api-reference/cpp/enumerations/containerstate/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#containerstate)

ContainerState

`Container::State()` casts directly from `WslcContainerState`.

Underlying C values:

- `Invalid = 0`- `Created = 1`- `Running = 2`- `Exited = 3`- `Deleted = 4`

```
auto state = container.State();
if (state == static_cast<ContainerState>(2))
{
    // running
}
```

\--------------------------------------------------------------------------------

- title: Signal - WSL
- url: https://wsl.dev/api-reference/cpp/enumerations/signal/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#signal)

Signal

`Container::Stop()` and `Process::Signal()` cast directly to `WslcSignal`.

Underlying values:

- `None = 0`- `SIGHUP = 1`- `SIGINT = 2`- `SIGQUIT = 3`- `SIGKILL = 9`- `SIGTERM = 15`

```
process.Signal(Signal::SIGINT);
container.Stop(Signal::SIGTERM, std::chrono::seconds(10));
```

\--------------------------------------------------------------------------------

- title: ProcessOutputHandle - WSL
- url: https://wsl.dev/api-reference/cpp/enumerations/processoutputhandle/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#processoutputhandle)

ProcessOutputHandle

`Process::GetOutputStream(ProcessOutputHandle)` accepts these values:

- `StandardOutput = 1`- `StandardError = 2`

```
auto stdoutStream = process.GetOutputStream(ProcessOutputHandle::StandardOutput);
```

\--------------------------------------------------------------------------------

- title: ProcessOutputMode - WSL
- url: https://wsl.dev/api-reference/cpp/enumerations/processoutputmode/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#processoutputmode)

ProcessOutputMode

Underlying values:

- `Discard = 0`- `Stream = 1`- `Event = 2`

Behavior:

- `Discard`: no stdout/stderr events or output streams.- `Stream`: `GetOutputStream(...)` can be used.- `Event`: stdout/stderr are delivered by callbacks and `OutputReceived` / `ErrorReceived`.

```
procSettings.OutputMode(ProcessOutputMode::Event);
```

\--------------------------------------------------------------------------------

- title: ProcessState - WSL
- url: https://wsl.dev/api-reference/cpp/enumerations/processstate/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#processstate)

ProcessState

`Process::State()` casts directly from `WslcProcessState`.

Underlying C values:

- `Unknown = 0`- `Running = 1`- `Exited = 2`- `Signalled = 3`

```
if (process.State() == static_cast<ProcessState>(1))
{
    // running
}
```

\--------------------------------------------------------------------------------

- title: VhdType - WSL
- url: https://wsl.dev/api-reference/cpp/enumerations/vhdtype/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#vhdtype)

VhdType

Underlying values:

- `Dynamic = 0`- `Fixed = 1`

```
vhdOptions.Type(VhdType::Dynamic);
```

\--------------------------------------------------------------------------------

- title: ImageProgressStatus - WSL
- url: https://wsl.dev/api-reference/cpp/enumerations/imageprogressstatus/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#imageprogressstatus)

ImageProgressStatus

`ImageProgress` casts directly from `WslcImageProgressStatus`.

Underlying C values:

- `Unknown = 0`- `Pulling = 1`- `Waiting = 2`- `Downloading = 3`- `Verifying = 4`- `Extracting = 5`- `Complete = 6`

```
auto status = progress.Status();
if (status == static_cast<ImageProgressStatus>(6))
{
    // complete
}
```

\--------------------------------------------------------------------------------

- title: SessionTerminationReason - WSL
- url: https://wsl.dev/api-reference/cpp/enumerations/sessionterminationreason/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#sessionterminationreason)

SessionTerminationReason

`Session::OnTerminated` converts `WslcSessionTerminationReason` directly to the WinRT enum.

Underlying C values:

- `Unknown = 0`- `Shutdown = 1`- `Crashed = 2`

\--------------------------------------------------------------------------------

- title: Not Yet Implemented and Known Gaps - WSL
- url: https://wsl.dev/api-reference/cpp/not-yet-implemented-and-known-gaps/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#not-yet-implemented-and-known-gaps)

Not Yet Implemented and Known Gaps

| Gap |  Details |
| --- | --- |
| Handle-based image import/load |  The C API exposes WslcImportSessionImage and WslcLoadSessionImage from a HANDLE; the WinRT metadata exposes path-based ImportImage / ImportImageAsync and LoadImage / LoadImageAsync. |
| Explicit container start flags |  Container::Start() takes no parameters. In winrt\_Container.cpp, the wrapper automatically sets WSLC\_CONTAINER\_START\_FLAG\_ATTACH when the init process output mode is Event or Stream. |
| Raw process callback plumbing |  The C API exposes WslcSetProcessSettingsCallbacks, WslcGetProcessExitEvent, and raw I/O handles. The WinRT projection hides that behind ProcessSettings::OutputMode, OutputReceived, ErrorReceived, Exited, GetInputStream, and GetOutputStream. |
| Missing wrapper source files in this drop |  winrt\_CMakeLists.txt references PullImageOptions, PushImageOptions, TagImageOptions, VhdOptions, and ServiceVersion |

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: End-to-End Example - WSL
- url: https://wsl.dev/api-reference/cpp/end-to-end-example/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#end-to-end-example)

End-to-End Example

The example below shows one full lifecycle matching the C API example:

- Check prerequisites- Print SDK version- Create a session (4 CPUs, 4 GB RAM)- Pull alpine:latest- Configure an init process (`/bin/echo "Hello from WSL Container!"`)- Create and start the container- Wait for the init process to exit- Print exit code- Stop and delete the container- Terminate the session

```
#include <cstdio>
#include <string>
#include <chrono>
#include <winrt/Microsoft.WSL.Containers.h>
#include <winrt/Windows.Foundation.h>
#include <winrt/Windows.Foundation.Collections.h>

using namespace winrt;
using namespace winrt::Microsoft::WSL::Containers;
using namespace winrt::Windows::Foundation;
using namespace winrt::Windows::Foundation::Collections;
using namespace std::chrono_literals;

int main()
{
    init_apartment();

    // 0. Check prerequisites
    auto missing = WslcService::GetMissingComponents();
    if (missing != static_cast<Component>(0))
    {
        printf("WSL components are missing. Run: wsl --install\n");
        return 1;
    }

    auto ver = WslcService::GetVersion();
    printf("WSL version: %u.%u.%u\n", ver.Major(), ver.Minor(), ver.Revision());

    // 1. Create a session
    SessionSettings sessionSettings{ L"MyApp", L"C:\\WslcData" };
    sessionSettings.CpuCount(4);
    sessionSettings.MemorySizeInMB(4096);

    Session session{ sessionSettings };
    session.Start();

    // 2. Pull an image
    PullImageOptions pullOpts{ L"docker.io/library/alpine:latest" };
    auto pullOp = session.PullImageAsync(pullOpts);
    co_await pullOp;

    // 3. Configure an init process
    ProcessSettings initProcSettings;
    initProcSettings.OutputMode(ProcessOutputMode::Event);
    auto argv = single_threaded_vector<hstring>();
    argv.Append(L"/bin/echo");
    argv.Append(L"Hello from WSL Container!");
    initProcSettings.CommandLine(argv);

    // 4. Configure and create a container
    ContainerSettings containerSettings{ L"alpine:latest" };
    containerSettings.Name(L"hello-container");
    containerSettings.InitProcess(initProcSettings);

    auto container = session.CreateContainer(containerSettings);

    // 5. Subscribe to init process events before starting
    auto initProcess = container.InitProcess();
    auto exitedEvent = handle{ CreateEvent(nullptr, TRUE, FALSE, nullptr) };
    int32_t initExitCode = -1;

    initProcess.OutputReceived([](auto const& data)
    {
        std::string text(data.begin(), data.end());
        printf("%s", text.c_str());
    });
    initProcess.Exited([&](int32_t exitCode)
    {
        initExitCode = exitCode;
        SetEvent(exitedEvent.get());
    });

    // 6. Start the container
    container.Start();

    // 7. Wait for the init process to exit (30-second timeout)
    WaitForSingleObject(exitedEvent.get(), 30000);
    printf("Process exited with code: %d\n", initExitCode);

    // 8. Clean up
    if (container.State() == ContainerState::Running)
    {
        container.Stop(Signal::SIGTERM, 10s);
    }
    container.Delete(DeleteContainerOption::None);
    session.Terminate();

    return 0;
}
```
