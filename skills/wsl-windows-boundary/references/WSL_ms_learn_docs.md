\--------------------------------------------------------------------------------

## Accessing network applications with WSL  Microsoft Learn.md

---
created: 2026-07-15T03:59:42 (UTC +08:00)
tags: [wsl,Linux,Windows,networking,ip address,ip addr,host IP,server,network,localhost,local area network,lan,ipv6,remote]
source: https://learn.microsoft.com/en-us/windows/wsl/networking
author: GrantMeStrength
---

# Accessing network applications with WSL | Microsoft Learn

> ## Excerpt
> Learn about the considerations for accessing network applications when using Windows Subsystem for Linux (WSL).

---
There are a few considerations to be aware of when working with networking apps and WSL. By default WSL uses a [NAT based architecture](https://learn.microsoft.com/en-us/windows/wsl/networking#default-networking-mode-nat), and we recommend trying the new [Mirrored networking mode](https://learn.microsoft.com/en-us/windows/wsl/networking#mirrored-mode-networking) to get the latest features and improvements.

## Identify IP address

There are two scenarios to consider when identifying the IP address used for a Linux distribution running via WSL:

**Scenario One:** From the perspective of the Windows host, you want to query a Linux distribution's IP address running via WSL2, so that a program on Windows host can connect to a server program running inside the distribution (instance).

The Windows host can use command:

```
<span>wsl.exe<span> --distribution</span> &lt;DistroName&gt; hostname<span> -I</span>
</span>
```

If querying the default distribution, this part of the command designating the distribution can be omitted: `-d <DistroName>`. Be sure to use a lower-case `-i` flag.

Under the hood, host command wsl.exe launches the target instance and executes Linux command `hostname --all-ip-addresses`. This command then prints the IP address of the WSL instance to `STDOUT`. The `STDOUT` text content is then relayed back to wsl.exe. Finally, wsl.exe displays that output to the command line.

A typical output might be:

```
<span><span>172.30</span>.<span>98.229</span>
</span>
```

**Scenario Two:** A program running inside a Linux distribution via WSL2 (instance) wants to know the Windows host's IP address, so that a Linux program can connect to a Windows host server program.

The WSL2 Linux user can use command:

```
<span>ip route show | grep -i default | awk <span>'{ print $3}'</span>
</span>
```

A typical output might be:

```
<span><span>172.30</span>.<span>96.1</span>
</span>
```

So the `172.30.96.1` is the host IP address for Windows, in this example.

Note

These above IP address querying action is typically required when WSL2 is running with the default [NAT network mode](https://learn.microsoft.com/en-us/windows/wsl/networking#default-networking-mode-nat). When the WSL2 is running with the new [mirrored mode](https://learn.microsoft.com/en-us/windows/wsl/networking#mirrored-mode-networking), the Windows host and WSL2 VM can connect to each other using `localhost` (127.0.0.1) as the destination address, so the trick of using a query peer's IP address is not required.

## Default networking mode: NAT

By default, WSL uses a NAT (Network Address Translation) based architecture for networking. Keep the following considerations in mind when working with a NAT-based networking architecture:

### Accessing Linux networking apps from Windows (localhost)

If you are building a networking app (for example an app running on a NodeJS or SQL server) in your Linux distribution, you can access it from a Windows app (like your Edge or Chrome internet browser) using `localhost` (just like you normally would).

### Accessing Windows networking apps from Linux (host IP)

If you want to access a networking app running on Windows (for example an app running on a NodeJS or SQL server) from your Linux distribution (ie Ubuntu), then you need to use the IP address of your host machine. While this is not a common scenario, you can follow these steps to make it work.

1.  Obtain the IP address of your host machine by running this command from your Linux distribution:
    
    ```
    <span>ip route show | grep -i default | awk <span>'{ print $3}'</span>
    </span>
    ```
    
2.  Connect to any Windows server using the copied IP address.
    

The picture below shows an example of this by connecting to a Node.js server running in Windows via curl.

![Connect to NodeJS server in Windows via Curl](https://learn.microsoft.com/en-us/windows/wsl/media/wsl2-network-l2w.png)

### Connecting via remote IP addresses

When using remote IP addresses to connect to your applications, they will be treated as connections from the Local Area Network (LAN). This means that you will need to make sure your application can accept LAN connections.

For example, you may need to bind your application to `0.0.0.0` instead of `127.0.0.1`. In the example of a Python app using Flask, this can be done with the command: `app.run(host='0.0.0.0')`. Keep security in mind when making these changes as this will allow connections from your LAN.

### Accessing a WSL 2 distribution from your local area network (LAN)

When using a WSL 1 distribution, if your computer was set up to be accessed by your LAN, then applications run in WSL could be accessed on your LAN as well.

This isn't the default case in WSL 2. WSL 2 has a virtualized ethernet adapter with its own unique IP address. Currently, to enable this workflow you will need to go through the same steps as you would for a regular virtual machine. (We are looking into ways to improve this experience.)

Here's an example of using the [Netsh interface portproxy](https://learn.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh-interface-portproxy) Windows command to add a port proxy that listens on your host port and connects that port proxy to the IP address for the WSL 2 VM.

```
<span>netsh interface portproxy add v4tov4 listenport=&lt;yourPortToForward&gt; listenaddress=<span>0.0</span>.<span>0.0</span> connectport=&lt;yourPortToConnectToInWSL&gt; connectaddress=(wsl hostname<span> -I</span>)
</span>
```

In this example, you will need to update `<yourPortToForward>` to a port number, for example `listenport=4000`. `listenaddress=0.0.0.0` means that incoming requests will be accepted from ANY IP address. The Listen Address specifies the IPv4 address for which to listen and can be changed to values that include: IP address, computer NetBIOS name, or computer DNS name. If an address isn't specified, the default is the local computer. You need to update the `<yourPortToConnectToInWSL>` value to a port number where you want WSL to connect, for example `connectport=4000`. Lastly, the `connectaddress` value needs to be the IP address of your Linux distribution installed via WSL 2 (the WSL 2 VM address), which can be found by entering the command: `wsl.exe hostname -I`.

So this command may look something like:

```
<span>netsh interface portproxy add v4tov4 listenport=<span>4000</span> listenaddress=<span>0.0</span>.<span>0.0</span> connectport=<span>4000</span> connectaddress=<span>192.168</span>.<span>101.100</span>
</span>
```

To obtain the IP address, use:

-   `wsl hostname -I` for the IP address of your Linux distribution installed via WSL 2 (the WSL 2 VM address)
-   `cat /etc/resolv.conf` for the IP address of the Windows machine as seen from WSL 2 (the WSL 2 VM)

Using `listenaddress=0.0.0.0` will listen on all [IPv4 ports](https://stackoverflow.com/questions/9987409/want-to-know-what-is-ipv4-and-ipv6#:%7E:text=The%20basic%20difference%20is%20the,whereas%20IPv6%20has%20128%20bits.).

Note

Using a lowercase "i" with the hostname command will generate a different result than using an uppercase "I". `wsl hostname -i` is your local machine (127.0.1.1 is a placeholder diagnostic address), whereas `wsl hostname -I` will return your local machine's IP address as seen by other machines and should be used to identify the `connectaddress` of your Linux distribution running via WSL 2.

## IPv6 access

-   `wsl hostname -I` for the IP address of your Linux distribution installed via WSL 2 (the WSL 2 VM address)
-   `ip route show | grep -i default | awk '{ print $3}'` for the IP address of the Windows machine as seen from WSL 2 (the WSL 2 VM)

Using `listenaddress=0.0.0.0` will listen on all [IPv4 ports](https://stackoverflow.com/questions/9987409/want-to-know-what-is-ipv4-and-ipv6#:%7E:text=The%20basic%20difference%20is%20the,whereas%20IPv6%20has%20128%20bits.).

## Mirrored mode networking

On machines running Windows 11 22H2 and higher you can [set `networkingMode=mirrored` under `[wsl2]` in the `.wslconfig` file](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#configuration-settings-for-wslconfig) to enable mirrored mode networking. Enabling this changes WSL to an entirely new networking architecture which has the goal of 'mirroring' the network interfaces that you have on Windows into Linux, to add new networking features and improve compatibility.

Here are the current benefits to enabling this mode:

-   IPv6 support
-   Connect to Windows servers from within Linux using the localhost address `127.0.0.1`. IPv6 localhost address `::1` is not supported
-   Improved networking compatibility for VPNs
-   Multicast support
-   Connect to WSL directly from your local area network (LAN)

Note

Run the following command in PowerShell window with admin privileges to [Configure Hyper-V firewall](https://learn.microsoft.com/en-us/windows/security/operating-system-security/network-security/windows-firewall/hyper-v-firewall) settings to allow inbound connections:

```
<span><span>Set-NetFirewallHyperVVMSetting</span><span> -Name</span> <span>'{40E0AC32-46A5-438A-A0B2-2B479E8F2E90}'</span><span> -DefaultInboundAction</span> Allow
</span>
```

or

```
<span><span>New-NetFirewallHyperVRule</span><span> -Name</span> <span>"MyWebServer"</span><span> -DisplayName</span> <span>"My Web Server"</span><span> -Direction</span> Inbound<span> -VMCreatorId</span> <span>'{40E0AC32-46A5-438A-A0B2-2B479E8F2E90}'</span><span> -Protocol</span> TCP<span> -LocalPorts</span> <span>80</span>
</span>
```

This new mode addresses networking issues seen with using a NAT (Network Address Translation) based architecture. Find known issues or file feedback on any bugs identified in the [WSL product repo on GitHub](https://github.com/microsoft/WSL).

## DNS Tunneling

On machines running Windows 11 22H2 and higher the `dnsTunneling` feature is on by default (which can be found [under `[wsl2]` in the `.wslconfig` file](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#configuration-settings-for-wslconfig)) and it uses a virtualization feature to answer DNS requests from within WSL, instead of requesting them over a networking packet. This feature is aimed to improve compatibility with VPNs, and other complex networking set ups.

## Auto Proxy

On machines running Windows 11 22H2 and higher, setting [`autoProxy=true` under `[wsl2]` in the `.wslconfig` file](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#configuration-settings-for-wslconfig) enforces WSL to use Windows' HTTP proxy information. If you have a proxy already set up in Windows, enabling this feature will make that proxy be set automatically in WSL as well.

## WSL and firewall

On machines running Windows 11 22H2 and higher, with WSL 2.0.9 and higher, the Hyper-V firewall feature will be turned on by default. This will ensure that:

-   See [Windows Defender Firewall with Advanced Security](https://learn.microsoft.com/en-us/windows/security/operating-system-security/network-security/windows-firewall/windows-firewall-with-advanced-security) to learn more about Windows security features that will automatically apply to WSL.
-   See [Configure Hyper-V firewall](https://learn.microsoft.com/en-us/windows/security/operating-system-security/network-security/windows-firewall/hyper-v-firewall) to learn more about applying these rules and settings both locally and via online tools like Intune.


\--------------------------------------------------------------------------------

## Advanced settings configuration in WSL  Microsoft Learn.md

---
created: 2026-07-15T03:59:06 (UTC +08:00)
tags: []
source: https://learn.microsoft.com/en-us/windows/wsl/wsl-config
author: GrantMeStrength
---

# Advanced settings configuration in WSL | Microsoft Learn

> ## Excerpt
> A guide to the wsl.conf and .wslconfig files used for configuring settings when running multiple Linux distributions on Windows Subsystem for Linux.

---
The [`wsl.conf`](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#wslconf) and [`.wslconfig`](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#wslconfig) files are used to configure advanced settings in WSL that will be applied [on start up of the WSL VM](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#the-8-second-rule-for-configuration-changes). `wsl.conf` is used to apply settings on a per WSL distro basis, and `.wslconfig` is used to apply global settings to WSL. You can read more about the differences below.

| Aspect | `.wslconfig` | `wsl.conf` |
| --- | --- | --- |
| Scope | General settings that apply to all of WSL | Settings for WSL distributions only |
| Configures | Feature enablement in WSL, settings for the virtual machine powering WSL 2 (RAM, kernel to boot, number of CPUs, etc.) | Distribution settings in WSL such as boot options, DrvFs automounts, networking, interoperability with the Windows system, systemd usage, and default user |
| Location | `%UserProfile%\.wslconfig`, outside of a WSL distribution | `/etc/wsl.conf`, while inside a WSL distribution |

Currently, all `.wslconfig` settings apply only to WSL 2 distributions. Learn [how to check which version of WSL you are running](https://learn.microsoft.com/en-us/windows/wsl/install#check-which-version-of-wsl-you-are-running).

## The 8 second rule for configuration changes

You must wait until the subsystem running your Linux distribution completely stops running and restarts for configuration setting updates to appear. This typically takes about 8 seconds after closing ALL instances of the distribution shell.

If you launch a distribution (e.g. Ubuntu), modify the configuration file, close the distribution, and then re-launch it, you might assume that your configuration changes have immediately gone into effect. This is not currently the case as the subsystem could still be running. You must wait for the subsystem to stop before relaunching in order to give enough time for your changes to be picked up. You can check to see whether your Linux distribution (shell) is still running after closing it by using PowerShell with the command: `wsl --list --running`. If no distributions are running, you will receive the response: "There are no running distributions." You can now restart the distribution to see your configuration updates applied.

The command `wsl --shutdown` is a fast path to restarting WSL 2 distributions, but it will shut down all running distributions, so use wisely. You can also use `wsl --terminate <distroName>` to terminate a specific distribution that's running instantly.

## wsl.conf

Configure **local settings** with **wsl.conf** per-distribution for each Linux distribution running on WSL 1 or WSL 2.

-   Stored in the `/etc` directory of the distribution as a unix file.
-   Used to configure settings on a per-distribution basis. Settings configured in this file will only be applied to the specific Linux distribution that contains the directory where this file is stored.
-   Can be used for distributions run by either version, WSL 1 or WSL 2.
-   To get to the `/etc` directory for an installed distribution, use the distribution's command line with `cd /` to access the root directory, then `ls` to list files or `explorer.exe .` to view in Windows File Explorer. The directory path should look something like: `/etc/wsl.conf`.

Note

Adjusting per-distribution settings with the wsl.conf file is only available in Windows Build 17093 and later.

### Configuration settings for wsl.conf

The wsl.conf file configures settings on a per-distribution basis. _(For global configuration of WSL 2 distributions see [.wslconfig](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#wslconfig))._

The wsl.conf file supports four sections: `automount`, `network`, `interop`, and `user`. _(Modeled after .ini file conventions, keys are declared under a section, like .gitconfig files.)_ See [wsl.conf](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#wslconf) for info on where to store the wsl.conf file.

### systemd support

Many Linux distributions run "systemd" by default (including Ubuntu). WSL supports this system/service manager on recent versions of WSL from the Microsoft Store, making WSL even more similar to using your favorite Linux distributions on a bare metal machine. Check your WSL version with `wsl --version`. If you need to update, you can grab the [latest version of WSL in the Microsoft Store](https://aka.ms/wslstorepage). If `wsl --version` is not recognized, you are likely using an older inbox version of WSL that must be updated before systemd is available.

To enable systemd, open your `wsl.conf` file in a text editor using `sudo` for admin permissions and add these lines to the `/etc/wsl.conf`:

```
<span>[boot]
systemd=<span>true</span>
</span>
```

You will then need to close your WSL distribution using `wsl.exe --shutdown` from PowerShell to restart your WSL instances. Once your distribution restarts, systemd should be running. You can confirm using the command: `systemctl list-unit-files --type=service`, which will show the status of your services.

### Automount settings

wsl.conf section label: `[automount]`

| Key | Value | Default | Notes |
| --- | --- | --- | --- |
| `enabled` | boolean | `true` | `true` causes fixed drives (i.e `C:/` or `D:/`) to be automatically mounted with DrvFs under `/mnt`. `false` means drives won't be mounted automatically, but you could still mount them manually or via `fstab`. |
| `mountFsTab` | boolean | `true` | `true` sets `/etc/fstab` to be processed on WSL start. `/etc/fstab` is a file where you can declare other filesystems, like an SMB share. Thus, you can mount these filesystems automatically in WSL on start up. |
| `root` | string | `/mnt/` | Sets the directory where fixed drives will be automatically mounted. By default this is set to `/mnt/`, so your Windows file system `C:\` is mounted to `/mnt/c/`. If you change `/mnt/` to `/windir/`, you should expect to see your fixed `C:\` mounted to `/windir/c`. |
| `options` | comma-separated list of values, such as uid, gid, etc, see automount options below | Null | The automount option values are listed below and are appended to the default DrvFs mount options string. **Only DrvFs-specific options can be specified.** |

The automount options are applied as the mount options for all automatically mounted drives. To change the options for a specific drive only, use the `/etc/fstab` file instead. Options that the mount binary would normally parse into a flag are not supported. If you want to explicitly specify those options, you must include every drive for which you want to do so in `/etc/fstab`.

#### Automount options

Setting different mount options for Windows drives (DrvFs) can control how file permissions are calculated for Windows files. The following options are available:

| Key | Description | Default |
| --- | --- | --- |
| `uid` | The User ID used for the owner of all files | The default User ID of your WSL distro (on first installation this defaults to `1000`) |
| `gid` | The Group ID used for the owner of all files | The default group ID of your WSL distro (on first installation this defaults to `1000`) |
| `umask` | An octal mask of permissions to exclude for all files and directories | `022` |
| `fmask` | An octal mask of permissions to exclude for all files | `000` |
| `dmask` | An octal mask of permissions to exclude for all directories | `000` |
| `metadata` | Whether metadata is added to Windows files to support Linux system permissions | `disabled` |
| `case` | Determines directories treated as case sensitive and whether new directories created with WSL will have the flag set. See [case sensitivity](https://learn.microsoft.com/en-us/windows/wsl/case-sensitivity) for a detailed explanation of the options. Options include `off`, `dir`, or `force`. | `off` |

By default, WSL sets the `uid` and `gid` to the value of the default user. For example, in Ubuntu, the default user is `uid=1000`, `gid=1000`. If this value is used to specify a different `gid` or `uid` option, the default user value will be overwritten. Otherwise, the default value will always be appended.

The above umask, fmask, etc. options will only apply when the Windows drive is mounted with metadata. By default metadata is not enabled. You can [find more info about this here](https://learn.microsoft.com/en-us/windows/wsl/file-permissions).

Note

The permission masks are put through a logical OR operation before being applied to files or directories.

#### What is DrvFs?

DrvFs is a filesystem plugin to WSL that was designed to support interop between WSL and the Windows filesystem. DrvFs enables WSL to mount drives with supported file systems under /mnt, such as /mnt/c, /mnt/d, etc. For more information about specifying the default case sensitivity behavior when mounting Windows or Linux drives or directories, see the [case sensitivity](https://learn.microsoft.com/en-us/windows/wsl/case-sensitivity) page.

### Network settings

wsl.conf section label: `[network]`

| Key | Value | Default | Notes |
| --- | --- | --- | --- |
| `generateHosts` | boolean | `true` | `true` sets WSL to generate `/etc/hosts`. The `hosts` file contains a static map of hostnames corresponding IP address. |
| `generateResolvConf` | boolean | `true` | `true` sets WSL to generate `/etc/resolv.conf`. The `resolv.conf` contains a DNS list that are capable of resolving a given hostname to its IP address. |
| `hostname` | string | Windows hostname | Sets hostname to be used for WSL distribution. |

### Interop settings

wsl.conf section label: `[interop]`

These options are available in Windows 10 version 1809 (build 17763) and later.

| Key | Value | Default | Notes |
| --- | --- | --- | --- |
| `enabled` | boolean | `true` | Setting this key will determine whether WSL will support launching Windows processes. |
| `appendWindowsPath` | boolean | `true` | Setting this key will determine whether WSL will add Windows path elements to the `$PATH` environment variable. |

### User settings

wsl.conf section label: `[user]`

These options are available in Build 18980 and later.

| Key | Value | Default | Notes |
| --- | --- | --- | --- |
| `default` | string | The initial username created on first run | Setting this key specifies which user to run as when first starting a WSL session. |

### Boot settings

The Boot setting is only available on Windows 11 and Server 2022.

wsl.conf section label: `[boot]`

| Key | Value | Default | Notes |
| --- | --- | --- | --- |
| `command` | string | Null | A string of the command that you would like to run when the WSL instance starts. This command is run as the root user. e.g: `service docker start`. |
| `protectBinfmt` | boolean | `true` | Prevents WSL from generating systemd units when systemd is enabled. |

### GPU settings

wsl.conf section label: `[gpu]`

| Key | Value | Default | Notes |
| --- | --- | --- | --- |
| `enabled` | boolean | `true` | Allow Linux applications to access the Windows GPU via para-virtualization. |

### Time settings

wsl.conf section label: `[time]`

| Key | Value | Default | Notes |
| --- | --- | --- | --- |
| `useWindowsTimezone` | boolean | `true` | Setting this key will make WSL use and sync to the timezone set in Windows. |

### Example wsl.conf file

The `wsl.conf` sample file below demonstrates some of the configuration options available. In this example, the distribution is Ubuntu-20.04 and the file path is `\\wsl.localhost\Ubuntu-20.04\etc\wsl.conf`.

```
<span><span># Automatically mount Windows drive when the distribution is launched</span>
[automount]

<span># Set to true will automount fixed drives (C:/ or D:/) with DrvFs under the root directory set above. Set to false means drives won't be mounted automatically, but need to be mounted manually or with fstab.</span>
enabled=<span>true</span>

<span># Sets the directory where fixed drives will be automatically mounted. This example changes the mount location, so your C-drive would be /c, rather than the default /mnt/c.</span>
root = /

<span># DrvFs-specific options can be specified.</span>
options = <span>"metadata,uid=1003,gid=1003,umask=077,fmask=11,case=off"</span>

<span># Sets the `/etc/fstab` file to be processed when a WSL distribution is launched.</span>
mountFsTab=<span>true</span>

<span># Network host settings that enable the DNS server used by WSL 2. This example changes the hostname, sets generateHosts to false, preventing WSL from the default behavior of auto-generating /etc/hosts, and sets generateResolvConf to false, preventing WSL from auto-generating /etc/resolv.conf, so that you can create your own (ie. nameserver 1.1.1.1).</span>
[network]
hostname=DemoHost
generateHosts=<span>false</span>
generateResolvConf=<span>false</span>

<span># Set whether WSL supports interop processes like launching Windows apps and adding path variables. Setting these to false will block the launch of Windows processes and block adding $PATH environment variables.</span>
[interop]
enabled=<span>false</span>
appendWindowsPath=<span>false</span>

<span># Set the user when launching a distribution with WSL.</span>
[user]
default=DemoUser

<span># Set a command to run when a new WSL instance launches. This example starts the Docker container service.</span>
[boot]
<span>command</span>=service docker start
</span>
```

## .wslconfig

Configure **global settings** with **.wslconfig** across all installed distributions running on WSL.

-   The .wslconfig file does not exist by default. It must be created and stored in your `%UserProfile%` directory to apply these configuration settings.
-   Used to configure settings globally across all installed Linux distributions running as the WSL 2 version.
-   Can be used **only for distributions run by WSL 2**. Distributions running as WSL 1 will not be affected by this configuration as they are not running as a virtual machine.
-   To get to your `%UserProfile%` directory, in PowerShell, use `cd ~` to access your home directory (which is typically your user profile, `C:\Users\<UserName>`) or you can open Windows File Explorer and enter `%UserProfile%` in the address bar. The directory path should look something like: `C:\Users\<UserName>\.wslconfig`.

WSL will detect the existence of these files, read the contents, and automatically apply the configuration settings every time you launch WSL. If the file is missing or malformed (improper markup formatting), WSL will continue to launch as normal without the configuration settings applied.

### Configuration settings for .wslconfig

The .wslconfig file configures settings globally for all Linux distributions running with WSL 2. _(For per-distribution configuration see [wsl.conf](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#wslconf))._

See [.wslconfig](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#wslconfig) for info on where to store the .wslconfig file.

Note

Configuring global settings with `.wslconfig` are only available for distributions running as WSL 2 in Windows Build 19041 and later. Keep in mind you may need to run `wsl --shutdown` to shut down the WSL 2 VM and then restart your WSL instance for these changes to take effect.

Tip

It is recommended to modify WSL configurations directly in WSL Settings, rather than manually editing the .wslconfig file. WSL Settings can be found in the Start menu. ![Windows Subsystem for Linux Settings](https://learn.microsoft.com/en-us/windows/wsl/media/wsl-settings.png)

This file can contain the following options that affect the VM that powers any WSL 2 distribution:

### Main WSL settings

.wslconfig section label: `[wsl2]`

| Key | Value | Default | Notes |
| --- | --- | --- | --- |
| `kernel` | path | The Microsoft built kernel provided inbox | An absolute Windows path to a custom Linux kernel. |
| `kernelModules` | path | An absolute Windows path to a custom Linux kernel modules VHD. |  |
| `memory` | size | 50% of total memory on Windows | How much memory to assign to the WSL 2 VM. |
| `processors` | number | The same number of logical processors on Windows | How many logical processors to assign to the WSL 2 VM. |
| `localhostForwarding` | boolean | `true` | Boolean specifying if ports bound to wildcard or localhost in the WSL 2 VM should be connectable from the host via `localhost:port`. |
| `kernelCommandLine` | string | None | Additional kernel command line arguments. |
| `safeMode` | boolean | `false` | Run WSL in "Safe Mode" which disables many features and is intended to be used to recover distributions that are in bad states. Only available for Windows 11 and WSL version 0.66.2+. |
| `swap` | size | 25% of memory size on Windows rounded up to the nearest GB | How much swap space to add to the WSL 2 VM, 0 for no swap file. Swap storage is disk-based RAM used when memory demand exceeds limit on hardware device. |
| `swapFile` | path | `%Temp%\swap.vhdx` | An absolute Windows path to the swap virtual hard disk. |
| `guiApplications` | boolean | `true` | Boolean to turn on or off support for GUI applications ([WSLg](https://github.com/microsoft/wslg)) in WSL. |
| `debugConsole`¹ | boolean | `false` | Boolean to turn on an output console Window that shows the contents of `dmesg` upon start of a WSL 2 distro instance. |
| `maxCrashDumpCount` | number | `10` | Set the maximum number of crash dump files that will be retained for debugging purposes. The default number retained by WSL is 10. When this limit is exceeded, older crash dumps will be automatically deleted to make room for new ones. Setting a max can help with reducing the amount of disk space used by these crash files. |
| `nestedVirtualization`¹ | boolean | `true` | Boolean to turn on or off nested virtualization, enabling other nested VMs to run inside WSL 2. |
| `vmIdleTimeout`¹ | number | `60000` | The number of milliseconds that a VM is idle, before it is shut down. |
| `dnsProxy` | boolean | `true` | Only applicable to `networkingMode = NAT`. Boolean to inform WSL to configure the DNS Server in Linux to the NAT on the host. Setting to `false` will mirror DNS servers from Windows to Linux. |
| `networkingMode`¹² | string | `NAT` | Available values are: `none`, `nat`, `bridged` (deprecated), `mirrored`, and `virtioproxy`. If the value is `none`, the WSL network is disconnected. If the value is `nat` or an unknown value, NAT network mode is used (starting from WSL 2.3.25, if NAT network mode fails, it falls back to using VirtioProxy network mode). If the value is `bridged`, the bridged network mode is used (this mode has been marked as deprecated since WSL 2.4.5). If the value is `mirrored`, the mirrored network mode is used. If the value is `virtioproxy`, the VirtioProxy network mode is used. |
| `firewall`¹² | boolean | `true` | Setting this to true allows the Windows Firewall rules, as well as rules specific to Hyper-V traffic, to filter WSL network traffic. |
| `dnsTunneling`¹² | boolean | `true` | Changes how DNS requests are proxied from WSL to Windows |
| `autoProxy`¹ | boolean | `true` | Enforces WSL to use Windows’ HTTP proxy information |
| `defaultVhdSize` | size | `1099511627776` (1 TB) | Set the Virtual Hard Disk (VHD) size that stores the Linux distribution (for example, Ubuntu) file system. Can be used to limit the maximum size that a distribution file system is allowed to take up. |

Entries with the "**path**" value must be Windows paths with escaped backslashes, e.g: `C:\\Temp\\myCustomKernel`

Entries with the `size` value default to B (bytes), and the unit is omissible. To use other units, the size unit must be appended, e.g.: `8GB` or `512MB`.

¹: Only available on Windows 11.

²: Require [Windows 11 version 22H2](https://blogs.windows.com/windows-insider/2023/09/14/releasing-windows-11-build-22621-2359-to-the-release-preview-channel/) or higher.

### Experimental settings

These settings are opt-in previews of experimental features that we aim to make default in the future.

.wslconfig section label: `[experimental]`

| Key | Value | Default | Notes |
| --- | --- | --- | --- |
| `autoMemoryReclaim` | string | `dropCache` | Available values are: `disabled`, `gradual`, and `dropCache`. If the value is `disabled`, WSL automatic memory reclamation will be disabled. If the value is `gradual`, cached memory will be reclaimed slowly and automatically. If the value is `dropCache` or an unknown value, cached memory will be reclaimed immediately. |
| `sparseVhd` | bool | `false` | When set to `true`, any newly created VHD will be set to sparse automatically. |
| `bestEffortDnsParsing`¹² | bool | `false` | Only applicable when `wsl2.dnsTunneling` is set to `true`. When set to `true`, Windows will extract the question from the DNS request and attempt to resolve it, ignoring the unknown records. |
| `dnsTunnelingIpAddress`¹² | string | `10.255.255.254` | Only applicable when `wsl2.dnsTunneling` is set to `true`. Specifies the nameserver that will be configured in the Linux `resolv.conf` file when DNS tunneling is enabled. |
| `initialAutoProxyTimeout`¹ | string | `1000` | Only applicable when `wsl2.autoProxy` is set to `true`. Configures how long (in milliseconds) WSL will wait for retrieving HTTP proxy information when starting a WSL container. If proxy settings are resolved after this time, the WSL instance must be restarted to use the retrieved proxy settings. |
| `ignoredPorts`¹² | string | Null | Only applicable when `wsl2.networkingMode` is set to `mirrored`. Specifies which ports Linux applications can bind to, even if that port is used in Windows. This enables applications to listen on a port for traffic purely within Linux, so those applications are not blocked even when that port is used for other purposes on Windows. For example, WSL will allow binding to port 53 in Linux for Docker Desktop, as it is listening only to requests from within the Linux container. Should be formatted in a comma separated list, e.g: `3000,9000,9090` |
| `hostAddressLoopback`¹² | bool | `false` | Only applicable when `wsl2.networkingMode` is set to `mirrored`. When set to `true`, will allow the Container to connect to the Host, or the Host to connect to the Container, by an IP address that's assigned to the Host. The `127.0.0.1` loopback address can always be used,this option allows for all additionally assigned local IP addresses to be used as well. Only IPv4 addresses assigned to the host are supported. |

¹: Only available on Windows 11.

²: Require [Windows 11 version 22H2](https://blogs.windows.com/windows-insider/2023/09/14/releasing-windows-11-build-22621-2359-to-the-release-preview-channel/) or higher.

## Example .wslconfig file

The `.wslconfig` sample file below demonstrates some of the configuration options available. In this example, the file path is `%UserProfile%\.wslconfig`.

```
<span><span># Settings apply across all Linux distros running on WSL 2</span>
[wsl2]

<span># Limits VM memory to use no more than 4 GB, this can be set as whole numbers using GB or MB</span>
memory=4GB

<span># Sets the VM to use two virtual processors</span>
processors=2

<span># Specify a custom Linux kernel to use with your installed distros. The default kernel used can be found at https://github.com/microsoft/WSL2-Linux-Kernel</span>
kernel=C:\\temp\\myCustomKernel

<span># Specify the modules VHD for the custom Linux kernel to use with your installed distros.</span>
kernelModules=C:\\temp\\modules.vhdx

<span># Sets additional kernel parameters, in this case enabling older Linux base images such as Centos 6</span>
kernelCommandLine = vsyscall=<span>emulate</span>

<span># Sets amount of swap storage space to 8GB, default is 25% of available RAM</span>
swap=8GB

<span># Sets swapfile path location, default is %UserProfile%\AppData\Local\Temp\swap.vhdx</span>
swapfile=C:\\temp\\wsl-swap.vhdx

<span># Turn on default connection to bind WSL 2 localhost to Windows localhost. Setting is ignored when networkingMode=mirrored</span>
localhostforwarding=<span>true</span>

<span># Disables nested virtualization</span>
nestedVirtualization=<span>false</span>

<span># Turns on output console showing contents of dmesg when opening a WSL 2 distro for debugging</span>
debugConsole=<span>true</span>

<span># Sets the maximum number of crash dump files to retain (default is 10)</span>
maxCrashDumpCount=10

<span># Enable experimental features</span>
[experimental]
sparseVhd=<span>true</span>
</span>
```

## Additional resources

-   [Windows Command Line Blog: Automatically Configuring WSL](https://devblogs.microsoft.com/commandline/automatically-configuring-wsl/)
-   [Windows Command Line Blog: Chmod/Chown, DrvFs, file metadata](https://devblogs.microsoft.com/commandline/chmod-chown-wsl-improvements/)


\--------------------------------------------------------------------------------

## File Permissions for WSL  Microsoft Learn.md

---
created: 2026-07-15T03:59:26 (UTC +08:00)
tags: [File permissions,bash,wsl,wsl2,windows,windows subsystem for linux,windows subsystem,ubuntu,debian,suse,windows 10]
source: https://learn.microsoft.com/en-us/windows/wsl/file-permissions
author: GrantMeStrength
---

# File Permissions for WSL | Microsoft Learn

> ## Excerpt
> Understanding how WSL determines file permissions in Windows

---
This page details how Linux file permissions are interpreted across the Windows Subsystem for Linux, especially when accessing resources inside of Windows on the NT file system. This documentation assumes a basic understanding of the [Linux file system permissions structure](https://wiki.archlinux.org/title/File_permissions_and_attributes) and the [umask command](https://en.wikipedia.org/wiki/Umask).

When accessing Windows files from WSL the file permissions are either calculated from Windows permissions, or are read from metadata that has been added to the file by WSL. This metadata is not enabled by default.

When metadata is enabled as a mount option in WSL, extended attributes on Windows NT files can be added and interpreted to supply Linux file system permissions.

WSL can add four NTFS extended attributes:

| Attribute Name | Description |
| --- | --- |
| $LXUID | User Owner ID |
| $LXGID | Group Owner ID |
| $LXMOD | File mode (File systems permission octals and type, e.g: 0777) |
| $LXDEV | Device, if it is a device file |

Additionally, any file that is not a regular file or directory (e.g: symlinks, FIFOs, block devices, unix sockets, and character devices) also have an NTFS [reparse point](https://learn.microsoft.com/en-us/windows/win32/fileio/reparse-points). This makes it much faster to determine the kind of file in a given directory without having to query its extended attributes.

## File Access Scenarios

Below is a description of how permissions are determined when accessing files in different ways using the Windows Subsystem for Linux.

### Accessing Files in the Windows drive file system (DrvFS) from Linux

These scenarios occur when you are accessing your Windows files from WSL, most likely via `/mnt/c`.

#### Reading file permissions from an existing Windows file

The result depends on if the file already has existing metadata.

##### DrvFS file does not have metadata (default)

If the file has no metadata associated with it then we translate the effective permissions of the Windows user to read/write/execute bits and set them to this as the same value for user, group, and other. For example, if your Windows user account has read and execute access but not write access to the file then this will be shown as `r-x` for user, group and other. If the file has the 'Read Only' attribute set in Windows then we do not grant write access in Linux.

##### The file has metadata

If the file has metadata present, we simply use those metadata values instead of translating effective permissions of the Windows user.

#### Changing file permissions on an existing Windows file using chmod

The result depends on if the file already has existing metadata.

##### chmod file does not have metadata (default)

Chmod will only have one effect, if you remove all the write attributes of a file then the 'read only' attribute on the Windows file will be set, since this is the same behavior as CIFS (Common Internet File System) which is the SMB (Server Message Block) client in Linux.

##### chmod file has metadata

Chmod will change or add metadata depending on the file's already existing metadata.

Please keep in mind that you cannot give yourself more access than what you have on Windows, even if the metadata says that is the case. For example, you could set the metadata to display that you have write permissions to a file using `chmod 777`, but if you tried to access that file you would still not be able to write to it. This is thanks to interoperability, as any read or write commands to Windows files are routed through your Windows user permissions.

#### Creating a file in DriveFS

The result depends on if metadata is enabled.

##### Metadata is not enabled (default)

The Windows permissions of the newly created file will be the same as if you created the file in Windows without a specific security descriptor, it will inherit the parent's permissions.

##### Metadata is enabled

The file's permission bits are set to follow the Linux umask, and the file will be saved with metadata.

#### Which Linux user and Linux group owns the file?

The result depends on if the file already has existing metadata.

##### User file does not have metadata (default)

In the default scenario, when automounting Windows drives, we specify that the user ID (UID) for any file is set to the user ID of your WSL user and the group ID (GID) is set to the principal group ID of your WSL user.

##### User file has metadata

The UID and GID specified in the metadata is applied as the user owner and group owner of the file.

### Accessing Linux files from Windows using `\\wsl$`

Accessing Linux files via `\\wsl$` will use the default user of your WSL distribution. Therefore any Windows app accessing Linux files will have the same permissions as the default user.

#### Creating a new file

The default umask is applied when creating a new file inside of a WSL distribution from Windows. The default umask is `022`, or in other words it allows all permissions except write permissions to groups and others.

### Accessing files in the Linux root file system from Linux

Any files created, modified, or accessed in the Linux root file system follow standard Linux conventions, such as applying the umask to a newly created file.

## Configuring file permissions

You can configure your file permissions inside of your Windows drives using the mount options in wsl.conf. The mount options allow you to set `umask`, `dmask` and `fmask` permissions masks. The `umask` is applied to all files, the `dmask` is applied just to directories and the `fmask` is applied just to files. These permission masks are then put through a logical OR operation when being applied to files, e.g: If you have a `umask` value of `023` and an `fmask` value of `022` then the resulting permissions mask for files will be `023`.

Learn more: [Per distribution configuration options with wsl.conf](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#wslconf).


\--------------------------------------------------------------------------------

## Use systemd to manage Linux services with WSL  Microsoft Learn.md

---
created: 2026-07-15T04:00:02 (UTC +08:00)
tags: []
source: https://learn.microsoft.com/en-us/windows/wsl/systemd
author: GrantMeStrength
---

# Use systemd to manage Linux services with WSL | Microsoft Learn

> ## Excerpt
> Learn how to use systemd to manage Linux services with Windows Subsystem for Linux.

---
Windows Subsystem for Linux (WSL) now supports systemd, an init system and service manager used by many popular Linux distributions such as Ubuntu, Debian, and more. ([What is systemd?](https://learn.microsoft.com/en-us/windows/wsl/systemd#what-is-systemd-in-linux)).

The init system default has recently changed from SystemV, with [systemd now the default for the current version of Ubuntu](https://canonical.com/blog/ubuntu-desktop-23-04-release-roundup#:%7E:text=Systemd%20becomes%20the%20default%20for%20Ubuntu%20on%20WSL) that will be installed using the [`wsl --install` command](https://learn.microsoft.com/en-us/windows/wsl/install) default. Linux distributions other than the current version of Ubuntu may still use the WSL init, similar to SystemV init. To change to systemd, see [How to enable systemd](https://learn.microsoft.com/en-us/windows/wsl/systemd#how-to-enable-systemd).

## What is systemd in Linux?

According to [systemd.io](https://systemd.io/): "systemd is a suite of basic building blocks for a Linux system. It provides a system and service manager that runs as PID 1 and starts the rest of the system."

Primarily an init system and service manager, systemd includes features like on-demand starting of daemons, mount and automount point maintenance, snapshot support, and processes tracking using Linux control groups.

Most major Linux distributions now run systemd, so enabling it on WSL brings the experience even closer to using bare-metal Linux. See the [video announcement with systemd demos](https://learn.microsoft.com/en-us/windows/wsl/systemd#systemd-demo-video) or [examples of using systemd](https://learn.microsoft.com/en-us/windows/wsl/systemd#systemd-examples) below to learn more about what systemd has to offer.

## How to enable systemd?

Systemd is [now the default for the current version of Ubuntu](https://canonical.com/blog/ubuntu-desktop-23-04-release-roundup#:%7E:text=Systemd%20becomes%20the%20default%20for%20Ubuntu%20on%20WSL) that will be installed using the [`wsl --install` command](https://learn.microsoft.com/en-us/windows/wsl/install) default.

To enable systemd for any other Linux distributions running on WSL 2 (changing the default from using the systemv init):

1.  Ensure that your WSL version is 0.67.6 or newer:
    
    -   to check, run `wsl --version`; if the command throws `Invalid command line option: --version` error, you must update WSL;
    -   to update, run `wsl --update` or [download the latest version from the Microsoft Store](https://aka.ms/wslstorepage).
2.  Open a command line for your Linux distribution and enter `cd /` to access the root directory, then `ls` to list the files. You will see a directory named "etc" that contains the WSL configuration file for the distribution. Open this file so that you can make an update with the Nano text editor by entering: `nano /etc/wsl.conf`.
    
3.  Add these lines in the `wsl.conf` file that you now have open to change the init used to systemd:
    
    ```
    <span>[boot]
    systemd=<span>true</span>
    </span>
    ```
    
    ![Enable systemd on WSL 2](https://learn.microsoft.com/en-us/windows/wsl/media/systemd-enable.png)
    
4.  Exit the Nano text editor (Ctrl + X, type Y to save your change and confirm with the `enter` key).
    
5.  You will then need to close the Linux distribution. You can use the command `wsl.exe --shutdown` in PowerShell to restart all WSL instances.
    
6.  Once you restart the Linux distribution, systemd will be running. You can verify it by using the command `systemctl status` to show the _running_ state and the command `systemctl list-unit-files --type=service`, which will show the status of any services associated with your Linux distribution.
    

If your Linux distribution is Debian/Ubuntu/Kali Rolling, you should not only have installed the systemd package, but also make sure the systemd-sysv package is installed.

```
<span>sudo apt-get update -y &amp;&amp; sudo apt-get install systemd systemd-sysv -y
</span>
```

Learn more about [Advanced settings configuration in WSL](https://learn.microsoft.com/en-us/windows/wsl/wsl-config), including the difference between the `wsl.conf` (distribution-specific) and `.wslconfig` (global) config files, how to update automount settings, etc.

## Systemd demo video

Microsoft partnered with Canonical to bring systemd support to WSL. See Craig Loewen (PM for WSL at Microsoft) and Oliver Smith (PM for Ubuntu on WSL at Canonical) announce systemd support and show some demos of what it enables.

-   [Systemd support blog announcement](https://devblogs.microsoft.com/commandline/systemd-support-is-now-available-in-wsl/)
    
-   [Oliver's tutorials based on these demos on the Ubuntu blog](https://ubuntu.com/blog/ubuntu-wsl-enable-systemd) - includes "Use snap to create a Nextcloud instance in minutes on WSL", "Manage your web projects with LXD", and ["Run a .Net Echo Bot as a systemd service on Ubuntu WSL"](https://ubuntu.com/tutorials/run-dotnet-echo-bot-with-systemd-on-ubuntu-wsl#1-overview)
    
-   [Craig's microk8s demo on GitHub](https://github.com/craigloewen-msft/microk8sdemo)
    

## Systemd examples

A few examples of Linux applications that depend on systemd are:

-   [snap](https://snapcraft.io/): a software packaging and deployment system developed by Canonical for operating systems that use the Linux kernel and the systemd init system. The packages are called "snaps", the command line tool for building snaps is called "Snapcraft", the central repository where snaps can be downloaded/installed is called the "Snap Store", and the daemon required to run snaps (download from the store, mount into place, confine, and run apps out of them) is called "snapd". The entire system is sometimes referred to as "snappy." Try running the command: `snap install spotify`.
    
-   [microk8s](https://microk8s.io/): an open-source, low-ops, minimal production Kubernetes that automates deployment, scaling, and management of containerized apps. Follow the instructions to [Install MicroK8s on WSL2](https://microk8s.io/docs/install-wsl2), check out the [Get Started Tutorial](https://microk8s.io/docs/getting-started), or watch the video on [Kubernetes on Windows with MicroK8s and WSL 2](https://ubuntu.com/blog/kubernetes-on-windows-with-microk8s-and-wsl-2).
    
-   [systemctl](https://www.linode.com/docs/guides/introduction-to-systemctl/): a command-line utility used to control and inspect systemd and to help you interact with services on your Linux distribution. Try the command: `systemctl list-units --type=service` to see which services are available and their status.
    

A few related tutorials demonstrating ways to use systemd:

-   [Understanding and Using Systemd](https://www.linux.com/training-tutorials/understanding-and-using-systemd/)
    
-   [Systemd Essentials: Working with the Services, Units, and the Journal](https://www.digitalocean.com/community/tutorials/systemd-essentials-working-with-services-units-and-the-journal)
    
-   [How To Sandbox Processes With Systemd On Ubuntu 20.04](https://www.digitalocean.com/community/tutorials/how-to-sandbox-processes-with-systemd-on-ubuntu-20-04)
    

## How does enabling systemd affect WSL architecture?

Enabling support for systemd required changes to the WSL architecture. As systemd requires PID 1, the WSL init process started within the Linux distribution becomes a child process of the systemd. Because the WSL init process is responsible for providing the infrastructure for communication between the Linux and Windows components, changing this hierarchy required rethinking some of the assumptions made with the WSL init process. Additional modifications had to be made to ensure a clean shutdown (as that shutdown is controlled by systemd now) and to have compatibility with [WSLg](https://learn.microsoft.com/en-us/windows/wsl/tutorials/gui-apps), the component of WSL that runs Linux Graphical User Interfaces (GUIs), or the Linux apps that display in windows rather than the command line.

It is also important to note that with these changes, systemd services will NOT keep your WSL instance alive. Your WSL instance will stay alive in the same way it did previous to this update, which you can read more about in this [Background Task Support blog post from 2017](https://devblogs.microsoft.com/commandline/background-task-support-in-wsl/).


\--------------------------------------------------------------------------------

## Working across file systems  Microsoft Learn.md

---
created: 2026-07-15T03:46:16 (UTC +08:00)
tags: [wsl,Linux,Windows,file systems,interop,across directories,mnt]
source: https://learn.microsoft.com/en-us/windows/wsl/filesystems
author: GrantMeStrength
---

# Working across file systems | Microsoft Learn

> ## Excerpt
> Learn about the considerations and interop commands available when working across Windows and Linux file systems with WSL.

---
There are a number of considerations to keep in mind when working between Windows and Linux file systems. We have outlined a few of them for you in this guide, including some examples of interoperability support for mixing Windows and Linux-based commands.

## File storage and performance across file systems

We recommend against working across operating systems with your files, unless you have a specific reason for doing so. For the fastest performance speed, store your files in the WSL file system if you are working in a Linux command line (Ubuntu, OpenSUSE, etc). If you're working in a Windows command line (PowerShell, Command Prompt), store your files in the Windows file system.

For example, when storing your WSL project files:

-   Use the Linux file system root directory: `/home/<user name>/Project`
-   Not the Windows file system root directory: `/mnt/c/Users/<user name>/Project$` or `C:\Users\<user name>\Project`

When you see `/mnt/` in the file path of a WSL command line, it means that you are working from a mounted drive. So the Windows file system C:\\ drive (`C:\Users\<user name>\Project`) will look like this when mounted in a WSL command line: `/mnt/c/Users/<user name>/Project$`. It is possible to store your project files on a mounted drive, but your performance speed will improve if you store them directly on the `\\wsl$` drive.

## View your current directory in Windows File Explorer

You can view the directory where your files are stored by opening the Windows File Explorer from the command line, using:

```
<span>explorer.exe .
</span>
```

Alternatively, you can also use the command: `powershell.exe /c start .` Be sure to add the period at the end of the command to open the current directory.

To view all of your available Linux distributions and their root file systems in Windows File explorer, in the address bar enter: `\\wsl$`

![View project files in Windows File Explorer](https://learn.microsoft.com/en-us/windows/wsl/media/windows-file-explorer.png)

## Filename and directory case sensitivity

Case sensitivity determines whether uppercase (FOO.txt) and lowercase (foo.txt) letters are handled as distinct (case-sensitive) or equivalent (case-insensitive) in a file name or directory. Windows and Linux file systems handle case sensitivity in different ways - Windows is case-insensitive and Linux is case-sensitive. Learn more about how to adjust case sensitivity, particularly when mounting disks with WSL, in the [Adjust case sensitivity](https://learn.microsoft.com/en-us/windows/wsl/case-sensitivity) how-to article.

## Interoperability between Windows and Linux commands

Windows and Linux tools and commands can be used interchangeably with WSL.

-   Run Windows tools (ie. notepad.exe) from a Linux command line (ie. Ubuntu).
-   Run Linux tools (ie. grep) from a Windows command line (ie. PowerShell).
-   Share environment variables between Linux and Windows. (Build 17063+)

Run Linux binaries from the Windows Command Prompt (CMD) or PowerShell using `wsl <command>` (or `wsl.exe <command>`).

For example:

```
<span>C:\temp&gt; wsl ls<span> -la</span>
&lt;- contents of C:\temp -&gt;
</span>
```

Binaries invoked in this way:

-   Use the same working directory as the current CMD or PowerShell prompt.
-   Run as the WSL default user.
-   Have the same Windows administrative rights as the calling process and terminal.

The Linux command following `wsl` (or `wsl.exe`) is handled like any command run in WSL. Things such as sudo, piping, and file redirection work.

Example using sudo to update your default Linux distribution:

```
<span>C:\temp&gt; wsl sudo <span>apt-get</span> update
</span>
```

Your default Linux distribution user name will be listed after running this command and you will be asked for your password. After entering your password correctly, your distribution will download updates.

## Mixing Linux and Windows commands

Here are a few examples of mixing Linux and Windows commands using PowerShell.

To use the Linux command `ls -la` to list files and the PowerShell command `findstr` to filter the results for words containing "git", combine the commands:

```
<span>wsl ls<span> -la</span> | findstr <span>"git"</span>
</span>
```

To use the PowerShell command `dir` to list files and the Linux command `grep` to filter the results for words containing "git", combine the commands:

```
<span>C:\temp&gt; dir | wsl grep git
</span>
```

To use the Linux command `ls -la` to list files and the PowerShell command `> out.txt` to print that list to a text file named "out.txt", combine the commands:

```
<span>C:\temp&gt; wsl ls<span> -la</span> &gt; out.txt
</span>
```

The commands passed into `wsl.exe` are forwarded to the WSL process without modification. File paths must be specified in the WSL format.

To use the Linux command `ls -la` to list files in the `/proc/cpuinfo` Linux file system path, using PowerShell:

```
<span>C:\temp&gt; wsl ls<span> -la</span> /proc/cpuinfo
</span>
```

To use the Linux command `ls -la` to list files in the `C:\Program Files` Windows file system path, using PowerShell:

```
<span>C:\temp&gt; wsl ls<span> -la</span> <span>"/mnt/c/Program Files"</span>
</span>
```

WSL can run Windows tools directly from the WSL command line using `[tool-name].exe`. For example, `notepad.exe`.

Applications run this way have the following properties:

-   Retain the working directory as the WSL command prompt (for the most part -- exceptions are explained below).
-   Have the same permission rights as the WSL process.
-   Run as the active Windows user.
-   Appear in the Windows Task Manager as if directly executed from the CMD prompt.

Windows executables run in WSL are handled similarly to native Linux executables -- piping, redirects, and even backgrounding work as expected.

To run the Windows tool `ipconfig.exe`, use the Linux tool `grep` to filter the "IPv4" results, and use the Linux tool `cut` to remove the column fields, from a Linux distribution (for example, Ubuntu) enter:

```
<span>ipconfig.exe | grep IPv4 | cut -d: -f2
</span>
```

Let's try an example mixing Windows and Linux commands. Open your Linux distribution (ie. Ubuntu) and create a text file: `touch foo.txt`. Now use the Linux command `ls -la` to list the direct files and their creation details, plus the Windows PowerShell tool `findstr.exe` to filter the results so only your `foo.txt` file shows in the results:

```
<span><span>ls</span> -la | findstr.exe foo.txt
</span>
```

Windows tools must include the file extension, match the file case, and be executable. Non-executables including batch scripts. CMD native commands like `dir` can be run with `cmd.exe /C` command.

For example, list the contents of your Windows files system C:\\ directory, by entering:

```
<span>cmd.exe /C dir
</span>
```

Or use the `ping` command to send an echo request to the microsoft.com website:

```
<span>ping.exe www.microsoft.com
</span>
```

Parameters are passed to the Windows binary unmodified. As an example, the following command will open `C:\temp\foo.txt` in `notepad.exe`:

```
<span>notepad.exe <span>"C:\temp\foo.txt"</span>
</span>
```

This will also work:

```
<span>notepad.exe C:\\temp\\foo.txt
</span>
```

WSL and Windows share a special environment variable, `WSLENV`, created to bridge Windows and Linux distributions running on WSL.

Properties of `WSLENV` variable:

-   It is shared; it exists in both Windows and WSL environments.
-   It is a list of environment variables to share between Windows and WSL.
-   It can format environment variables to work well in Windows and WSL.
-   It can assist in the flow between WSL and Win32.

Note

Prior to 17063, only Windows environment variable that WSL could access was `PATH` (so you could launch Win32 executables from under WSL). Starting in 17063, `WSLENV` begins being supported. WSLENV is case sensitive.

## WSLENV flags

There are four flags available in `WSLENV` to influence how the environment variable is translated.

`WSLENV` flags:

-   `/p` - translates the path between WSL/Linux style paths and Win32 paths.
-   `/l` - indicates the environment variable is a list of paths.
-   `/u` - indicates that this environment variable should only be included when running WSL from Win32.
-   `/w` - indicates that this environment variable should only be included when running Win32 from WSL.

Flags can be combined as needed.

[Read more about WSLENV](https://devblogs.microsoft.com/commandline/share-environment-vars-between-wsl-and-windows/), including FAQs and examples of setting the value of WSLENV to a concatenation of other pre-defined environment vars, each suffixed with a slash followed by flags to specify how the value should be translated and passing variables with a script. This article also includes an example for setting up a dev environment with the [Go programming language](https://golang.org/), configured to share a GOPATH between WSL and Win32.

## Disable interoperability

Users may disable the ability to run Windows tools for a single WSL session by running the following command as root:

```
<span><span>echo</span> 0 &gt; /proc/sys/fs/binfmt_misc/WSLInterop
</span>
```

To re-enable Windows binaries, exit all WSL sessions and re-run bash.exe or run the following command as root:

```
<span><span>echo</span> 1 &gt; /proc/sys/fs/binfmt_misc/WSLInterop
</span>
```

Disabling interop will not persist between WSL sessions -- interop will be enabled again when a new session is launched.


\--------------------------------------------------------------------------------

## WSL container  Microsoft Learn.md

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


