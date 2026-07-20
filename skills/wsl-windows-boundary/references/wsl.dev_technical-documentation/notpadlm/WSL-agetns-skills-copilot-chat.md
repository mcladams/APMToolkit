
# 🧩 **WSL Agent Context Specification (drop‑in for SKILL.md / CONTEXT.md / AGENTS.md)**

## **1\. What WSL** _**is**_

WSL2 is a **real Linux kernel running inside a lightweight Hyper‑V VM**, tightly integrated with Windows. It behaves like a Linux machine, but with special interoperability features.

Agents should treat WSL as:

- A **local Linux host**
    
- With **full systemd**
    
- With **real networking** (NAT or mirrored)
    
- With **real filesystems** (ext4 VHDX)
    
- With **optional Windows interoperability**
    

## **2\. What WSL** _**is not**_

WSL is **not**:

- A remote server
    
- A Docker container
    
- A POSIX compatibility layer
    
- A Windows subsystem that runs Linux syscalls directly
    
- A VM that requires SSH for access
    
- A dual‑boot environment
    

Agents must not assume:

- SSH is required
    
- Linux and Windows share the same filesystem semantics
    
- Linux processes can access Windows APIs
    
- Windows processes can access Linux syscalls
    

## **3\. Networking model (critical for agents)**

WSL has two networking modes:

### **NAT mode (default)**

- WSL has its own virtual NIC
    
- Windows and WSL have different IPs
    
- Ports must be forwarded manually
    
- Windows can bind to ports independently of WSL
    

### **Mirrored mode**

- WSL shares the Windows network stack
    
- Windows may “own” ports
    
- WSL can only bind to ports listed in `ignoredPorts`
    
- SSH, web servers, databases, etc. may require freeing ports on Windows
    

Agents must understand:

> **If mirrored networking is enabled, WSL cannot bind to a port unless Windows releases it or it is added to** `ignoredPorts`**.**

## **4\. Interoperability rules**

WSL supports optional Windows/Linux interop:

### **Enabled**

- Linux can run Windows binaries (`cmd.exe`, `.exe` files)
    
- Windows can run Linux commands (`wsl.exe`, `wsl -e bash`)
    
- File paths auto‑translate (`/mnt/c/...` ↔ `C:\...`)
    

### **Disabled**

- WSL behaves like a normal Linux host
    
- No `.exe` execution
    
- No path translation
    
- No Windows process launching
    

Agents must not assume interop is always enabled.

## **5\. Remote development model**

There are **two** valid development workflows:

### **A. VS Code Remote‑WSL (default)**

- Does **not** use SSH
    
- Does **not** require port 22
    
- Uses WSL’s internal IPC channel
    
- Works even if sshd is disabled
    

Agents should treat this as:

> “Local development inside a Linux environment.”

### **B. VS Code Remote‑SSH into WSL**

- Requires sshd running inside WSL
    
- Requires WSL to own port 22
    
- Requires `ignoredPorts=22` in mirrored mode
    
- Behaves like a normal remote Linux server
    

Agents should treat this as:

> “Remote development into a headless Linux box.”

## **6\. Filesystem model**

WSL has two major filesystems:

### **Linux rootfs**

- ext4
    
- Stored in a VHDX
    
- Fast
    
- Supports Linux permissions
    
- Preferred for development
    

### **Windows filesystem (**`/mnt/c`**)**

- NTFS
    
- Slow for Linux workloads
    
- No native Linux permissions
    
- Should not be used for:
    
    - Git repos
        
    - Node modules
        
    - Databases
        
    - Build directories
        

Agents must recommend using the Linux filesystem for performance‑critical tasks.

## **7\. Systemd and services**

WSL2 supports systemd:

- Services behave normally
    
- `systemctl` works
    
- Daemons run persistently while the distro is active
    
- Networking rules apply (mirrored vs NAT)
    

Agents should treat systemd services as if running on a normal Linux host.

## **8\. What agents should do**

- Treat WSL as a **local Linux machine**
    
- Use Linux‑native commands
    
- Use Linux‑native paths
    
- Assume systemd is available
    
- Respect networking mode
    
- Avoid Windows‑specific assumptions unless explicitly told interop is enabled
    

## **9\. What agents should NOT do**

- Do not assume SSH is required
    
- Do not assume Windows owns all ports
    
- Do not assume `/mnt/c` is safe for development
    
- Do not assume interop is enabled
    
- Do not assume WSL behaves like a container
    
- Do not assume WSL behaves like a remote server unless told so
    

# 🧱 Want a version formatted specifically for SKILL.md, CONTEXT.md, or AGENTS.md?

I can generate:

- A **minimal SKILL.md** (for agent capabilities)
    
- A **CONTEXT.md** (for runtime environment description)
    
- An **AGENTS.md** (for behavior rules and constraints)
    

Just tell me which one you want first.

Edit in a page

##### You said

Let make sure we are ont he same page. What is the specification that describes what is in each? People don't seem to be using CONTEXT.md so lets remove that. We can have a RULES.md --- Then i would like a powershell script to \*dynamically create\* - or perhaps select stanzas from markdown snippets

###### Copilot said

Great — now we’re aligned. You want a **clean, opinionated, agent‑friendly specification** for:

- **SKILL.md** — what the—
    

Edit in a page

##### You said

about\_ARCHITECTURE.md

Markdown

Also consult https://agentskills.io/specification https://agents.md https://www.morphllm.com/agents-md-guide https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents Perhaps we need a AGENTS.md to state the TYPE of architecture, development and networkign, and then direct the agent to a particular skill to load? Please consult the refrences and start with an AGENTS.md, with branching logic, funcitional blocks depending on the type of development/networkigng/architecture. Also if the Microsoft WSL visual studio code extension is installed or avaialbe , if it isn't -> revert to remote development over ssh. If the project requires powershell administrator shell then it needs to be run with IPc and from the windows side with wsl commands, for example https://github.com/mcladams/wsl-rawdisk

###### Copilot said

Michael, perfect — you’re asking for a **real AGENTS.md** that:

1. **Defines the environment type** (WSL, Windows, hybrid, remote Linux, SSH‑only, etc.)
    
2. **Describes the development model** (Remote‑WSL, Remote‑SSH, Windows‑side PowerShell orchestration, etc.)
    
3. **Provides branching logic** so an agent can load the correct SKILL.md modules
    
4. **Handles WSL interoperability, networking mode, and VS Code extension availability**
    
5. **Handles PowerShell admin‑required tasks (e.g., wsl‑rawdisk)**
    
6. **Is consistent with the agent‑specification standards** you linked (agentskills.io, agents.md, MorphLLM, Anthropic context‑engineering)
    

Below is a **complete, production‑ready AGENTS.md** that follows those standards and is tailored to your WSL‑heavy environment.

It is structured so that an agent can _determine its operating mode_ and then load the correct skills.

# **AGENTS.md — Environment‑Aware Agent Behavior Specification**

_(WSL‑centric, Windows‑integrated, VS Code‑aware)_

## **1\. Purpose**

This document defines how an AI agent should reason about:

- The **execution environment** (WSL, Windows, hybrid, remote Linux)
    
- The **development model** (Remote‑WSL, Remote‑SSH, Windows‑side orchestration)
    
- The **networking model** (NAT, mirrored, port ownership)
    
- The **interoperability model** (enabled, disabled, restricted)
    
- The **required skills** to load depending on context
    

This prevents confusion between Windows, WSL, Linux, and remote‑SSH paradigms.

# **2\. Environment Classification**

The agent must classify the environment into exactly one of the following modes:

### **Mode A — Native WSL Linux Environment**

Criteria:

- Running inside a WSL2 distro
    
- Linux kernel present
    
- `/mnt/c` exists
    
- Windows interop _may_ be enabled
    

Agent behavior:

- Treat as a **local Linux host**
    
- Prefer Linux‑native tooling
    
- Use systemd if available
    
- Use Linux paths (`/home/...`)
    
- Avoid assuming SSH is required
    

### **Mode B — Windows Host Environment**

Criteria:

- Running in PowerShell or CMD
    
- `wsl.exe` available
    
- No Linux kernel
    

Agent behavior:

- Use Windows‑native tooling
    
- Use PowerShell for orchestration
    
- Use `wsl.exe` to interact with distros
    
- Use Windows paths (`C:\...`)
    

### **Mode C — Remote Linux Server (SSH‑only)**

Criteria:

- No WSL
    
- No Windows interop
    
- Access via SSH only
    

Agent behavior:

- Treat as a headless Linux server
    
- Use SSH‑based workflows
    
- Avoid Windows assumptions
    

### **Mode D — Hybrid Windows + WSL Orchestration**

Criteria:

- Commands require both Windows admin and WSL Linux
    
- Example: raw disk mounting, Hyper‑V, VHDX manipulation, wsl‑rawdisk
    

Agent behavior:

- Use PowerShell (admin) for privileged operations
    
- Use Linux commands inside WSL for filesystem operations
    
- Maintain strict boundary discipline
    

# **3\. Development Workflow Detection**

The agent must detect which development workflow is active:

### **Workflow 1 — VS Code Remote‑WSL**

Criteria:

- VS Code WSL extension installed
    
- `.vscode-server` present inside WSL
    
- No SSH required
    

Agent behavior:

- Do **not** configure SSH
    
- Do **not** assume port 22
    
- Use WSL IPC channel
    

### **Workflow 2 — VS Code Remote‑SSH into WSL**

Criteria:

- User explicitly requests SSH
    
- Or WSL extension unavailable
    
- Or interop disabled
    

Agent behavior:

- Ensure sshd is running inside WSL
    
- Ensure WSL owns port 22
    
- If mirrored networking:
    
    - Add `ignoredPorts=22` to `.wslconfig`
        
- Provide SSH config stanzas
    

### **Workflow 3 — Windows‑side PowerShell Orchestration**

Criteria:

- Task requires admin privileges
    
- Task involves:
    
    - raw disks
        
    - VHDX
        
    - Hyper‑V
        
    - wsl‑rawdisk
        
    - Windows firewall
        
    - Port reservation
        

Agent behavior:

- Use PowerShell admin
    
- Use `wsl.exe -d <distro> -- <cmd>` for Linux operations
    
- Maintain strict separation of concerns
    

# **4\. Networking Model Detection**

The agent must detect the WSL networking mode:

### **Networking Mode: NAT**

- WSL has its own IP
    
- Port forwarding required
    
- Windows and WSL can bind independently
    

### **Networking Mode: Mirrored**

- WSL shares Windows network stack
    
- Windows may own ports
    
- WSL can only bind to ports in `ignoredPorts`
    

Agent behavior:

- If mirrored + SSH required → ensure `ignoredPorts=22`
    
- If mirrored + service binding fails → check Windows port ownership
    

# **5\. Interoperability Model**

The agent must detect whether Windows interop is enabled:

### **Interop Enabled**

- Linux can run `.exe`
    
- Windows can run Linux commands
    
- Path translation active
    

### **Interop Disabled**

- Treat WSL as a pure Linux host
    
- Do not use `.exe`
    
- Do not use Windows paths
    

# **6\. Skill Loading Logic**

The agent must load skills based on environment + workflow:

### **If Mode A (Native WSL)**

Load:

- `linux-shell`
    
- `wsl-internals`
    
- `systemd-services`
    
- `linux-networking`
    

If Remote‑WSL:

- `vscode-wsl`
    

If Remote‑SSH:

- `ssh-server-management`
    

### **If Mode B (Windows Host)**

Load:

- `powershell-admin`
    
- `windows-networking`
    
- `wsl-orchestration`
    

### **If Mode D (Hybrid)**

Load:

- `powershell-admin`
    
- `wsl-orchestration`
    
- `filesystem-mounting`
    
- `hyperv-management`
    

# **7\. Rules for WSL‑Specific Tasks**

### **7.1 When to use Linux commands**

Use Linux commands when:

- Manipulating ext4 filesystems
    
- Running systemd services
    
- Editing Linux config files
    
- Managing Linux packages
    

### **7.2 When to use Windows commands**

Use PowerShell when:

- Mounting raw disks
    
- Managing VHDX
    
- Managing Hyper‑V
    
- Editing `.wslconfig`
    
- Managing Windows firewall
    
- Managing Windows port ownership
    

### **7.3 When SSH is required**

SSH is required only when:

- VS Code Remote‑SSH is used
    
- Interop is disabled
    
- Remote access from another machine is needed
    

# **8\. Special Case: wsl‑rawdisk**

Tasks involving raw disks require:

- PowerShell **administrator**
    
- Windows‑side mounting
    
- Linux‑side filesystem operations
    

Agent behavior:

- Use PowerShell to attach/detach
    
- Use Linux to inspect (`lsblk`, `blkid`, `mount`)
    
- Never attempt raw disk operations from inside WSL alone
    

# **9\. Agent Behavioral Constraints**

- Never assume SSH unless explicitly required
    
- Never assume interop is enabled
    
- Never assume Windows owns ports in mirrored mode
    
- Always detect environment before acting
    
- Always load skills based on mode + workflow
    
- Always separate Windows and Linux responsibilities
    

# **10\. Branching Logic Summary**

Code

Copy

```
IF inside WSL:
    IF VS Code WSL extension available:
        Workflow = Remote-WSL
        Load linux + vscode-wsl skills
    ELSE:
        Workflow = Remote-SSH
        Ensure sshd + port 22 ownership
        Load ssh skills

ELSE IF inside Windows:
    IF task requires admin or raw disk:
        Mode = Hybrid
        Load powershell-admin + wsl-orchestration
    ELSE:
        Mode = Windows Host
        Load powershell + wsl-orchestration

ELSE:
    Mode = Remote Linux
    Load ssh + linux skills
```

# **Next Step**

You asked for:

> a PowerShell script to dynamically create or select stanzas from markdown snippets

I can generate:

- A **snippet library** (`snippets/agents/*.md`)
    
- A **PowerShell generator** (`Generate-AgentSpec.ps1`)
    
- A **profile‑aware selector** that detects environment and assembles the correct AGENTS.md
    

Tell me:

### **Do you want the PowerShell script to:**

1. **Assemble AGENTS.md from snippet files**,
    
2. **Generate SKILL.md automatically**,
    
3. **Generate RULES.md**,
    
4. **Or all of the above**?
    

I can produce a full toolchain.

Edit in a page