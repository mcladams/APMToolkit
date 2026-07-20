---
created: 2026-07-15T04:01:00 (UTC +08:00)
tags: [BashOnWindows,bash,wsl,windows,windows subsystem,distro,custom,Linux,container]
source: https://learn.microsoft.com/en-us/windows/wsl/wsl-container?tabs=csharp
author: GrantMeStrength
---

# WSL container | Microsoft Learn

> ## Excerpt
> An overview of what the WSL container feature is, and how to use it to run Linux container workflows on Windows

---
The WSL container feature has two major components: a CLI called `wslc.exe` to build, run and interact with Linux containers and a WSL container API allowing Windows app developers to use Linux containers as part of their app logic.

## WSL container CLI

WSL now includes `wslc.exe` as a built in binary. Its goal is to have a familiar CLI interface, allowing you to easily build, run and interact with Linux containers.

See some of the example commands below:

```
<span><span># Run a container</span>
wslc run<span> --rm</span><span> -it</span> ubuntu:latest bash<span> -c</span> <span>"echo Hello world from WSL container!"</span>
<span># List available images</span>
wslc image ls
<span># Run a web server</span>
wslc run<span> -it</span><span> --rm</span><span> -d</span><span> -p</span> <span>8080</span>:<span>80</span><span> --name</span> web nginx
<span># Get its content</span>
curl localhost:<span>8080</span>
<span># List the container</span>
wslc container ps
<span># Stop the container</span>
wslc container stop web
</span>
```

You can learn more on how to get started with this feature at [our container tutorial](https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-containers).

## WSL container API

Windows applications can make use of Linux containers as well! The WSL container API NuGet package allows you to programmatically pull, run, and interact with Linux containers, including key interactions like stdin and stdout, file mounts, networking mounts, GPU access and more.

For the complete API surface across the C, C#, and C++ projections, see the [WSL container API reference](https://wsl.dev/api-reference/).

### Install the API

The WSL container API ships in the `Microsoft.WSL.Containers` NuGet package, which provides both the C# projection and the C++/WinRT headers.

-   [C#](https://learn.microsoft.com/en-us/windows/wsl/wsl-container?tabs=csharp#tabpanel_1_csharp)
-   [C++](https://learn.microsoft.com/en-us/windows/wsl/wsl-container?tabs=csharp#tabpanel_1_cpp)

Add the package to your project with the .NET CLI:

```
<span>dotnet add package Microsoft.WSL.Containers
</span>
```

Then import the namespace in your code:

```
<span><span>using</span> Microsoft.WSL.Containers;
</span>
```

### API overview

The API is organized around a small set of objects that mirror the lifecycle of running a container:

| Object | Description |
| --- | --- |
| `WslcService` | Static entry point for service-level operations. Use it to check that the required WSL components are installed, query the service version, and install missing dependencies. |
| `Session` | A WSL-backed host that runs your containers. A session manages images (pull, import, load, push, tag, delete) and creates containers. |
| `Container` | A container created inside a session. Use it to start, stop, inspect, and delete the container, and to run additional processes inside it. |
| `Process` | A Linux process running in a container. Use it to read `stdout`/`stderr`, write to `stdin`, send signals, and observe exit codes through events. |

A typical flow is: verify prerequisites with `WslcService`, create and start a `Session`, pull an image, configure and create a `Container`, then start it and interact with its `Process` objects.

### Sample snippets

The snippets below show the same core building blocks in each supported language. Use the tabs to switch between C# and C++.

-   [C#](https://learn.microsoft.com/en-us/windows/wsl/wsl-container?tabs=csharp#tabpanel_2_csharp)
-   [C++](https://learn.microsoft.com/en-us/windows/wsl/wsl-container?tabs=csharp#tabpanel_2_cpp)

**Check that the required components are installed:**

```
<span>ComponentFlags missing = WslcService.GetMissingComponents();
<span>if</span> (missing != ComponentFlags.None)
{
    Console.WriteLine(<span>$"WSL components are missing (<span>{missing}</span>). Run: wsl --install"</span>);
    <span>return</span>;
}
</span>
```

**Create and start a session:**

```
<span><span>var</span> sessionSettings = <span>new</span> SessionSettings(<span>"MyApp"</span>, <span>@"C:\WslcData"</span>)
{
    CpuCount = <span>4</span>,
    MemoryMB = <span>4096</span>
};

<span>var</span> session = <span>new</span> Session(sessionSettings);
session.Start();
</span>
```

**Pull an image with progress reporting:**

```
<span><span>var</span> pull = session.PullImageAsync(<span>new</span> PullImageOptions(<span>"docker.io/library/alpine:latest"</span>));
pull.Progress = (op, progress) =&gt;
    Console.WriteLine(<span>$"Pull: <span>{progress.Status}</span> <span>{progress.CurrentBytes}</span>/<span>{progress.TotalBytes}</span>"</span>);
<span>await</span> pull;
</span>
```

**Create a container, run a command, and read its output:**

```
<span><span>var</span> initProcess = <span>new</span> ProcessSettings
{
    CmdLine = <span>new</span>[] { <span>"/bin/echo"</span>, <span>"Hello from WSL Container!"</span> },
    OutputMode = ProcessOutputMode.Event
};

<span>var</span> containerSettings = <span>new</span> ContainerSettings(<span>"alpine:latest"</span>)
{
    Name = <span>"hello-container"</span>,
    InitProcess = initProcess
};

<span>var</span> container = session.CreateContainer(containerSettings);

container.InitProcess.OutputReceived += data =&gt;
    Console.Write(Encoding.UTF8.GetString(data));

container.Start();
</span>
```

When you're finished, stop and delete the container, then terminate the session to release resources:

```
<span>container.Stop(Signal.SIGTERM, TimeSpan.FromSeconds(<span>10</span>));
container.Delete(DeleteContainerFlags.None);
session.Terminate();
</span>
```

### Full end-to-end samples

The snippets above show the core building blocks. For complete, runnable examples that cover the full container lifecycle, image management, port mappings, volume mounts, GPU access, and interactive `stdin`/`stdout` streaming, see the [WSL container API samples](https://aka.ms/wslc-samples).
