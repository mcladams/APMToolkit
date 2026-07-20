---
name: wsl-windows-boundary
description: Reasoning aid for any task that touches the boundary between Windows and WSL2 — networking mode (NAT vs mirrored), interop (exe execution, path translation), which side owns a port, VS Code Remote-WSL vs Remote-SSH, or tasks needing Windows admin privileges alongside Linux filesystem operations (raw disk, VHDX, Hyper-V, wsl-rawdisk). Use this whenever a task could plausibly run from either side of the WSL boundary, before assuming SSH is needed, before assuming a port is free, or before writing PowerShell vs bash for a given step.
---

# WSL / Windows Boundary Reasoning

This is a reference and a set of checks, not a router. Nothing in here executes on its own —
run the checks below, then use the judgment calls that follow. Don't paste the "detection"
section as if it were logic the model will interpret; it's a list of commands to actually run.

## What WSL2 is / is not

A real Linux kernel in a lightweight Hyper-V VM with optional Windows interop. It is not: a
container, a POSIX-compat layer, a remote server, a dual-boot environment. Do not assume SSH is
required, that Windows and Linux share filesystem semantics, or that either side can call the
other's syscalls directly — all of that is interop, and interop is configurable, not guaranteed.

## Checks to actually run (don't assume — run these)

From inside WSL:
```bash
grep -qi microsoft /proc/version && echo "running inside WSL"
cat /etc/wsl.conf 2>/dev/null          # interop / boot settings for this distro
cat /mnt/c/Users/$USER/.wslconfig 2>/dev/null  # global settings incl. networkingMode, ignoredPorts
findmnt /mnt/c >/dev/null 2>&1 && echo "Windows drives mounted"
pgrep -f vscode-server >/dev/null && echo "VS Code server present (Remote-WSL likely in use)"
systemctl is-system-running 2>/dev/null  # confirms systemd is actually up, not just configured
```

From PowerShell (Windows side):
```powershell
wsl --list --verbose            # distros, version, running state
wsl --status                    # default distro, kernel version, networking mode
Get-NetTCPConnection -State Listen | Where LocalPort -eq 22   # who owns port 22 right now
```

Networking mode and `ignoredPorts` come from `.wslconfig`, not from guessing. Read the file.
Do not tell the user "WSL probably owns port X" — check `Get-NetTCPConnection` or `ss -tlnp`
on whichever side is relevant.

## Judgment calls (prose, not pseudocode)

**Filesystem**: put anything performance-sensitive (git repos, node_modules, databases, build
dirs) on the Linux ext4 side. `/mnt/c` is NTFS-over-9P and slow for these workloads regardless
of networking mode — this one's independent of everything else in this file.

**Networking mode**: mirrored means WSL shares the Windows network stack and can only bind
ports Windows has released into `ignoredPorts`; NAT means WSL has its own IP and needs explicit
port forwarding. If a service fails to bind and mode is mirrored, the fix is on the Windows side
(`ignoredPorts` in `.wslconfig` or freeing the port), not in WSL.

**Remote development**: if `.vscode-server` is present inside the distro, the user is on
Remote-WSL — no SSH, no port 22, it rides an internal IPC channel. Don't set up sshd for a
Remote-WSL session; that's solving a problem that doesn't exist. Only reach for sshd + port 22
ownership when Remote-SSH is explicitly wanted, the WSL extension isn't available, or a genuinely
separate machine needs access.

**Interop**: check `/etc/wsl.conf` for `[interop] enabled=`. If disabled or absent-and-defaulted,
don't write `.exe` calls or assume path translation — treat it as a plain Linux host.

**Admin/hybrid tasks** (raw disk mounting, VHDX, Hyper-V, `wsl-rawdisk`-style operations): these
need PowerShell running as administrator on the Windows side for attach/detach, then Linux-side
tools (`lsblk`, `blkid`, `mount`) to inspect once attached. Don't attempt raw disk operations
from inside WSL alone — the privilege boundary is real, not a formality.

## What this replaces

Earlier drafts of this material used an AGENTS.md-style branching block (`IF inside WSL...
ELSE IF...`) to try to encode this reasoning as executable logic. That's the wrong file for it:
AGENTS.md is a static per-project reference (build commands, conventions, this-project's-actual
environment), not a place to hand-write a dispatcher. This skill is what should carry the
reusable judgment; a project's AGENTS.md should instead just state facts once — e.g. "this repo
runs on Windows host + WSL2, mirrored networking, Remote-WSL, admin PowerShell needed for the
disk-mount step" — no conditionals, no per-session detection, just the settled answer for that repo.
