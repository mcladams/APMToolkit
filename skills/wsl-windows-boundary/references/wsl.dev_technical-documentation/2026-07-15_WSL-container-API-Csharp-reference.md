\--------------------------------------------------------------------------------

- title: WSL container API C# reference - WSL
- url: https://wsl.dev/api-reference/csharp/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#wsl-container-api-c-reference)

# WSL container API C# reference

This document describes the **C# projection** in the `Microsoft.WSL.Containers` namespace.

\--------------------------------------------------------------------------------

In this reference

- [Overview](overview/)- [Projected Namespace](projected-namespace/)- [Common CsWinRT Type Mappings](common-cswinrt-type-mappings/)- [Data Classes](data-classes/)- [Settings Classes](settings-classes/)- [Core Classes](core-classes/)- [Service Class](service-class/)- [Delegates and Events](delegates-and-events/)- [Enumerations](enumerations/)- [Known Gaps](known-gaps/)- [End-to-End Example](end-to-end-example/)

\--------------------------------------------------------------------------------

- title: Overview - WSL
- url: https://wsl.dev/api-reference/csharp/overview/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#overview)

Overview

- The public C# surface mirrors the WinRT surface implemented by the `winrt_*.h` / `winrt_*.cpp` wrappers.

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: Projected Namespace - WSL
- url: https://wsl.dev/api-reference/csharp/projected-namespace/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#projected-namespace)

Projected Namespace

```
using Microsoft.WSL.Containers;
```

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: Common CsWinRT Type Mappings - WSL
- url: https://wsl.dev/api-reference/csharp/common-cswinrt-type-mappings/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#common-cswinrt-type-mappings)

Common CsWinRT Type Mappings

| WinRT type |  C# projection |
| --- | --- |
| hstring |  string |
| Windows.Foundation.Uri |  System.Uri |
| Windows.Foundation.TimeSpan |  System.TimeSpan |
| IReference<uint32\_t> |  uint? |
| IReference<TimeSpan> |  TimeSpan? |
| IReference<ContainerNetworkingMode> |  ContainerNetworkingMode? |
| IVector<T> |  IList<T> |
| IVectorView<T> |  IReadOnlyList<T> |
| IMap<string, string> |  IDictionary<string, string> |
| Windows.Foundation.DateTime |  DateTimeOffset |
| com\_array<uint8\_t> event payload |  byte\[\] |
| Windows.Networking.HostName |  Windows.Networking.HostName |
| IAsyncActionWithProgress<T> |  awaitable WinRT async operation |

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: Data Classes - WSL
- url: https://wsl.dev/api-reference/csharp/data-classes/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#data-classes)

Data Classes

Members

- [ContainerPortMapping](containerportmapping/)- [ContainerVolume](containervolume/)- [ContainerNamedVolume](containernamedvolume/)- [ImageInfo](imageinfo/)- [ImageProgress](imageprogress/)- [InstallProgress](installprogress/)- [ProcessCrashInformation](processcrashinformation/)- [ServiceVersion](serviceversion/)- [VhdOwner](vhdowner/)

\--------------------------------------------------------------------------------

- title: ContainerPortMapping - WSL
- url: https://wsl.dev/api-reference/csharp/data-classes/containerportmapping/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#containerportmapping)

ContainerPortMapping

Represents a published port.

```
using Windows.Networking;

public sealed class ContainerPortMapping
{
    public ContainerPortMapping(ushort windowsPort, ushort containerPort, PortProtocol protocol);

    public ushort WindowsPort { get; set; }
    public ushort ContainerPort { get; set; }
    public PortProtocol Protocol { get; set; }
    public HostName WindowsAddress { get; set; }
}
```

Notes:

- `WindowsAddress` **is implemented**.- It accepts only `HostNameType.Ipv4` and `HostNameType.Ipv6` values.- DNS names are rejected.- `null` means the default host bind address.

Example:

```
using Windows.Networking;

var mapping = new ContainerPortMapping(8080, 80, PortProtocol.TCP)
{
    WindowsAddress = new HostName("127.0.0.1")
};
```

\--------------------------------------------------------------------------------

- title: ContainerVolume - WSL
- url: https://wsl.dev/api-reference/csharp/data-classes/containervolume/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#containervolume)

ContainerVolume

Maps a Windows path into the container.

```
public sealed class ContainerVolume
{
    public ContainerVolume(string windowsPath, string containerPath, bool readOnly);

    public string WindowsPath { get; set; }
    public string ContainerPath { get; set; }
    public bool ReadOnly { get; set; }
}
```

Example:

```
var volume = new ContainerVolume(@"C:\data", "/workspace/data", readOnly: false);
```

\--------------------------------------------------------------------------------

- title: ContainerNamedVolume - WSL
- url: https://wsl.dev/api-reference/csharp/data-classes/containernamedvolume/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#containernamedvolume)

ContainerNamedVolume

Maps a session-managed named VHD volume into the container.

```
public sealed class ContainerNamedVolume
{
    public ContainerNamedVolume(string name, string containerPath, bool readOnly);

    public string Name { get; set; }
    public string ContainerPath { get; set; }
    public bool ReadOnly { get; set; }
}
```

Example:

```
var namedVolume = new ContainerNamedVolume("cache", "/var/cache/app", readOnly: false);
```

\--------------------------------------------------------------------------------

- title: ImageInfo - WSL
- url: https://wsl.dev/api-reference/csharp/data-classes/imageinfo/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#imageinfo)

ImageInfo

Metadata returned by `Session.GetImages()`.

```
using Windows.Storage.Streams;

public sealed class ImageInfo
{
    public string Name { get; }
    public IBuffer Sha256 { get; }
    public ulong Size { get; }
    public DateTimeOffset CreatedTimestamp { get; }
}
```

Example:

```
foreach (var image in session.GetImages())
{
    Console.WriteLine($"{image.Name} ({image.Size / 1024 / 1024} MB)");
}
```

\--------------------------------------------------------------------------------

- title: ImageProgress - WSL
- url: https://wsl.dev/api-reference/csharp/data-classes/imageprogress/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#imageprogress)

ImageProgress

Progress payload for pull/import/load/push operations.

```
public sealed class ImageProgress
{
    public string Id { get; }
    public ImageProgressStatus Status { get; }
    public ulong CurrentBytes { get; }
    public ulong TotalBytes { get; }
}
```

Example:

```
void PrintImageProgress(ImageProgress progress) =>
    Console.WriteLine($"{progress.Status,-12} {progress.Id} {progress.CurrentBytes}/{progress.TotalBytes}");
```

\--------------------------------------------------------------------------------

- title: InstallProgress - WSL
- url: https://wsl.dev/api-reference/csharp/data-classes/installprogress/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#installprogress)

InstallProgress

Progress payload for dependency installation.

```
public sealed class InstallProgress
{
    public Component Component { get; }
    public uint Progress { get; }
    public uint Total { get; }
}
```

Example:

```
void PrintInstallProgress(InstallProgress progress) =>
    Console.WriteLine($"{progress.Component}: {progress.Progress}/{progress.Total}");
```

\--------------------------------------------------------------------------------

- title: ProcessCrashInformation - WSL
- url: https://wsl.dev/api-reference/csharp/data-classes/processcrashinformation/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#processcrashinformation)

ProcessCrashInformation

Crash information supplied by the `Session.ProcessCrashed` event.

```
public sealed class ProcessCrashInformation
{
    public string DumpPath { get; }
    public string ProcessName { get; }
    public uint Pid { get; }
    public uint Signal { get; }
    public DateTimeOffset Timestamp { get; }
}
```

Example:

```
session.ProcessCrashed += information =>
    Console.WriteLine($"{information.ProcessName} ({information.Pid}) crashed at {information.Timestamp}");
```

\--------------------------------------------------------------------------------

- title: ServiceVersion - WSL
- url: https://wsl.dev/api-reference/csharp/data-classes/serviceversion/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#serviceversion)

ServiceVersion

WSL service version information.

```
public sealed class ServiceVersion
{
    public uint Major { get; }
    public uint Minor { get; }
    public uint Revision { get; }
}
```

Example:

```
var version = WslcService.GetVersion();
Console.WriteLine($"WSL service: {version.Major}.{version.Minor}.{version.Revision}");
```

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: VhdOwner - WSL
- url: https://wsl.dev/api-reference/csharp/data-classes/vhdowner/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#vhdowner)

VhdOwner

Owner uid/gid for a named VHD volume root inode.

```
public struct VhdOwner
{
    public uint Uid;
    public uint Gid;
}
```

Example:

```
var owner = new VhdOwner { Uid = 1000, Gid = 1000 };
```

\--------------------------------------------------------------------------------

- title: Settings Classes - WSL
- url: https://wsl.dev/api-reference/csharp/settings-classes/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#settings-classes)

Settings Classes

Members

- [SessionSettings](sessionsettings/)- [VhdOptions](vhdoptions/)- [PullImageOptions](pullimageoptions/)- [PushImageOptions](pushimageoptions/)- [TagImageOptions](tagimageoptions/)- [ContainerSettings](containersettings/)- [ProcessSettings](processsettings/)

\--------------------------------------------------------------------------------

- title: SessionSettings - WSL
- url: https://wsl.dev/api-reference/csharp/settings-classes/sessionsettings/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#sessionsettings)

SessionSettings

Configures a session before `Session.Start()`.

```
public sealed class SessionSettings
{
    public SessionSettings(string name, string storagePath);

    public string Name { get; set; }
    public string StoragePath { get; set; }
    public uint? CpuCount { get; set; }
    public uint? MemorySizeInMB { get; set; }
    public TimeSpan? Timeout { get; set; }
    public VhdOptions VhdRequirements { get; set; }
    public bool EnableGpu { get; set; }
}
```

Notes:

- `Name` is the name of the session to be created.- `StoragePath` is the path to where the session storage should be written. If the path doesn't exist, it will be created.- `CpuCount`, `MemorySizeInMB`, and `Timeout` are optional nullable values.- `Timeout` must be positive and must fit in a `uint32` millisecond count.- `VhdRequirements` is optional.

Session names serve both as display names and as machine-wide keys used to identify sessions. If a session with the same name already exists, session creation will fail with `ERROR_ALREADY_EXISTS`.

Also note that the following information about a session is visible to all users on the machine:

- The session's name- The SID of the user that created the session- The PID of the process that created the session

Do not put credentials or other sensitive information in the session's name.

Example:

```
var sessionSettings = new SessionSettings("demo-session", @"C:\WslcData")
{
    CpuCount = 4,
    MemorySizeInMB = 4096,
    Timeout = TimeSpan.FromMinutes(5),
    EnableGpu = true
};
```

\--------------------------------------------------------------------------------

- title: VhdOptions - WSL
- url: https://wsl.dev/api-reference/csharp/settings-classes/vhdoptions/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#vhdoptions)

VhdOptions

Describes a session VHD requirement or a named session VHD volume.

```
public sealed class VhdOptions
{
    public VhdOptions(string name, ulong size, VhdType type);

    public string Name { get; set; }
    public ulong Size { get; set; }
    public VhdType Type { get; set; }
    public VhdOwner? Owner { get; set; }
}
```

Notes:

- Use `SessionSettings.VhdRequirements` for session-level storage requirements.- Use `Session.CreateVhdVolume(...)` for named session volumes.- `Owner` is intended for named-volume creation and is rejected on `SessionSettings.VhdRequirements`.

Example:

```
var vhd = new VhdOptions("cache", 2UL * 1024 * 1024 * 1024, VhdType.Dynamic)
{
    Owner = new VhdOwner { Uid = 1000, Gid = 1000 }
};
```

\--------------------------------------------------------------------------------

- title: PullImageOptions - WSL
- url: https://wsl.dev/api-reference/csharp/settings-classes/pullimageoptions/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#pullimageoptions)

PullImageOptions

```
public sealed class PullImageOptions
{
    public PullImageOptions(string uri);

    public string Uri { get; set; }
    public string RegistryAuth { get; set; }
}
```

Example:

```
var pullOptions = new PullImageOptions("docker.io/library/alpine:latest")
{
    RegistryAuth = string.Empty // optional for public registries
};
```

\--------------------------------------------------------------------------------

- title: PushImageOptions - WSL
- url: https://wsl.dev/api-reference/csharp/settings-classes/pushimageoptions/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#pushimageoptions)

PushImageOptions

```
public sealed class PushImageOptions
{
    public PushImageOptions(string image, string registryAuth);

    public string Image { get; set; }
    public string RegistryAuth { get; set; }
}
```

Example:

```
var pushOptions = new PushImageOptions("registry.example.com/demo:latest", authToken);
```

\--------------------------------------------------------------------------------

- title: TagImageOptions - WSL
- url: https://wsl.dev/api-reference/csharp/settings-classes/tagimageoptions/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#tagimageoptions)

TagImageOptions

```
public sealed class TagImageOptions
{
    public TagImageOptions(string image, string repository, string tag);

    public string Image { get; set; }
    public string Repository { get; set; }
    public string Tag { get; set; }
}
```

Example:

```
var tagOptions = new TagImageOptions("alpine:latest", "registry.example.com/alpine", "v1");
```

\--------------------------------------------------------------------------------

- title: ContainerSettings - WSL
- url: https://wsl.dev/api-reference/csharp/settings-classes/containersettings/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#containersettings)

ContainerSettings

Configures a container before creation.

```
public sealed class ContainerSettings
{
    public ContainerSettings(string imageName);

    public string ImageName { get; set; }
    public string Name { get; set; }
    public ProcessSettings InitProcess { get; set; }
    public ContainerNetworkingMode? NetworkingMode { get; set; }
    public string HostName { get; set; }
    public string DomainName { get; set; }
    public bool EnableAutoRemove { get; set; }
    public bool EnableGpu { get; set; }
    public bool Privileged { get; set; }
    public IList<ContainerPortMapping> PortMappings { get; set; }
    public IList<ContainerVolume> Volumes { get; set; }
    public IList<ContainerNamedVolume> NamedVolumes { get; set; }
}
```

Notes:

- `PortMappings`, `Volumes`, and `NamedVolumes` are mutable collections.- `InitProcess` is optional.- `NetworkingMode` is nullable; `null` means “leave default behavior”.

Example:

```
var init = new ProcessSettings
{
    CommandLine = new List<string> { "/bin/sh", "-c", "echo hello from init" },
    OutputMode = ProcessOutputMode.Event
};

var containerSettings = new ContainerSettings("docker.io/library/alpine:latest")
{
    Name = "demo-container",
    InitProcess = init,
    NetworkingMode = ContainerNetworkingMode.Bridged,
    EnableAutoRemove = true,
    PortMappings = new List<ContainerPortMapping>
    {
        new(8080, 80, PortProtocol.TCP)
    },
    Volumes = new List<ContainerVolume>
    {
        new(@"C:\data", "/workspace/data", false)
    },
    NamedVolumes = new List<ContainerNamedVolume>
    {
        new("cache", "/var/cache/app", false)
    }
};
```

\--------------------------------------------------------------------------------

- title: ProcessSettings - WSL
- url: https://wsl.dev/api-reference/csharp/settings-classes/processsettings/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#processsettings)

ProcessSettings

Configures a process before start.

```
public sealed class ProcessSettings
{
    public string WorkingDirectory { get; set; }
    public IList<string> CommandLine { get; set; }
    public IDictionary<string, string> EnvironmentVariables { get; set; }
    public ProcessOutputMode OutputMode { get; set; }
}
```

Notes:

- `CommandLine` must be non-empty before calling `Process.Start()`.- The init process is started by `Container.Start()`, not by `Process.Start()`.- `OutputMode.Event` enables `OutputReceived` / `ErrorReceived`.- `OutputMode.Stream` enables `GetOutputStream(...)`.

Example:

```
var processSettings = new ProcessSettings
{
    WorkingDirectory = "/workspace",
    CommandLine = new List<string> { "/bin/sh", "-c", "env | sort" },
    EnvironmentVariables = new Dictionary<string, string>
    {
        ["DEMO"] = "1",
        ["PATH"] = "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
    },
    OutputMode = ProcessOutputMode.Event
};
```

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: Core Classes - WSL
- url: https://wsl.dev/api-reference/csharp/core-classes/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#core-classes)

Core Classes

Members

- [Session](session/)- [Container](container/)- [Process](process/)

\--------------------------------------------------------------------------------

- title: Session - WSL
- url: https://wsl.dev/api-reference/csharp/core-classes/session/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#session)

Session

Represents a WSL-backed container host session.

```
public sealed class Session : IDisposable
{
    public Session(SessionSettings settings);

    public event SessionTerminationHandler Terminated;
    public event ProcessCrashHandler ProcessCrashed;

    public void Start();
    public void Terminate();
    public Container CreateContainer(ContainerSettings containerSettings);
    public void PullImage(PullImageOptions options);
    public IAsyncActionWithProgress<ImageProgress> PullImageAsync(PullImageOptions options);
    public void ImportImage(string path, string imageName);
    public IAsyncActionWithProgress<ImageProgress> ImportImageAsync(string path, string imageName);
    public void LoadImage(string path);
    public IAsyncActionWithProgress<ImageProgress> LoadImageAsync(string path);
    public void PushImage(PushImageOptions options);
    public IAsyncActionWithProgress<ImageProgress> PushImageAsync(PushImageOptions options);
    public void DeleteImage(string nameOrId);
    public void TagImage(TagImageOptions options);
    public void CreateVhdVolume(VhdOptions options);
    public void DeleteVhdVolume(string name);
    public string Authenticate(Uri serverAddress, string username, string password);
    public IReadOnlyList<ImageInfo> GetImages();
    public void Dispose();
}
```

Session constructor

```
var session = new Session(sessionSettings);
```

Session.Start()

Starts the session VM and registers the internal termination wait.

```
session.Start();
```

Session.Terminate()

Terminates the session.

```
session.Terminate();
```

Session.CreateContainer(ContainerSettings)

Creates a container object owned by the session.

```
Container container = session.CreateContainer(containerSettings);
```

Session.PullImage(PullImageOptions)

Synchronous image pull.

```
session.PullImage(new PullImageOptions("docker.io/library/alpine:latest"));
```

Session.PullImageAsync(PullImageOptions)

Awaitable pull with progress.

```
var pull = session.PullImageAsync(new PullImageOptions("docker.io/library/alpine:latest"));
pull.Progress = (op, progress) =>
    Console.WriteLine($"pull: {progress.Status} {progress.Id} {progress.CurrentBytes}/{progress.TotalBytes}");
await pull;
```

Session.ImportImage(string path, string imageName)

Synchronous image import from a file path.

```
session.ImportImage(@"C:\images\demo.tar", "demo:imported");
```

Session.ImportImageAsync(string path, string imageName)

Imports an image tarball from a file path.

```
var importOp = session.ImportImageAsync(@"C:\images\demo.tar", "demo:imported");
importOp.Progress = (op, progress) =>
    Console.WriteLine($"import: {progress.Status} {progress.Id}");
await importOp;
```

Session.LoadImage(string path)

Synchronous image load from disk.

```
session.LoadImage(@"C:\images\docker-save.tar");
```

Session.LoadImageAsync(string path)

Loads an image archive from disk.

```
var loadOp = session.LoadImageAsync(@"C:\images\docker-save.tar");
loadOp.Progress = (op, progress) =>
    Console.WriteLine($"load: {progress.Status} {progress.Id}");
await loadOp;
```

Session.PushImage(PushImageOptions)

Synchronous image push to a registry.

```
session.PushImage(new PushImageOptions("registry.example.com/demo:latest", authToken));
```

Session.PushImageAsync(PushImageOptions)

Pushes an image to a registry.

```
var pushOp = session.PushImageAsync(new PushImageOptions("registry.example.com/demo:latest", authToken));
pushOp.Progress = (op, progress) =>
    Console.WriteLine($"push: {progress.Status} {progress.Id}");
await pushOp;
```

Session.DeleteImage(string nameOrId)

Deletes an image by name or ID.

```
session.DeleteImage("demo:old");
```

Session.TagImage(TagImageOptions)

Applies a new repository/tag to an existing image.

```
session.TagImage(new TagImageOptions("alpine:latest", "registry.example.com/alpine", "v1"));
```

Session.CreateVhdVolume(VhdOptions)

Creates a named session VHD volume.

```
var vhd = new VhdOptions("cache", 2UL * 1024 * 1024 * 1024, VhdType.Dynamic)
{
    Owner = new VhdOwner { Uid = 1000, Gid = 1000 }
};
session.CreateVhdVolume(vhd);
```

Session.DeleteVhdVolume(string name)

Deletes a named session VHD volume.

```
session.DeleteVhdVolume("cache");
```

Session.Authenticate(Uri, string, string)

Authenticates to a registry and returns an identity token string.

```
string token = session.Authenticate(
    new Uri("https://registry.example.com"),
    "user1",
    "p@ssw0rd");
```

Session.GetImages()

Returns a snapshot of images known to the session.

```
foreach (var image in session.GetImages())
{
    Console.WriteLine(image.Name);
}
```

Session.Terminated event

Raised when the session termination event is signaled.

```
session.Terminated += reason =>
    Console.WriteLine($"Session terminated: {reason}");
```

Session.ProcessCrashed event

Raised when a process crash dump is reported.

```
session.ProcessCrashed += information =>
    Console.WriteLine($"Process crashed: {information.ProcessName} ({information.Pid})");
```

Session.Dispose()

Releases the underlying WinRT session object.

```
session.Dispose();
```

\--------------------------------------------------------------------------------

- title: Container - WSL
- url: https://wsl.dev/api-reference/csharp/core-classes/container/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#container)

Container

Represents a container inside a session.

```
public sealed class Container : IDisposable
{
    public string Id { get; }
    public Process InitProcess { get; }
    public ContainerState State { get; }

    public void Start();
    public void Stop(Signal signal, TimeSpan timeout);
    public void Delete(DeleteContainerOption option);
    public Process CreateProcess(ProcessSettings newProcessSettings);
    public string Inspect();
    public void Dispose();
}
```

Notes:

- `Start()` has **no flags parameter**.- If `InitProcess.OutputMode` is `Event` or `Stream`, `Start()` automatically requests native attach.- `InitProcess` is only available when `ContainerSettings.InitProcess` was configured.

Container.Start()

Starts the container and, if configured, attaches the init process handle.

```
container.Start();
```

Container.Stop(Signal, TimeSpan)

Stops the container with a signal and timeout.

```
container.Stop(Signal.SIGTERM, TimeSpan.FromSeconds(10));
```

Container.Delete(DeleteContainerOption)

Deletes the container.

```
container.Delete(DeleteContainerOption.Force);
```

Container.CreateProcess(ProcessSettings)

Creates a secondary process object inside the container.

```
var execSettings = new ProcessSettings
{
    CommandLine = new List<string> { "/bin/sh", "-c", "echo secondary process" },
    OutputMode = ProcessOutputMode.Event
};

Process process = container.CreateProcess(execSettings);
```

Container.Inspect()

Returns the raw inspect payload as a string.

```
string inspectJson = container.Inspect();
Console.WriteLine(inspectJson);
```

Container.Id

Returns the container ID string.

```
Console.WriteLine(container.Id);
```

Container.InitProcess

Gets the configured init process object.

```
Process init = container.InitProcess;
```

Container.State

Gets the current container state.

```
Console.WriteLine(container.State);
```

Container.Dispose()

Releases the underlying WinRT container object.

```
container.Dispose();
```

\--------------------------------------------------------------------------------

- title: Process - WSL
- url: https://wsl.dev/api-reference/csharp/core-classes/process/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#process)

Process

Represents a Linux process in a container.

```
using Windows.Storage.Streams;

public sealed class Process
{
    public uint Pid { get; }
    public ProcessState State { get; }
    public int ExitCode { get; }

    public event ProcessOutputHandler OutputReceived;
    public event ProcessOutputHandler ErrorReceived;
    public event ProcessExitHandler Exited;

    public void Start();
    public void Signal(Signal signal);
    public IInputStream GetOutputStream(ProcessOutputHandle outputHandle);
    public IOutputStream GetInputStream();
}
```

Notes:

- Call `Start()` only for **secondary processes** created by `Container.CreateProcess(...)`.- The init process is started by `Container.Start()`.- `OutputReceived` and `ErrorReceived` require `OutputMode.Event`.- `GetOutputStream(...)` requires `OutputMode.Stream`.- `Exited` is available for all output modes.

Process.Start()

Starts a secondary process.

```
process.Start();
```

Process.Signal(Signal)

Signals the process.

```
process.Signal(Signal.SIGTERM);
```

Process.GetOutputStream(ProcessOutputHandle)

Gets stdout or stderr as a WinRT input stream.

```
using Windows.Storage.Streams;

using IInputStream stdout = process.GetOutputStream(ProcessOutputHandle.StandardOutput);
using var reader = new DataReader(stdout);
await reader.LoadAsync(4096);
string text = reader.ReadString(reader.UnconsumedBufferLength);
Console.WriteLine(text);
```

Process.GetInputStream()

Gets stdin as a WinRT output stream.

```
using Windows.Storage.Streams;

using IOutputStream stdin = process.GetInputStream();
using var writer = new DataWriter(stdin);
writer.WriteString("hello from C#\n");
await writer.StoreAsync();
await writer.FlushAsync();
```

Process.Pid

```
Console.WriteLine($"PID: {process.Pid}");
```

Process.State

```
Console.WriteLine($"State: {process.State}");
```

Process.ExitCode

Valid after exit.

```
Console.WriteLine($"Exit code: {process.ExitCode}");
```

Process.OutputReceived event

```
using System.Text;

process.OutputReceived += data =>
    Console.Write(Encoding.UTF8.GetString(data));
```

Process.ErrorReceived event

```
using System.Text;

process.ErrorReceived += data =>
    Console.Error.Write(Encoding.UTF8.GetString(data));
```

Process.Exited event

```
process.Exited += exitCode =>
    Console.WriteLine($"Process exited with {exitCode}");
```

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: Service Class - WSL
- url: https://wsl.dev/api-reference/csharp/service-class/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#service-class)

Service Class

Members

- [WslcService](wslcservice/)

\--------------------------------------------------------------------------------

- title: WslcService - WSL
- url: https://wsl.dev/api-reference/csharp/service-class/wslcservice/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#wslcservice)

WslcService

Static entry point for service-level operations.

```
public static class WslcService
{
    public static IReadOnlyList<Component> GetMissingComponents();
    public static ServiceVersion GetVersion();
    public static void InstallWithDependencies();
    public static IAsyncActionWithProgress<InstallProgress> InstallWithDependenciesAsync();
}
```

WslcService.GetMissingComponents()

```
IReadOnlyList<Component> missing = WslcService.GetMissingComponents();
if (missing.Count == 0)
{
    Console.WriteLine("All required components are installed.");
}
else
{
    Console.WriteLine($"Missing: {string.Join(", ", missing)}");
}
```

WslcService.GetVersion()

```
ServiceVersion version = WslcService.GetVersion();
Console.WriteLine($"{version.Major}.{version.Minor}.{version.Revision}");
```

WslcService.InstallWithDependencies()

```
WslcService.InstallWithDependencies();
```

WslcService.InstallWithDependenciesAsync()

```
var install = WslcService.InstallWithDependenciesAsync();
install.Progress = (op, progress) =>
    Console.WriteLine($"install: {progress.Component} {progress.Progress}/{progress.Total}");
await install;
```

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: Delegates and Events - WSL
- url: https://wsl.dev/api-reference/csharp/delegates-and-events/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#delegates-and-events)

Delegates and Events

The WinRT delegates project to normal C# delegates and are consumed as normal C# events.

```
public delegate void SessionTerminationHandler(SessionTerminationReason reason);
public delegate void ProcessCrashHandler(ProcessCrashInformation information);
public delegate void ProcessOutputHandler(byte[] data);
public delegate void ProcessExitHandler(int exitCode);
```

Typical event usage:

```
using System.Text;

session.Terminated += reason => Console.WriteLine($"Session ended: {reason}");
session.ProcessCrashed += info => Console.WriteLine($"Process crashed: {info.ProcessName} ({info.Pid})");
container.InitProcess.OutputReceived += data => Console.Write(Encoding.UTF8.GetString(data));
container.InitProcess.ErrorReceived += data => Console.Error.Write(Encoding.UTF8.GetString(data));
container.InitProcess.Exited += code => Console.WriteLine($"Init exited: {code}");
```

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: Enumerations - WSL
- url: https://wsl.dev/api-reference/csharp/enumerations/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#enumerations)

Enumerations

Members

- [Component](component/)- [DeleteContainerOption](deletecontaineroption/)- [Error](error/)- [ContainerNetworkingMode](containernetworkingmode/)- [PortProtocol](portprotocol/)- [ContainerState](containerstate/)- [Signal](signal/)- [ProcessOutputHandle](processoutputhandle/)- [ProcessOutputMode](processoutputmode/)- [ProcessState](processstate/)- [VhdType](vhdtype/)- [ImageProgressStatus](imageprogressstatus/)- [SessionTerminationReason](sessionterminationreason/)

\--------------------------------------------------------------------------------

- title: Component - WSL
- url: https://wsl.dev/api-reference/csharp/enumerations/component/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#component)

Component

```
public enum Component
{
    VirtualMachinePlatform = 1,
    WslPackage = 2,
    SdkNeedsUpdate = 4
}
```

\--------------------------------------------------------------------------------

- title: DeleteContainerOption - WSL
- url: https://wsl.dev/api-reference/csharp/enumerations/deletecontaineroption/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#deletecontaineroption)

DeleteContainerOption

```
[Flags]
public enum DeleteContainerOption
{
    None = 0,
    Force = 1
}
```

\--------------------------------------------------------------------------------

- title: Error - WSL
- url: https://wsl.dev/api-reference/csharp/enumerations/error/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#error)

Error

```
public enum Error
{
    ImageNotFound = -2147219967,
    ContainerPrefixAmbiguous = -2147219966,
    ContainerNotFound = -2147219965,
    VolumeNotFound = -2147219964,
    ContainerNotRunning = -2147219963,
    ContainerIsRunning = -2147219962,
    SessionReserved = -2147219961,
    InvalidSessionName = -2147219960,
    NetworkNotFound = -2147219959,
    WindowsUpdateSearchFailed = -2147219958,
    SdkUpdateNeeded = -2147219957,
    ContainerDisabled = -2147219956,
    RegistryBlockedByPolicy = -2147219955,
    VolumeNotAvailable = -2147219954
}
```

\--------------------------------------------------------------------------------

- title: ContainerNetworkingMode - WSL
- url: https://wsl.dev/api-reference/csharp/enumerations/containernetworkingmode/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#containernetworkingmode)

ContainerNetworkingMode

```
public enum ContainerNetworkingMode
{
    None = 0,
    Bridged = 1
}
```

\--------------------------------------------------------------------------------

- title: PortProtocol - WSL
- url: https://wsl.dev/api-reference/csharp/enumerations/portprotocol/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#portprotocol)

PortProtocol

```
public enum PortProtocol
{
    TCP = 0,
    UDP = 1
}
```

\--------------------------------------------------------------------------------

- title: ContainerState - WSL
- url: https://wsl.dev/api-reference/csharp/enumerations/containerstate/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#containerstate)

ContainerState

```
public enum ContainerState
{
    Invalid = 0,
    Created = 1,
    Running = 2,
    Exited = 3,
    Deleted = 4
}
```

\--------------------------------------------------------------------------------

- title: Signal - WSL
- url: https://wsl.dev/api-reference/csharp/enumerations/signal/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#signal)

Signal

```
public enum Signal
{
    None = 0,
    SIGHUP = 1,
    SIGINT = 2,
    SIGQUIT = 3,
    SIGKILL = 9,
    SIGTERM = 15
}
```

\--------------------------------------------------------------------------------

- title: ProcessOutputHandle - WSL
- url: https://wsl.dev/api-reference/csharp/enumerations/processoutputhandle/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#processoutputhandle)

ProcessOutputHandle

Only stdout/stderr are modeled here. Stdin is accessed through `Process.GetInputStream()`.

```
public enum ProcessOutputHandle
{
    StandardOutput = 1,
    StandardError = 2
}
```

\--------------------------------------------------------------------------------

- title: ProcessOutputMode - WSL
- url: https://wsl.dev/api-reference/csharp/enumerations/processoutputmode/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#processoutputmode)

ProcessOutputMode

```
public enum ProcessOutputMode
{
    Discard = 0,
    Stream = 1,
    Event = 2
}
```

\--------------------------------------------------------------------------------

- title: ProcessState - WSL
- url: https://wsl.dev/api-reference/csharp/enumerations/processstate/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#processstate)

ProcessState

```
public enum ProcessState
{
    Unknown = 0,
    Running = 1,
    Exited = 2,
    Signalled = 3
}
```

\--------------------------------------------------------------------------------

- title: VhdType - WSL
- url: https://wsl.dev/api-reference/csharp/enumerations/vhdtype/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#vhdtype)

VhdType

```
public enum VhdType
{
    Dynamic = 0,
    Fixed = 1
}
```

`wslcsdk.h` notes that `Fixed` is only honored for `WslcCreateSessionVhdVolume`. Session boot-disk requirements use the same underlying struct, but owner flags are explicitly rejected there.

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: ImageProgressStatus - WSL
- url: https://wsl.dev/api-reference/csharp/enumerations/imageprogressstatus/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#imageprogressstatus)

ImageProgressStatus

```
public enum ImageProgressStatus
{
    Unknown = 0,
    Pulling = 1,
    Waiting = 2,
    Downloading = 3,
    Verifying = 4,
    Extracting = 5,
    Complete = 6
}
```

\--------------------------------------------------------------------------------

- title: SessionTerminationReason - WSL
- url: https://wsl.dev/api-reference/csharp/enumerations/sessionterminationreason/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#sessionterminationreason)

SessionTerminationReason

```
public enum SessionTerminationReason
{
    Unknown = 0,
    Shutdown = 1,
    Crashed = 2
}
```

\--------------------------------------------------------------------------------

- title: Known Gaps - WSL
- url: https://wsl.dev/api-reference/csharp/known-gaps/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#known-gaps)

Known Gaps

These C API features are **not** available through the WinRT/C# projection:

| C API feature |  C# status |
| --- | --- |
| WslcImportSessionImage(...) and WslcLoadSessionImage(...) overloads that take raw HANDLE + byte count |  **Not projected.** C# exposes file-path-based ImportImage(...), ImportImageAsync(...), LoadImage(...), and LoadImageAsync(...). |
| Raw native handles (WslcGetSessionTerminationEvent, WslcGetProcessExitEvent, WslcGetProcessIOHandle) |  **Wrapped, not exposed directly.** Use C# events and WinRT streams instead. |
| WslcProcessCallbacks registration surface |  **Wrapped as events.** Use OutputReceived, ErrorReceived, and Exited. |
| WslcContainerStartFlags |  \*\*Not exposed directly.\*\*Container.Start() automatically sets ATTACH when the init process uses ProcessOutputMode.Event or ProcessOutputMode.Stream. |

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: End-to-End Example - WSL
- url: https://wsl.dev/api-reference/csharp/end-to-end-example/
- date: 2026-07-15T19:09:52.296Z
- parsing method: defuddle

[Skip to content](#end-to-end-example)

End-to-End Example

The example below shows one full lifecycle matching the C API example:

- Check prerequisites- Print SDK version- Create a session (4 CPUs, 4 GB RAM)- Pull alpine:latest- Configure an init process (`/bin/echo "Hello from WSL Container!"`)- Create and start the container- Wait for the init process to exit- Print exit code- Stop and delete the container- Terminate the session

```
using Microsoft.WSL.Containers;
using System;
using System.Text;
using System.Threading.Tasks;

class Program
{
    static async Task<int> Main()
    {
        // 0. Check prerequisites
        var missing = WslcService.GetMissingComponents();
        if (missing.Count > 0)
        {
            Console.WriteLine("WSL components are missing. Run: wsl --install");
            return 1;
        }

        var ver = WslcService.GetVersion();
        Console.WriteLine($"WSL version: {ver.Major}.{ver.Minor}.{ver.Revision}");

        // 1. Create a session
        var sessionSettings = new SessionSettings("MyApp", @"C:\WslcData")
        {
            CpuCount = 4,
            MemorySizeInMB = 4096
        };

        var session = new Session(sessionSettings);
        session.Start();

        // 2. Pull an image
        var pullOp = session.PullImageAsync(new PullImageOptions("docker.io/library/alpine:latest"));
        pullOp.Progress = (op, progress) =>
            Console.WriteLine($"Pull: {progress.Status} {progress.CurrentBytes}/{progress.TotalBytes}");
        await pullOp;

        // 3. Configure an init process
        var initProcSettings = new ProcessSettings
        {
            CommandLine = new[] { "/bin/echo", "Hello from WSL Container!" },
            OutputMode = ProcessOutputMode.Event
        };

        // 4. Configure and create a container
        var containerSettings = new ContainerSettings("alpine:latest")
        {
            Name = "hello-container",
            InitProcess = initProcSettings
        };

        var container = session.CreateContainer(containerSettings);

        // 5. Subscribe to init process events before starting
        var exited = new TaskCompletionSource<int>(TaskCreationOptions.RunContinuationsAsynchronously);

        container.InitProcess.OutputReceived += data =>
            Console.Write(Encoding.UTF8.GetString(data));
        container.InitProcess.Exited += code =>
            exited.TrySetResult(code);

        // 6. Start the container
        container.Start();

        // 7. Wait for the init process to exit (30-second timeout)
        var completed = await Task.WhenAny(exited.Task, Task.Delay(TimeSpan.FromSeconds(30)));
        int exitCode = completed == exited.Task ? exited.Task.Result : -1;
        Console.WriteLine($"Process exited with code: {exitCode}");

        // 8. Clean up
        if (container.State == ContainerState.Running)
        {
            container.Stop(Signal.SIGTERM, TimeSpan.FromSeconds(10));
        }
        container.Delete(DeleteContainerOption.None);
        session.Terminate();

        return exitCode;
    }
}
```