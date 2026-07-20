\--------------------------------------------------------------------------------

- title: WSL container API C reference - WSL
- url: https://wsl.dev/api-reference/c/
- date: 2026-07-15T19:09:52.294Z
- parsing method: defuddle

[Skip to content](#wsl-container-api-c-reference)

# WSL container API C reference

The WSL container API exposes a C API for creating sessions, creating containers inside those sessions, starting processes, managing images, managing VHD-backed storage, and checking/installing required platform components.

**Header:**`wslcsdk.h`

**Library:**`wslcsdk.lib` / `wslcsdk.dll`

**PREVIEW NOTICE:** This API is currently in preview and is subject to breaking changes in future releases without prior notice. Do not rely on API stability for production workloads. Features, function signatures, and behaviors may change between releases during the preview period.

\--------------------------------------------------------------------------------

In this reference

- [Structures](structures/)- [Callback Types](callback-types/)- [Session APIs](session-apis/)- [Container APIs](container-apis/)- [Process APIs](process-apis/)- [Image APIs](image-apis/)- [Storage APIs](storage-apis/)- [Install and Version APIs](install-and-version-apis/)- [Enumerations](enumerations/)- [Error Codes](error-codes/)- [Not Yet Implemented APIs](not-yet-implemented-apis/)- [End-to-End Example](end-to-end-example/)

\--------------------------------------------------------------------------------

- title: Structures - WSL
- url: https://wsl.dev/api-reference/c/structures/
- date: 2026-07-15T19:09:52.294Z
- parsing method: defuddle

[Skip to content](#structures)

Structures

Members

- [Handle Types](handle-types/)- [Constants](constants/)- [WslcSessionSettings](wslcsessionsettings/)- [WslcContainerSettings](wslccontainersettings/)- [WslcProcessSettings](wslcprocesssettings/)- [WslcVhdRequirements](wslcvhdrequirements/)- [WslcSessionCrashDumpInfo](wslcsessioncrashdumpinfo/)- [WslcContainerPortMapping](wslccontainerportmapping/)- [WslcContainerVolume](wslccontainervolume/)- [WslcContainerNamedVolume](wslccontainernamedvolume/)- [WslcProcessCallbacks](wslcprocesscallbacks/)- [WslcImageProgressDetail](wslcimageprogressdetail/)- [WslcImageProgressMessage](wslcimageprogressmessage/)- [WslcPullImageOptions](wslcpullimageoptions/)- [WslcImportImageOptions](wslcimportimageoptions/)- [WslcLoadImageOptions](wslcloadimageoptions/)- [WslcImageInfo](wslcimageinfo/)- [WslcTagImageOptions](wslctagimageoptions/)- [WslcPushImageOptions](wslcpushimageoptions/)- [WslcVersion](wslcversion/)

\--------------------------------------------------------------------------------

- title: Handle Types - WSL
- url: https://wsl.dev/api-reference/c/structures/handle-types/
- date: 2026-07-15T19:09:52.294Z
- parsing method: defuddle

[Skip to content](#handle-types)

Handle Types

The header declares these opaque handles:

\--------------------------------------------------------------------------------

- title: Constants - WSL
- url: https://wsl.dev/api-reference/c/structures/constants/
- date: 2026-07-15T19:09:52.294Z
- parsing method: defuddle

[Skip to content](#constants)

Constants

```
#define WSLC_SESSION_OPTIONS_SIZE 72
#define WSLC_SESSION_OPTIONS_ALIGNMENT 8
#define WSLC_CONTAINER_OPTIONS_SIZE 104
#define WSLC_CONTAINER_OPTIONS_ALIGNMENT 8
#define WSLC_CONTAINER_PROCESS_OPTIONS_SIZE 72
#define WSLC_CONTAINER_PROCESS_OPTIONS_ALIGNMENT 8
#define WSLC_CONTAINER_ID_BUFFER_SIZE 65
#define WSLC_IMAGE_NAME_LENGTH 256
```

| Constant |  Value |
| --- | --- |
| WSLC\_SESSION\_OPTIONS\_SIZE |  72 |
| WSLC\_SESSION\_OPTIONS\_ALIGNMENT |  8 |
| WSLC\_CONTAINER\_OPTIONS\_SIZE |  104 |
| WSLC\_CONTAINER\_OPTIONS\_ALIGNMENT |  8 |
| WSLC\_CONTAINER\_PROCESS\_OPTIONS\_SIZE |  72 |
| WSLC\_CONTAINER\_PROCESS\_OPTIONS\_ALIGNMENT |  8 |
| WSLC\_CONTAINER\_ID\_BUFFER\_SIZE |  65 |
| WSLC\_IMAGE\_NAME\_LENGTH |  256 |

\--------------------------------------------------------------------------------

- title: WslcSessionSettings - WSL
- url: https://wsl.dev/api-reference/c/structures/wslcsessionsettings/
- date: 2026-07-15T19:09:52.294Z
- parsing method: defuddle

[Skip to content](#wslcsessionsettings)

WslcSessionSettings

```
typedef struct WslcSessionSettings
{
    __declspec(align(WSLC_SESSION_OPTIONS_ALIGNMENT)) BYTE _opaque[WSLC_SESSION_OPTIONS_SIZE];
} WslcSessionSettings;
```

\--------------------------------------------------------------------------------

- title: WslcContainerSettings - WSL
- url: https://wsl.dev/api-reference/c/structures/wslccontainersettings/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslccontainersettings)

WslcContainerSettings

```
typedef struct WslcContainerSettings
{
    __declspec(align(WSLC_CONTAINER_OPTIONS_ALIGNMENT)) BYTE _opaque[WSLC_CONTAINER_OPTIONS_SIZE];
} WslcContainerSettings;
```

\--------------------------------------------------------------------------------

- title: WslcProcessSettings - WSL
- url: https://wsl.dev/api-reference/c/structures/wslcprocesssettings/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcprocesssettings)

WslcProcessSettings

```
typedef struct WslcProcessSettings
{
    __declspec(align(WSLC_CONTAINER_PROCESS_OPTIONS_ALIGNMENT)) BYTE _opaque[WSLC_CONTAINER_PROCESS_OPTIONS_SIZE];
} WslcProcessSettings;
```

\--------------------------------------------------------------------------------

- title: WslcVhdRequirements - WSL
- url: https://wsl.dev/api-reference/c/structures/wslcvhdrequirements/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcvhdrequirements)

WslcVhdRequirements

```
typedef struct WslcVhdRequirements
{
    _In_z_ PCSTR name;
    _In_ uint64_t sizeBytes; // Desired size (for create/expand)
    _In_ WslcVhdType type;
    _In_ WslcVhdRequirementsFlags flags;
    _In_ uint32_t uid; // honored iff (flags & WSLC_VHD_REQ_FLAG_OWNER)
    _In_ uint32_t gid; // honored iff (flags & WSLC_VHD_REQ_FLAG_OWNER)
} WslcVhdRequirements;
```

| Field |  Type |
| --- | --- |
| name |  PCSTR |
| sizeBytes |  uint64\_t |
| type |  WslcVhdType |
| flags |  WslcVhdRequirementsFlags |
| uid |  uint32\_t |
| gid |  uint32\_t |

Header notes:

- `name` is ignored by `WslcSetSessionSettingsVhd`.- The remaining fields after `type` are only honored by `WslcCreateSessionVhdVolume`.- `WslcSetSessionSettingsVhd` rejects non- `NONE` flags with `E_INVALIDARG`.

\--------------------------------------------------------------------------------

- title: WslcSessionCrashDumpInfo - WSL
- url: https://wsl.dev/api-reference/c/structures/wslcsessioncrashdumpinfo/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsessioncrashdumpinfo)

WslcSessionCrashDumpInfo

```
typedef struct WslcSessionCrashDumpInfo
{
    _Field_z_ PCWSTR dumpPath;
    _Field_z_ PCSTR processName;
    uint32_t pid;
    uint32_t signal;
    uint64_t timestamp;
} WslcSessionCrashDumpInfo;
```

| Field |  Type |
| --- | --- |
| dumpPath |  PCWSTR |
| processName |  PCSTR |
| pid |  uint32\_t |
| signal |  uint32\_t |
| timestamp |  uint64\_t |

\--------------------------------------------------------------------------------

- title: WslcContainerPortMapping - WSL
- url: https://wsl.dev/api-reference/c/structures/wslccontainerportmapping/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslccontainerportmapping)

WslcContainerPortMapping

```
typedef struct WslcContainerPortMapping
{
    _In_ uint16_t windowsPort;      // Port on Windows host
    _In_ uint16_t containerPort;    // Port inside container
    _In_ WslcPortProtocol protocol; // TCP or UDP

    // if you want to override the default binding address
    _In_opt_ struct sockaddr_storage* windowsAddress; // accepts ipv4/6
} WslcContainerPortMapping;
```

| Field |  Type |
| --- | --- |
| windowsPort |  uint16\_t |
| containerPort |  uint16\_t |
| protocol |  WslcPortProtocol |
| windowsAddress |  struct sockaddr\_storage\* |

\--------------------------------------------------------------------------------

- title: WslcContainerVolume - WSL
- url: https://wsl.dev/api-reference/c/structures/wslccontainervolume/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslccontainervolume)

WslcContainerVolume

```
typedef struct WslcContainerVolume
{
    _In_z_ PCWSTR windowsPath;
    _In_z_ PCSTR containerPath;
    _In_ BOOL readOnly;
} WslcContainerVolume;
```

| Field |  Type |
| --- | --- |
| windowsPath |  PCWSTR |
| containerPath |  PCSTR |
| readOnly |  BOOL |

\--------------------------------------------------------------------------------

- title: WslcContainerNamedVolume - WSL
- url: https://wsl.dev/api-reference/c/structures/wslccontainernamedvolume/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslccontainernamedvolume)

WslcContainerNamedVolume

```
typedef struct WslcContainerNamedVolume
{
    _In_z_ PCSTR name;          // Name of the session volume (from WslcVhdRequirements.name)
    _In_z_ PCSTR containerPath; // Absolute path inside the container
    _In_ BOOL readOnly;
} WslcContainerNamedVolume;
```

| Field |  Type |
| --- | --- |
| name |  PCSTR |
| containerPath |  PCSTR |
| readOnly |  BOOL |

\--------------------------------------------------------------------------------

- title: WslcProcessCallbacks - WSL
- url: https://wsl.dev/api-reference/c/structures/wslcprocesscallbacks/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcprocesscallbacks)

WslcProcessCallbacks

```
typedef struct WslcProcessCallbacks
{
    WslcStdIOCallback onStdOut;
    WslcStdIOCallback onStdErr;
    WslcProcessExitCallback onExit;
} WslcProcessCallbacks;
```

| Field |  Type |
| --- | --- |
| onStdOut |  WslcStdIOCallback |
| onStdErr |  WslcStdIOCallback |
| onExit |  WslcProcessExitCallback |

\--------------------------------------------------------------------------------

- title: WslcImageProgressDetail - WSL
- url: https://wsl.dev/api-reference/c/structures/wslcimageprogressdetail/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcimageprogressdetail)

WslcImageProgressDetail

```
typedef struct WslcImageProgressDetail
{
    _Out_ uint64_t currentBytes; // bytes downloaded so far
    _Out_ uint64_t totalBytes;   // total bytes expected
} WslcImageProgressDetail;
```

| Field |  Type |
| --- | --- |
| currentBytes |  uint64\_t |
| totalBytes |  uint64\_t |

\--------------------------------------------------------------------------------

- title: WslcImageProgressMessage - WSL
- url: https://wsl.dev/api-reference/c/structures/wslcimageprogressmessage/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcimageprogressmessage)

WslcImageProgressMessage

```
typedef struct WslcImageProgressMessage
{
    _Out_ PCSTR id;                       // layer ID or digest
    _Out_ WslcImageProgressStatus status; // "Downloading", "Extracting", etc.
    _Out_ WslcImageProgressDetail detail;
} WslcImageProgressMessage;
```

| Field |  Type |
| --- | --- |
| id |  PCSTR |
| status |  WslcImageProgressStatus |
| detail |  WslcImageProgressDetail |

\--------------------------------------------------------------------------------

- title: WslcPullImageOptions - WSL
- url: https://wsl.dev/api-reference/c/structures/wslcpullimageoptions/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcpullimageoptions)

WslcPullImageOptions

```
typedef struct WslcPullImageOptions
{
    _In_z_ PCSTR uri;
    WslcContainerImageProgressCallback progressCallback;
    PVOID progressCallbackContext;
    _In_opt_z_ PCSTR registryAuth;
} WslcPullImageOptions;
```

| Field |  Type |
| --- | --- |
| uri |  PCSTR |
| progressCallback |  WslcContainerImageProgressCallback |
| progressCallbackContext |  PVOID |
| registryAuth |  PCSTR |

\--------------------------------------------------------------------------------

- title: WslcImportImageOptions - WSL
- url: https://wsl.dev/api-reference/c/structures/wslcimportimageoptions/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcimportimageoptions)

WslcImportImageOptions

```
typedef struct WslcImportImageOptions
{
    _In_opt_ WslcContainerImageProgressCallback progressCallback;
    _In_opt_ PVOID progressCallbackContext;
} WslcImportImageOptions;
```

| Field |  Type |
| --- | --- |
| progressCallback |  WslcContainerImageProgressCallback |
| progressCallbackContext |  PVOID |

\--------------------------------------------------------------------------------

- title: WslcLoadImageOptions - WSL
- url: https://wsl.dev/api-reference/c/structures/wslcloadimageoptions/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcloadimageoptions)

WslcLoadImageOptions

```
typedef struct WslcLoadImageOptions
{
    _In_opt_ WslcContainerImageProgressCallback progressCallback;
    _In_opt_ PVOID progressCallbackContext;
} WslcLoadImageOptions;
```

| Field |  Type |
| --- | --- |
| progressCallback |  WslcContainerImageProgressCallback |
| progressCallbackContext |  PVOID |

\--------------------------------------------------------------------------------

- title: WslcImageInfo - WSL
- url: https://wsl.dev/api-reference/c/structures/wslcimageinfo/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcimageinfo)

WslcImageInfo

```
typedef struct WslcImageInfo
{
    CHAR name[WSLC_IMAGE_NAME_LENGTH];
    uint8_t sha256[32];
    int64_t sizeBytes;
    uint64_t createdUnixTime;
} WslcImageInfo;
```

| Field |  Type |
| --- | --- |
| name |  CHARWSLC\_IMAGE\_NAME\_LENGTH |
| sha256 |  uint8\_t32 |
| sizeBytes |  int64\_t |
| createdUnixTime |  uint64\_t |

\--------------------------------------------------------------------------------

- title: WslcTagImageOptions - WSL
- url: https://wsl.dev/api-reference/c/structures/wslctagimageoptions/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslctagimageoptions)

WslcTagImageOptions

```
typedef struct WslcTagImageOptions
{
    _In_z_ PCSTR image; // Source image name or ID.
    _In_z_ PCSTR repo;  // Target repository name.
    _In_z_ PCSTR tag;   // Target tag name.
} WslcTagImageOptions;
```

| Field |  Type |
| --- | --- |
| image |  PCSTR |
| repo |  PCSTR |
| tag |  PCSTR |

\--------------------------------------------------------------------------------

- title: WslcPushImageOptions - WSL
- url: https://wsl.dev/api-reference/c/structures/wslcpushimageoptions/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcpushimageoptions)

WslcPushImageOptions

| Field |  Type |
| --- | --- |
| image |  PCSTR |
| registryAuth |  PCSTR |
| progressCallback |  WslcContainerImageProgressCallback |
| progressCallbackContext |  PVOID |

\--------------------------------------------------------------------------------

- title: WslcVersion - WSL
- url: https://wsl.dev/api-reference/c/structures/wslcversion/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcversion)

WslcVersion

```
typedef struct WslcVersion
{
    uint32_t major;
    uint32_t minor;
    uint32_t revision;
} WslcVersion;
```

| Field |  Type |
| --- | --- |
| major |  uint32\_t |
| minor |  uint32\_t |
| revision |  uint32\_t |

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: Callback Types - WSL
- url: https://wsl.dev/api-reference/c/callback-types/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#callback-types)

Callback Types

Members

- [WslcSessionCrashDumpCallback](wslcsessioncrashdumpcallback/)- [WslcStdIOCallback](wslcstdiocallback/)- [WslcProcessExitCallback](wslcprocessexitcallback/)- [WslcContainerImageProgressCallback](wslccontainerimageprogresscallback/)- [WslcInstallCallback](wslcinstallcallback/)

\--------------------------------------------------------------------------------

- title: WslcSessionCrashDumpCallback - WSL
- url: https://wsl.dev/api-reference/c/callback-types/wslcsessioncrashdumpcallback/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsessioncrashdumpcallback)

WslcSessionCrashDumpCallback

```
typedef __callback void(CALLBACK* WslcSessionCrashDumpCallback)(_In_ const WslcSessionCrashDumpInfo* info, _In_opt_ PVOID context);
```

Parameters:

| Parameter |  Type |
| --- | --- |
| info |  const WslcSessionCrashDumpInfo\* |
| context |  PVOID |

\--------------------------------------------------------------------------------

- title: WslcStdIOCallback - WSL
- url: https://wsl.dev/api-reference/c/callback-types/wslcstdiocallback/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcstdiocallback)

WslcStdIOCallback

```
typedef __callback void(CALLBACK* WslcStdIOCallback)(
    WslcProcessIOHandle ioHandle, _In_reads_bytes_(dataBytes) const BYTE* data, _In_ uint32_t dataBytes, _In_opt_ PVOID context);
```

Header notes:

- Only `STDOUT` and `STDERR` receive callbacks.- `data` is owned by WSLC and is only valid during the callback.- The buffer is not null-terminated.- The callback should return promptly.

\--------------------------------------------------------------------------------

- title: WslcProcessExitCallback - WSL
- url: https://wsl.dev/api-reference/c/callback-types/wslcprocessexitcallback/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcprocessexitcallback)

WslcProcessExitCallback

```
typedef __callback void(CALLBACK* WslcProcessExitCallback)(INT32 exitCode, _In_opt_ PVOID context);
```

| Parameter |  Type |
| --- | --- |
| exitCode |  INT32 |
| context |  PVOID |

\--------------------------------------------------------------------------------

- title: WslcContainerImageProgressCallback - WSL
- url: https://wsl.dev/api-reference/c/callback-types/wslccontainerimageprogresscallback/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslccontainerimageprogresscallback)

WslcContainerImageProgressCallback

```
typedef HRESULT(CALLBACK* WslcContainerImageProgressCallback)(const WslcImageProgressMessage* progress, PVOID context);
```

| Parameter |  Type |
| --- | --- |
| progress |  const WslcImageProgressMessage\* |
| context |  PVOID |

\--------------------------------------------------------------------------------

- title: WslcInstallCallback - WSL
- url: https://wsl.dev/api-reference/c/callback-types/wslcinstallcallback/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcinstallcallback)

WslcInstallCallback

```
typedef __callback void(CALLBACK* WslcInstallCallback)(
    _In_ WslcComponentFlags component, _In_ uint32_t progressSteps, _In_ uint32_t totalSteps, _In_opt_ PVOID context);
```

| Parameter |  Type |
| --- | --- |
| component |  WslcComponentFlags |
| progressSteps |  uint32\_t |
| totalSteps |  uint32\_t |
| context |  PVOID |

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: Session APIs - WSL
- url: https://wsl.dev/api-reference/c/session-apis/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#session-apis)

Session APIs

Members

- [WslcInitSessionSettings](wslcinitsessionsettings/)- [WslcCreateSession](wslccreatesession/)- [WslcSetSessionSettingsCpuCount](wslcsetsessionsettingscpucount/)- [WslcSetSessionSettingsMemory](wslcsetsessionsettingsmemory/)- [WslcSetSessionSettingsTimeout](wslcsetsessionsettingstimeout/)- [WslcSetSessionSettingsVhd](wslcsetsessionsettingsvhd/)- [WslcSetSessionSettingsFeatureFlags](wslcsetsessionsettingsfeatureflags/)- [WslcGetSessionTerminationEvent](wslcgetsessionterminationevent/)- [WslcGetSessionTerminationReason](wslcgetsessionterminationreason/)- [WslcRegisterSessionCrashDumpCallback](wslcregistersessioncrashdumpcallback/)- [WslcReleaseCrashDumpSubscription](wslcreleasecrashdumpsubscription/)- [WslcTerminateSession](wslcterminatesession/)- [WslcReleaseSession](wslcreleasesession/)- [WslcSessionAuthenticate](wslcsessionauthenticate/)

\--------------------------------------------------------------------------------

- title: WslcInitSessionSettings - WSL
- url: https://wsl.dev/api-reference/c/session-apis/wslcinitsessionsettings/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcinitsessionsettings)

WslcInitSessionSettings

```
STDAPI WslcInitSessionSettings(_In_ PCWSTR name, _In_ PCWSTR storagePath, _Out_ WslcSessionSettings* sessionSettings);
```

| Parameter |  Type |  Direction |  Comment |
| --- | --- | --- | --- |
| name |  PCWSTR |  in |  The name of the session to be created. |
| storagePath |  PCWSTR |  in |  Path to where the session storage should be written. If the path doesn't exist, it will be created. |
| sessionSettings |  WslcSessionSettings\* |  out |  Pointer to the WslcSessionSettings to write the settings to. |

Return value: `HRESULT`.

Session names serve both as display names and as machine-wide keys used to identify sessions. If a session with the same name already exists, session creation will fail with `ERROR_ALREADY_EXISTS`.

Also note that the following information about a session is visible to all users on the machine:

- The session's name- The SID of the user that created the session- The PID of the process that created the session

Do not put credentials or other sensitive information in the session's name.

Example:

```
WslcSessionSettings sessionSettings;
HRESULT hr = WslcInitSessionSettings(
    L"demo-session",
    L"C:\\WSLC\\demo-session",
    &sessionSettings);
```

\--------------------------------------------------------------------------------

- title: WslcCreateSession - WSL
- url: https://wsl.dev/api-reference/c/session-apis/wslccreatesession/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslccreatesession)

WslcCreateSession

```
STDAPI WslcCreateSession(_In_ WslcSessionSettings* sessionSettings, _Out_ WslcSession* session, _Outptr_opt_result_z_ PWSTR* errorMessage);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| sessionSettings |  WslcSessionSettings\* |  in |
| session |  WslcSession\* |  out |
| errorMessage |  PWSTR\* |  out, optional |

Return value: `HRESULT`.

Example:

```
WslcSession session = NULL;
HRESULT hr = WslcCreateSession(&sessionSettings, &session, NULL);
```

\--------------------------------------------------------------------------------

- title: WslcSetSessionSettingsCpuCount - WSL
- url: https://wsl.dev/api-reference/c/session-apis/wslcsetsessionsettingscpucount/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsetsessionsettingscpucount)

WslcSetSessionSettingsCpuCount

```
STDAPI WslcSetSessionSettingsCpuCount(_In_ WslcSessionSettings* sessionSettings, _In_ uint32_t cpuCount);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| sessionSettings |  WslcSessionSettings\* |  in |
| cpuCount |  uint32\_t |  in |

Return value: `HRESULT`.

Example:

```
HRESULT hr = WslcSetSessionSettingsCpuCount(&sessionSettings, (uint32_t)4);
```

\--------------------------------------------------------------------------------

- title: WslcSetSessionSettingsMemory - WSL
- url: https://wsl.dev/api-reference/c/session-apis/wslcsetsessionsettingsmemory/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsetsessionsettingsmemory)

WslcSetSessionSettingsMemory

```
STDAPI WslcSetSessionSettingsMemory(_In_ WslcSessionSettings* sessionSettings, _In_ uint32_t memoryMB);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| sessionSettings |  WslcSessionSettings\* |  in |
| memoryMB |  uint32\_t |  in |

Return value: `HRESULT`.

Example:

```
HRESULT hr = WslcSetSessionSettingsMemory(&sessionSettings, (uint32_t)4096);
```

\--------------------------------------------------------------------------------

- title: WslcSetSessionSettingsTimeout - WSL
- url: https://wsl.dev/api-reference/c/session-apis/wslcsetsessionsettingstimeout/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsetsessionsettingstimeout)

WslcSetSessionSettingsTimeout

```
STDAPI WslcSetSessionSettingsTimeout(_In_ WslcSessionSettings* sessionSettings, _In_ uint32_t timeoutMS);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| sessionSettings |  WslcSessionSettings\* |  in |
| timeoutMS |  uint32\_t |  in |

Return value: `HRESULT`.

Example:

```
HRESULT hr = WslcSetSessionSettingsTimeout(&sessionSettings, (uint32_t)120000);
```

\--------------------------------------------------------------------------------

- title: WslcSetSessionSettingsVhd - WSL
- url: https://wsl.dev/api-reference/c/session-apis/wslcsetsessionsettingsvhd/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsetsessionsettingsvhd)

WslcSetSessionSettingsVhd

```
STDAPI WslcSetSessionSettingsVhd(_In_ WslcSessionSettings* sessionSettings, _In_opt_ const WslcVhdRequirements* vhdRequirements);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| sessionSettings |  WslcSessionSettings\* |  in |
| vhdRequirements |  const WslcVhdRequirements\* |  in, optional |

Return value: `HRESULT`.

Header notes:

- `WslcSetSessionSettingsVhd` rejects non- `NONE` flags with `E_INVALIDARG`.- `WSLC_VHD_TYPE_FIXED` is only honored by `WslcCreateSessionVhdVolume`.

Example:

```
WslcVhdRequirements vhdRequirements = { 0 };
vhdRequirements.name = "ignored-by-WslcSetSessionSettingsVhd";
vhdRequirements.sizeBytes = (uint64_t)64 * 1024 * 1024 * 1024;
vhdRequirements.type = WSLC_VHD_TYPE_DYNAMIC;
vhdRequirements.flags = WSLC_VHD_REQ_FLAG_NONE;
vhdRequirements.uid = (uint32_t)0;
vhdRequirements.gid = (uint32_t)0;

HRESULT hr = WslcSetSessionSettingsVhd(&sessionSettings, &vhdRequirements);
```

\--------------------------------------------------------------------------------

- title: WslcSetSessionSettingsFeatureFlags - WSL
- url: https://wsl.dev/api-reference/c/session-apis/wslcsetsessionsettingsfeatureflags/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsetsessionsettingsfeatureflags)

WslcSetSessionSettingsFeatureFlags

```
STDAPI WslcSetSessionSettingsFeatureFlags(_In_ WslcSessionSettings* sessionSettings, _In_ WslcSessionFeatureFlags flags);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| sessionSettings |  WslcSessionSettings\* |  in |
| flags |  WslcSessionFeatureFlags |  in |

Return value: `HRESULT`.

Example:

```
HRESULT hr = WslcSetSessionSettingsFeatureFlags(
    &sessionSettings,
    WSLC_SESSION_FEATURE_FLAG_ENABLE_GPU);
```

\--------------------------------------------------------------------------------

- title: WslcGetSessionTerminationEvent - WSL
- url: https://wsl.dev/api-reference/c/session-apis/wslcgetsessionterminationevent/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcgetsessionterminationevent)

WslcGetSessionTerminationEvent

```
STDAPI WslcGetSessionTerminationEvent(_In_ WslcSession session, _Out_ HANDLE* terminationEvent);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| session |  WslcSession |  in |
| terminationEvent |  HANDLE\* |  out |

Return value: `HRESULT`.

Example:

```
HANDLE terminationEvent = NULL;
HRESULT hr = WslcGetSessionTerminationEvent(session, &terminationEvent);
if (SUCCEEDED(hr))
{
    WaitForSingleObject(terminationEvent, 1000);
}
```

\--------------------------------------------------------------------------------

- title: WslcGetSessionTerminationReason - WSL
- url: https://wsl.dev/api-reference/c/session-apis/wslcgetsessionterminationreason/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcgetsessionterminationreason)

WslcGetSessionTerminationReason

```
STDAPI WslcGetSessionTerminationReason(_In_ WslcSession session, _Out_ WslcSessionTerminationReason* reason);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| session |  WslcSession |  in |
| reason |  WslcSessionTerminationReason\* |  out |

Return value: `HRESULT`.

Example:

```
WslcSessionTerminationReason reason = WSLC_SESSION_TERMINATION_REASON_UNKNOWN;
HRESULT hr = WslcGetSessionTerminationReason(session, &reason);
```

\--------------------------------------------------------------------------------

- title: WslcRegisterSessionCrashDumpCallback - WSL
- url: https://wsl.dev/api-reference/c/session-apis/wslcregistersessioncrashdumpcallback/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcregistersessioncrashdumpcallback)

WslcRegisterSessionCrashDumpCallback

| Parameter |  Type |  Direction |
| --- | --- | --- |
| session |  WslcSession |  in |
| crashDumpCallback |  WslcSessionCrashDumpCallback |  in |
| crashDumpContext |  PVOID |  in, optional |
| subscription |  WslcCrashDumpSubscription\* |  out |
| errorMessage |  PWSTR\* |  out, optional |

Return value: `HRESULT`.

Example:

\--------------------------------------------------------------------------------

- title: WslcReleaseCrashDumpSubscription - WSL
- url: https://wsl.dev/api-reference/c/session-apis/wslcreleasecrashdumpsubscription/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcreleasecrashdumpsubscription)

WslcReleaseCrashDumpSubscription

```
STDAPI WslcReleaseCrashDumpSubscription(_In_ WslcCrashDumpSubscription subscription);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| subscription |  WslcCrashDumpSubscription |  in |

Return value: `HRESULT`.

Example:

```
HRESULT hr = WslcReleaseCrashDumpSubscription(subscription);
subscription = NULL;
```

\--------------------------------------------------------------------------------

- title: WslcTerminateSession - WSL
- url: https://wsl.dev/api-reference/c/session-apis/wslcterminatesession/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcterminatesession)

WslcTerminateSession

```
STDAPI WslcTerminateSession(_In_ WslcSession session);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| session |  WslcSession |  in |

Return value: `HRESULT`.

Example:

```
HRESULT hr = WslcTerminateSession(session);
```

\--------------------------------------------------------------------------------

- title: WslcReleaseSession - WSL
- url: https://wsl.dev/api-reference/c/session-apis/wslcreleasesession/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcreleasesession)

WslcReleaseSession

```
STDAPI WslcReleaseSession(_In_ WslcSession session);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| session |  WslcSession |  in |

Return value: `HRESULT`.

Example:

```
HRESULT hr = WslcReleaseSession(session);
session = NULL;
```

\--------------------------------------------------------------------------------

- title: WslcSessionAuthenticate - WSL
- url: https://wsl.dev/api-reference/c/session-apis/wslcsessionauthenticate/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsessionauthenticate)

WslcSessionAuthenticate

```
STDAPI WslcSessionAuthenticate(
    _In_ WslcSession session,
    _In_z_ PCSTR serverAddress,
    _In_z_ PCSTR username,
    _In_z_ PCSTR password,
    _Outptr_result_z_ PSTR* identityToken,
    _Outptr_opt_result_z_ PWSTR* errorMessage);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| session |  WslcSession |  in |
| serverAddress |  PCSTR |  in |
| username |  PCSTR |  in |
| password |  PCSTR |  in |
| identityToken |  PSTR\* |  out |
| errorMessage |  PWSTR\* |  out, optional |

Return value: `HRESULT`.

Header note: `identityToken` is allocated using `CoTaskMemAlloc`; free it with `CoTaskMemFree`.

Example:

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: Container APIs - WSL
- url: https://wsl.dev/api-reference/c/container-apis/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#container-apis)

Container APIs

Members

- [WslcInitContainerSettings](wslcinitcontainersettings/)- [WslcCreateContainer](wslccreatecontainer/)- [WslcStartContainer](wslcstartcontainer/)- [WslcSetContainerSettingsName](wslcsetcontainersettingsname/)- [WslcSetContainerSettingsInitProcess](wslcsetcontainersettingsinitprocess/)- [WslcSetContainerSettingsNetworkingMode](wslcsetcontainersettingsnetworkingmode/)- [WslcSetContainerSettingsHostName](wslcsetcontainersettingshostname/)- [WslcSetContainerSettingsDomainName](wslcsetcontainersettingsdomainname/)- [WslcSetContainerSettingsFlags](wslcsetcontainersettingsflags/)- [WslcSetContainerSettingsPortMappings](wslcsetcontainersettingsportmappings/)- [WslcSetContainerSettingsVolumes](wslcsetcontainersettingsvolumes/)- [WslcSetContainerSettingsNamedVolumes](wslcsetcontainersettingsnamedvolumes/)- [WslcCreateContainerProcess](wslccreatecontainerprocess/)- [WslcGetContainerID](wslcgetcontainerid/)- [WslcGetContainerInitProcess](wslcgetcontainerinitprocess/)- [WslcInspectContainer](wslcinspectcontainer/)- [WslcGetContainerState](wslcgetcontainerstate/)- [WslcStopContainer](wslcstopcontainer/)- [WslcDeleteContainer](wslcdeletecontainer/)- [WslcReleaseContainer](wslcreleasecontainer/)

\--------------------------------------------------------------------------------

- title: WslcInitContainerSettings - WSL
- url: https://wsl.dev/api-reference/c/container-apis/wslcinitcontainersettings/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcinitcontainersettings)

WslcInitContainerSettings

```
STDAPI WslcInitContainerSettings(_In_ PCSTR imageName, _Out_ WslcContainerSettings* containerSettings);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| imageName |  PCSTR |  in |
| containerSettings |  WslcContainerSettings\* |  out |

Return value: `HRESULT`.

Example:

```
WslcContainerSettings containerSettings;
HRESULT hr = WslcInitContainerSettings("docker.io/library/alpine:latest", &containerSettings);
```

\--------------------------------------------------------------------------------

- title: WslcCreateContainer - WSL
- url: https://wsl.dev/api-reference/c/container-apis/wslccreatecontainer/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslccreatecontainer)

WslcCreateContainer

```
STDAPI WslcCreateContainer(_In_ WslcSession session, _In_ const WslcContainerSettings* containerSettings, _Out_ WslcContainer* container, _Outptr_opt_result_z_ PWSTR* errorMessage);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| session |  WslcSession |  in |
| containerSettings |  const WslcContainerSettings\* |  in |
| container |  WslcContainer\* |  out |
| errorMessage |  PWSTR\* |  out, optional |

Return value: `HRESULT`.

Example:

```
WslcContainer container = NULL;
HRESULT hr = WslcCreateContainer(session, &containerSettings, &container, NULL);
```

\--------------------------------------------------------------------------------

- title: WslcStartContainer - WSL
- url: https://wsl.dev/api-reference/c/container-apis/wslcstartcontainer/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcstartcontainer)

WslcStartContainer

```
STDAPI WslcStartContainer(_In_ WslcContainer container, _In_ WslcContainerStartFlags flags, _Outptr_opt_result_z_ PWSTR* errorMessage);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| container |  WslcContainer |  in |
| flags |  WslcContainerStartFlags |  in |
| errorMessage |  PWSTR\* |  out, optional |

Return value: `HRESULT`.

Example:

```
HRESULT hr = WslcStartContainer(container, WSLC_CONTAINER_START_FLAG_ATTACH, NULL);
```

\--------------------------------------------------------------------------------

- title: WslcSetContainerSettingsName - WSL
- url: https://wsl.dev/api-reference/c/container-apis/wslcsetcontainersettingsname/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsetcontainersettingsname)

WslcSetContainerSettingsName

```
STDAPI WslcSetContainerSettingsName(_In_ WslcContainerSettings* containerSettings, _In_ PCSTR name);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| containerSettings |  WslcContainerSettings\* |  in |
| name |  PCSTR |  in |

Return value: `HRESULT`.

Example:

```
HRESULT hr = WslcSetContainerSettingsName(&containerSettings, "demo-container");
```

\--------------------------------------------------------------------------------

- title: WslcSetContainerSettingsInitProcess - WSL
- url: https://wsl.dev/api-reference/c/container-apis/wslcsetcontainersettingsinitprocess/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsetcontainersettingsinitprocess)

WslcSetContainerSettingsInitProcess

```
STDAPI WslcSetContainerSettingsInitProcess(_In_ WslcContainerSettings* containerSettings, _In_ WslcProcessSettings* initProcess);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| containerSettings |  WslcContainerSettings\* |  in |
| initProcess |  WslcProcessSettings\* |  in |

Return value: `HRESULT`.

Example:

```
WslcProcessSettings initProcess;
PCSTR const argv[] = { "/bin/sh", "-c", "sleep 3600" };

WslcInitProcessSettings(&initProcess);
WslcSetProcessSettingsCmdLine(&initProcess, argv, _countof(argv));

HRESULT hr = WslcSetContainerSettingsInitProcess(&containerSettings, &initProcess);
```

\--------------------------------------------------------------------------------

- title: WslcSetContainerSettingsNetworkingMode - WSL
- url: https://wsl.dev/api-reference/c/container-apis/wslcsetcontainersettingsnetworkingmode/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsetcontainersettingsnetworkingmode)

WslcSetContainerSettingsNetworkingMode

```
STDAPI WslcSetContainerSettingsNetworkingMode(_In_ WslcContainerSettings* containerSettings, _In_ WslcContainerNetworkingMode networkingMode);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| containerSettings |  WslcContainerSettings\* |  in |
| networkingMode |  WslcContainerNetworkingMode |  in |

Return value: `HRESULT`.

Example:

```
HRESULT hr = WslcSetContainerSettingsNetworkingMode(
    &containerSettings,
    WSLC_CONTAINER_NETWORKING_MODE_BRIDGED);
```

\--------------------------------------------------------------------------------

- title: WslcSetContainerSettingsHostName - WSL
- url: https://wsl.dev/api-reference/c/container-apis/wslcsetcontainersettingshostname/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsetcontainersettingshostname)

WslcSetContainerSettingsHostName

```
STDAPI WslcSetContainerSettingsHostName(_In_ WslcContainerSettings* containerSettings, _In_ PCSTR hostName);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| containerSettings |  WslcContainerSettings\* |  in |
| hostName |  PCSTR |  in |

Return value: `HRESULT`.

Example:

```
HRESULT hr = WslcSetContainerSettingsHostName(&containerSettings, "demo-host");
```

\--------------------------------------------------------------------------------

- title: WslcSetContainerSettingsDomainName - WSL
- url: https://wsl.dev/api-reference/c/container-apis/wslcsetcontainersettingsdomainname/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsetcontainersettingsdomainname)

WslcSetContainerSettingsDomainName

```
STDAPI WslcSetContainerSettingsDomainName(_In_ WslcContainerSettings* containerSettings, _In_ PCSTR domainName);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| containerSettings |  WslcContainerSettings\* |  in |
| domainName |  PCSTR |  in |

Return value: `HRESULT`.

Example:

```
HRESULT hr = WslcSetContainerSettingsDomainName(&containerSettings, "example.internal");
```

\--------------------------------------------------------------------------------

- title: WslcSetContainerSettingsFlags - WSL
- url: https://wsl.dev/api-reference/c/container-apis/wslcsetcontainersettingsflags/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsetcontainersettingsflags)

WslcSetContainerSettingsFlags

```
STDAPI WslcSetContainerSettingsFlags(_In_ WslcContainerSettings* containerSettings, _In_ WslcContainerFlags flags);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| containerSettings |  WslcContainerSettings\* |  in |
| flags |  WslcContainerFlags |  in |

Return value: `HRESULT`.

Example:

```
HRESULT hr = WslcSetContainerSettingsFlags(
    &containerSettings,
    (WslcContainerFlags)(WSLC_CONTAINER_FLAG_AUTO_REMOVE | WSLC_CONTAINER_FLAG_ENABLE_GPU));
```

\--------------------------------------------------------------------------------

- title: WslcSetContainerSettingsPortMappings - WSL
- url: https://wsl.dev/api-reference/c/container-apis/wslcsetcontainersettingsportmappings/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsetcontainersettingsportmappings)

WslcSetContainerSettingsPortMappings

```
STDAPI WslcSetContainerSettingsPortMappings(
    _In_ WslcContainerSettings* containerSettings,
    _In_reads_opt_(portMappingCount) const WslcContainerPortMapping* portMappings,
    _In_ uint32_t portMappingCount);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| containerSettings |  WslcContainerSettings\* |  in |
| portMappings |  const WslcContainerPortMapping\* |  in, optional |
| portMappingCount |  uint32\_t |  in |

Return value: `HRESULT`.

Example:

```
WslcContainerPortMapping portMappings[1] = { 0 };
portMappings[0].windowsPort = (uint16_t)8080;
portMappings[0].containerPort = (uint16_t)80;
portMappings[0].protocol = WSLC_PORT_PROTOCOL_TCP;
portMappings[0].windowsAddress = NULL;

HRESULT hr = WslcSetContainerSettingsPortMappings(
    &containerSettings,
    portMappings,
    (uint32_t)_countof(portMappings));
```

\--------------------------------------------------------------------------------

- title: WslcSetContainerSettingsVolumes - WSL
- url: https://wsl.dev/api-reference/c/container-apis/wslcsetcontainersettingsvolumes/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsetcontainersettingsvolumes)

WslcSetContainerSettingsVolumes

```
STDAPI WslcSetContainerSettingsVolumes(
    _In_ WslcContainerSettings* containerSettings, _In_reads_opt_(volumeCount) const WslcContainerVolume* volumes, _In_ uint32_t volumeCount);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| containerSettings |  WslcContainerSettings\* |  in |
| volumes |  const WslcContainerVolume\* |  in, optional |
| volumeCount |  uint32\_t |  in |

Return value: `HRESULT`.

Example:

```
WslcContainerVolume volumes[1] = { 0 };
volumes[0].windowsPath = L"C:\\data";
volumes[0].containerPath = "/mnt/data";
volumes[0].readOnly = FALSE;

HRESULT hr = WslcSetContainerSettingsVolumes(
    &containerSettings,
    volumes,
    (uint32_t)_countof(volumes));
```

\--------------------------------------------------------------------------------

- title: WslcSetContainerSettingsNamedVolumes - WSL
- url: https://wsl.dev/api-reference/c/container-apis/wslcsetcontainersettingsnamedvolumes/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsetcontainersettingsnamedvolumes)

WslcSetContainerSettingsNamedVolumes

```
STDAPI WslcSetContainerSettingsNamedVolumes(
    _In_ WslcContainerSettings* containerSettings,
    _In_reads_opt_(namedVolumeCount) const WslcContainerNamedVolume* namedVolumes,
    _In_ uint32_t namedVolumeCount);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| containerSettings |  WslcContainerSettings\* |  in |
| namedVolumes |  const WslcContainerNamedVolume\* |  in, optional |
| namedVolumeCount |  uint32\_t |  in |

Return value: `HRESULT`.

Example:

```
WslcContainerNamedVolume namedVolumes[1] = { 0 };
namedVolumes[0].name = "cache";
namedVolumes[0].containerPath = "/var/cache/demo";
namedVolumes[0].readOnly = FALSE;

HRESULT hr = WslcSetContainerSettingsNamedVolumes(
    &containerSettings,
    namedVolumes,
    (uint32_t)_countof(namedVolumes));
```

\--------------------------------------------------------------------------------

- title: WslcCreateContainerProcess - WSL
- url: https://wsl.dev/api-reference/c/container-apis/wslccreatecontainerprocess/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslccreatecontainerprocess)

WslcCreateContainerProcess

```
STDAPI WslcCreateContainerProcess(
    _In_ WslcContainer container, _In_ WslcProcessSettings* newProcessSettings, _Out_ WslcProcess* newProcess, _Outptr_opt_result_z_ PWSTR* errorMessage);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| container |  WslcContainer |  in |
| newProcessSettings |  WslcProcessSettings\* |  in |
| newProcess |  WslcProcess\* |  out |
| errorMessage |  PWSTR\* |  out, optional |

Return value: `HRESULT`.

Example:

```
WslcProcessSettings processSettings;
WslcProcess process = NULL;
PCSTR const argv[] = { "/bin/echo", "hello from wscl" };

WslcInitProcessSettings(&processSettings);
WslcSetProcessSettingsCmdLine(&processSettings, argv, _countof(argv));

HRESULT hr = WslcCreateContainerProcess(container, &processSettings, &process, NULL);
```

\--------------------------------------------------------------------------------

- title: WslcGetContainerID - WSL
- url: https://wsl.dev/api-reference/c/container-apis/wslcgetcontainerid/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcgetcontainerid)

WslcGetContainerID

```
STDAPI WslcGetContainerID(_In_ WslcContainer container, _Out_writes_(WSLC_CONTAINER_ID_BUFFER_SIZE) CHAR containerID[WSLC_CONTAINER_ID_BUFFER_SIZE]);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| container |  WslcContainer |  in |
| containerID |  CHARWSLC\_CONTAINER\_ID\_BUFFER\_SIZE |  out |

Return value: `HRESULT`.

Example:

```
CHAR containerID[WSLC_CONTAINER_ID_BUFFER_SIZE] = { 0 };
HRESULT hr = WslcGetContainerID(container, containerID);
```

\--------------------------------------------------------------------------------

- title: WslcGetContainerInitProcess - WSL
- url: https://wsl.dev/api-reference/c/container-apis/wslcgetcontainerinitprocess/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcgetcontainerinitprocess)

WslcGetContainerInitProcess

```
STDAPI WslcGetContainerInitProcess(_In_ WslcContainer container, _Out_ WslcProcess* initProcess);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| container |  WslcContainer |  in |
| initProcess |  WslcProcess\* |  out |

Return value: `HRESULT`.

Example:

```
WslcProcess initProcess = NULL;
HRESULT hr = WslcGetContainerInitProcess(container, &initProcess);
```

\--------------------------------------------------------------------------------

- title: WslcInspectContainer - WSL
- url: https://wsl.dev/api-reference/c/container-apis/wslcinspectcontainer/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcinspectcontainer)

WslcInspectContainer

```
STDAPI WslcInspectContainer(_In_ WslcContainer container, _Outptr_result_z_ PSTR* inspectData);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| container |  WslcContainer |  in |
| inspectData |  PSTR\* |  out |

Return value: `HRESULT`.

Header note: `inspectData` is allocated using `CoTaskMemAlloc`; free it with `CoTaskMemFree`.

Example:

```
PSTR inspectData = NULL;
HRESULT hr = WslcInspectContainer(container, &inspectData);
if (SUCCEEDED(hr))
{
    puts(inspectData);
    CoTaskMemFree(inspectData);
}
```

\--------------------------------------------------------------------------------

- title: WslcGetContainerState - WSL
- url: https://wsl.dev/api-reference/c/container-apis/wslcgetcontainerstate/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcgetcontainerstate)

WslcGetContainerState

```
STDAPI WslcGetContainerState(_In_ WslcContainer container, _Out_ WslcContainerState* state);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| container |  WslcContainer |  in |
| state |  WslcContainerState\* |  out |

Return value: `HRESULT`.

Example:

```
WslcContainerState state = WSLC_CONTAINER_STATE_INVALID;
HRESULT hr = WslcGetContainerState(container, &state);
```

\--------------------------------------------------------------------------------

- title: WslcStopContainer - WSL
- url: https://wsl.dev/api-reference/c/container-apis/wslcstopcontainer/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcstopcontainer)

WslcStopContainer

```
STDAPI WslcStopContainer(_In_ WslcContainer container, _In_ WslcSignal signal, _In_ uint32_t timeoutSeconds, _Outptr_opt_result_z_ PWSTR* errorMessage);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| container |  WslcContainer |  in |
| signal |  WslcSignal |  in |
| timeoutSeconds |  uint32\_t |  in |
| errorMessage |  PWSTR\* |  out, optional |

Return value: `HRESULT`.

Example:

\--------------------------------------------------------------------------------

- title: WslcDeleteContainer - WSL
- url: https://wsl.dev/api-reference/c/container-apis/wslcdeletecontainer/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcdeletecontainer)

WslcDeleteContainer

```
STDAPI WslcDeleteContainer(_In_ WslcContainer container, _In_ WslcDeleteContainerFlags flags, _Outptr_opt_result_z_ PWSTR* errorMessage);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| container |  WslcContainer |  in |
| flags |  WslcDeleteContainerFlags |  in |
| errorMessage |  PWSTR\* |  out, optional |

Return value: `HRESULT`.

Example:

```
HRESULT hr = WslcDeleteContainer(
    container,
    WSLC_DELETE_CONTAINER_FLAG_FORCE,
    NULL);
```

\--------------------------------------------------------------------------------

- title: WslcReleaseContainer - WSL
- url: https://wsl.dev/api-reference/c/container-apis/wslcreleasecontainer/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcreleasecontainer)

WslcReleaseContainer

```
STDAPI WslcReleaseContainer(_In_ WslcContainer container);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| container |  WslcContainer |  in |

Return value: `HRESULT`.

Example:

```
HRESULT hr = WslcReleaseContainer(container);
container = NULL;
```

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: Process APIs - WSL
- url: https://wsl.dev/api-reference/c/process-apis/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#process-apis)

Process APIs

Members

- [WslcInitProcessSettings](wslcinitprocesssettings/)- [WslcSetProcessSettingsWorkingDirectory](wslcsetprocesssettingsworkingdirectory/)- [WslcSetProcessSettingsCmdLine](wslcsetprocesssettingscmdline/)- [WslcSetProcessSettingsEnvVariables](wslcsetprocesssettingsenvvariables/)- [WslcSetProcessSettingsCallbacks](wslcsetprocesssettingscallbacks/)- [WslcGetProcessPid](wslcgetprocesspid/)- [WslcGetProcessExitEvent](wslcgetprocessexitevent/)- [WslcGetProcessState](wslcgetprocessstate/)- [WslcGetProcessExitCode](wslcgetprocessexitcode/)- [WslcSignalProcess](wslcsignalprocess/)- [WslcGetProcessIOHandle](wslcgetprocessiohandle/)- [WslcReleaseProcess](wslcreleaseprocess/)

\--------------------------------------------------------------------------------

- title: WslcInitProcessSettings - WSL
- url: https://wsl.dev/api-reference/c/process-apis/wslcinitprocesssettings/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcinitprocesssettings)

WslcInitProcessSettings

```
STDAPI WslcInitProcessSettings(_Out_ WslcProcessSettings* processSettings);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| processSettings |  WslcProcessSettings\* |  out |

Return value: `HRESULT`.

Example:

```
WslcProcessSettings processSettings;
HRESULT hr = WslcInitProcessSettings(&processSettings);
```

\--------------------------------------------------------------------------------

- title: WslcSetProcessSettingsWorkingDirectory - WSL
- url: https://wsl.dev/api-reference/c/process-apis/wslcsetprocesssettingsworkingdirectory/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsetprocesssettingsworkingdirectory)

WslcSetProcessSettingsWorkingDirectory

```
STDAPI WslcSetProcessSettingsWorkingDirectory(_In_ WslcProcessSettings* processSettings, _In_ PCSTR workingDirectory);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| processSettings |  WslcProcessSettings\* |  in |
| workingDirectory |  PCSTR |  in |

Return value: `HRESULT`.

Example:

```
HRESULT hr = WslcSetProcessSettingsWorkingDirectory(&processSettings, "/work");
```

\--------------------------------------------------------------------------------

- title: WslcSetProcessSettingsCmdLine - WSL
- url: https://wsl.dev/api-reference/c/process-apis/wslcsetprocesssettingscmdline/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsetprocesssettingscmdline)

WslcSetProcessSettingsCmdLine

```
STDAPI WslcSetProcessSettingsCmdLine(_In_ WslcProcessSettings* processSettings, _In_reads_(argc) PCSTR const* argv, size_t argc);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| processSettings |  WslcProcessSettings\* |  in |
| argv |  PCSTR const\* |  in |
| argc |  size\_t |  in |

Return value: `HRESULT`.

Example:

```
PCSTR const argv[] = { "/bin/sh", "-c", "echo ready" };
HRESULT hr = WslcSetProcessSettingsCmdLine(&processSettings, argv, _countof(argv));
```

\--------------------------------------------------------------------------------

- title: WslcSetProcessSettingsEnvVariables - WSL
- url: https://wsl.dev/api-reference/c/process-apis/wslcsetprocesssettingsenvvariables/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsetprocesssettingsenvvariables)

WslcSetProcessSettingsEnvVariables

```
STDAPI WslcSetProcessSettingsEnvVariables(_In_ WslcProcessSettings* processSettings, _In_reads_(argc) PCSTR const* key_value, size_t argc);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| processSettings |  WslcProcessSettings\* |  in |
| key\_value |  PCSTR const\* |  in |
| argc |  size\_t |  in |

Return value: `HRESULT`.

Example:

```
PCSTR const key_value[] = { "HOME=/root", "DEMO_FLAG=1" };
HRESULT hr = WslcSetProcessSettingsEnvVariables(&processSettings, key_value, _countof(key_value));
```

\--------------------------------------------------------------------------------

- title: WslcSetProcessSettingsCallbacks - WSL
- url: https://wsl.dev/api-reference/c/process-apis/wslcsetprocesssettingscallbacks/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsetprocesssettingscallbacks)

WslcSetProcessSettingsCallbacks

```
STDAPI WslcSetProcessSettingsCallbacks(_In_ WslcProcessSettings* processSettings, _In_ const WslcProcessCallbacks* callbacks, _In_opt_ PVOID context);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| processSettings |  WslcProcessSettings\* |  in |
| callbacks |  const WslcProcessCallbacks\* |  in |
| context |  PVOID |  in, optional |

Return value: `HRESULT`.

Header note: using callbacks consumes the process I/O handles and prevents later acquisition through `WslcGetProcessIOHandle`.

Example:

```
void CALLBACK OnStdOut(WslcProcessIOHandle ioHandle, const BYTE* data, uint32_t dataBytes, PVOID context)
{
    UNREFERENCED_PARAMETER(ioHandle);
    UNREFERENCED_PARAMETER(context);
    fwrite(data, 1, dataBytes, stdout);
}

void CALLBACK OnExit(INT32 exitCode, PVOID context)
{
    UNREFERENCED_PARAMETER(context);
    printf("exit=%ld\n", (long)exitCode);
}

WslcProcessCallbacks callbacks = { 0 };
callbacks.onStdOut = OnStdOut;
callbacks.onStdErr = OnStdOut;
callbacks.onExit = OnExit;

HRESULT hr = WslcSetProcessSettingsCallbacks(&processSettings, &callbacks, NULL);
```

\--------------------------------------------------------------------------------

- title: WslcGetProcessPid - WSL
- url: https://wsl.dev/api-reference/c/process-apis/wslcgetprocesspid/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcgetprocesspid)

WslcGetProcessPid

```
STDAPI WslcGetProcessPid(_In_ WslcProcess process, _Out_ uint32_t* pid);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| process |  WslcProcess |  in |
| pid |  uint32\_t\* |  out |

Return value: `HRESULT`.

Example:

```
uint32_t pid = 0;
HRESULT hr = WslcGetProcessPid(process, &pid);
```

\--------------------------------------------------------------------------------

- title: WslcGetProcessExitEvent - WSL
- url: https://wsl.dev/api-reference/c/process-apis/wslcgetprocessexitevent/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcgetprocessexitevent)

WslcGetProcessExitEvent

```
STDAPI WslcGetProcessExitEvent(_In_ WslcProcess process, _Out_ HANDLE* exitEvent);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| process |  WslcProcess |  in |
| exitEvent |  HANDLE\* |  out |

Return value: `HRESULT`.

Example:

```
HANDLE exitEvent = NULL;
HRESULT hr = WslcGetProcessExitEvent(process, &exitEvent);
if (SUCCEEDED(hr))
{
    WaitForSingleObject(exitEvent, INFINITE);
}
```

\--------------------------------------------------------------------------------

- title: WslcGetProcessState - WSL
- url: https://wsl.dev/api-reference/c/process-apis/wslcgetprocessstate/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcgetprocessstate)

WslcGetProcessState

```
STDAPI WslcGetProcessState(_In_ WslcProcess process, _Out_ WslcProcessState* state);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| process |  WslcProcess |  in |
| state |  WslcProcessState\* |  out |

Return value: `HRESULT`.

Example:

```
WslcProcessState state = WSLC_PROCESS_STATE_UNKNOWN;
HRESULT hr = WslcGetProcessState(process, &state);
```

\--------------------------------------------------------------------------------

- title: WslcGetProcessExitCode - WSL
- url: https://wsl.dev/api-reference/c/process-apis/wslcgetprocessexitcode/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcgetprocessexitcode)

WslcGetProcessExitCode

```
STDAPI WslcGetProcessExitCode(_In_ WslcProcess process, _Out_ PINT32 exitCode);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| process |  WslcProcess |  in |
| exitCode |  PINT32 |  out |

Return value: `HRESULT`.

Example:

```
INT32 exitCode = 0;
HRESULT hr = WslcGetProcessExitCode(process, &exitCode);
```

\--------------------------------------------------------------------------------

- title: WslcSignalProcess - WSL
- url: https://wsl.dev/api-reference/c/process-apis/wslcsignalprocess/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsignalprocess)

WslcSignalProcess

```
STDAPI WslcSignalProcess(_In_ WslcProcess process, _In_ WslcSignal signal);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| process |  WslcProcess |  in |
| signal |  WslcSignal |  in |

Return value: `HRESULT`.

Example:

```
HRESULT hr = WslcSignalProcess(process, WSLC_SIGNAL_SIGTERM);
```

\--------------------------------------------------------------------------------

- title: WslcGetProcessIOHandle - WSL
- url: https://wsl.dev/api-reference/c/process-apis/wslcgetprocessiohandle/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcgetprocessiohandle)

WslcGetProcessIOHandle

```
STDAPI WslcGetProcessIOHandle(_In_ WslcProcess process, _In_ WslcProcessIOHandle ioHandle, _Out_ HANDLE* handle);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| process |  WslcProcess |  in |
| ioHandle |  WslcProcessIOHandle |  in |
| handle |  HANDLE\* |  out |

Return value: `HRESULT`.

Example:

```
HANDLE stdoutHandle = NULL;
HRESULT hr = WslcGetProcessIOHandle(process, WSLC_PROCESS_IO_HANDLE_STDOUT, &stdoutHandle);
```

\--------------------------------------------------------------------------------

- title: WslcReleaseProcess - WSL
- url: https://wsl.dev/api-reference/c/process-apis/wslcreleaseprocess/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcreleaseprocess)

WslcReleaseProcess

```
STDAPI WslcReleaseProcess(_In_ WslcProcess process);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| process |  WslcProcess |  in |

Return value: `HRESULT`.

Example:

```
HRESULT hr = WslcReleaseProcess(process);
process = NULL;
```

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: Image APIs - WSL
- url: https://wsl.dev/api-reference/c/image-apis/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#image-apis)

Image APIs

Members

- [WslcPullSessionImage](wslcpullsessionimage/)- [WslcImportSessionImage](wslcimportsessionimage/)- [WslcImportSessionImageFromFile](wslcimportsessionimagefromfile/)- [WslcLoadSessionImage](wslcloadsessionimage/)- [WslcLoadSessionImageFromFile](wslcloadsessionimagefromfile/)- [WslcDeleteSessionImage](wslcdeletesessionimage/)- [WslcListSessionImages](wslclistsessionimages/)- [WslcTagSessionImage](wslctagsessionimage/)- [WslcPushSessionImage](wslcpushsessionimage/)

\--------------------------------------------------------------------------------

- title: WslcPullSessionImage - WSL
- url: https://wsl.dev/api-reference/c/image-apis/wslcpullsessionimage/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcpullsessionimage)

WslcPullSessionImage

```
STDAPI WslcPullSessionImage(_In_ WslcSession session, _In_ const WslcPullImageOptions* options, _Outptr_opt_result_z_ PWSTR* errorMessage);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| session |  WslcSession |  in |
| options |  const WslcPullImageOptions\* |  in |
| errorMessage |  PWSTR\* |  out, optional |

Return value: `HRESULT`.

Example:

```
HRESULT CALLBACK OnImageProgress(const WslcImageProgressMessage* progress, PVOID context)
{
    UNREFERENCED_PARAMETER(context);
    printf("%s %llu/%llu\n",
        progress->id,
        (unsigned long long)progress->detail.currentBytes,
        (unsigned long long)progress->detail.totalBytes);
    return S_OK;
}

WslcPullImageOptions pullOptions = { 0 };
pullOptions.uri = "docker.io/library/alpine:latest";
pullOptions.progressCallback = OnImageProgress;
pullOptions.progressCallbackContext = NULL;
pullOptions.registryAuth = NULL;

HRESULT hr = WslcPullSessionImage(session, &pullOptions, NULL);
```

\--------------------------------------------------------------------------------

- title: WslcImportSessionImage - WSL
- url: https://wsl.dev/api-reference/c/image-apis/wslcimportsessionimage/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcimportsessionimage)

WslcImportSessionImage

```
STDAPI WslcImportSessionImage(
    _In_ WslcSession session,
    _In_z_ PCSTR imageName,
    _In_ HANDLE imageContent,
    _In_ uint64_t imageContentBytes,
    _In_opt_ const WslcImportImageOptions* options,
    _Outptr_opt_result_z_ PWSTR* errorMessage);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| session |  WslcSession |  in |
| imageName |  PCSTR |  in |
| imageContent |  HANDLE |  in |
| imageContentBytes |  uint64\_t |  in |
| options |  const WslcImportImageOptions\* |  in, optional |
| errorMessage |  PWSTR\* |  out, optional |

Return value: `HRESULT`.

Important: the header declares `imageContent` as `HANDLE`, not `void*`.

Example:

\--------------------------------------------------------------------------------

- title: WslcImportSessionImageFromFile - WSL
- url: https://wsl.dev/api-reference/c/image-apis/wslcimportsessionimagefromfile/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcimportsessionimagefromfile)

WslcImportSessionImageFromFile

```
STDAPI WslcImportSessionImageFromFile(
    _In_ WslcSession session, _In_z_ PCSTR imageName, _In_z_ PCWSTR path, _In_opt_ const WslcImportImageOptions* options, _Outptr_opt_result_z_ PWSTR* errorMessage);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| session |  WslcSession |  in |
| imageName |  PCSTR |  in |
| path |  PCWSTR |  in |
| options |  const WslcImportImageOptions\* |  in, optional |
| errorMessage |  PWSTR\* |  out, optional |

Return value: `HRESULT`.

Example:

```
WslcImportImageOptions importOptions = { 0 };
HRESULT hr = WslcImportSessionImageFromFile(
    session,
    "demo/imported:latest",
    L"C:\\images\\demo-import.tar",
    &importOptions,
    NULL);
```

\--------------------------------------------------------------------------------

- title: WslcLoadSessionImage - WSL
- url: https://wsl.dev/api-reference/c/image-apis/wslcloadsessionimage/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcloadsessionimage)

WslcLoadSessionImage

```
STDAPI WslcLoadSessionImage(
    _In_ WslcSession session,
    _In_ HANDLE imageContent,
    _In_ uint64_t imageContentBytes,
    _In_opt_ const WslcLoadImageOptions* options,
    _Outptr_opt_result_z_ PWSTR* errorMessage);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| session |  WslcSession |  in |
| imageContent |  HANDLE |  in |
| imageContentBytes |  uint64\_t |  in |
| options |  const WslcLoadImageOptions\* |  in, optional |
| errorMessage |  PWSTR\* |  out, optional |

Return value: `HRESULT`.

Important: the header declares `imageContent` as `HANDLE`, not `void*`.

Example:

\--------------------------------------------------------------------------------

- title: WslcLoadSessionImageFromFile - WSL
- url: https://wsl.dev/api-reference/c/image-apis/wslcloadsessionimagefromfile/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcloadsessionimagefromfile)

WslcLoadSessionImageFromFile

```
STDAPI WslcLoadSessionImageFromFile(
    _In_ WslcSession session, _In_z_ PCWSTR path, _In_opt_ const WslcLoadImageOptions* options, _Outptr_opt_result_z_ PWSTR* errorMessage);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| session |  WslcSession |  in |
| path |  PCWSTR |  in |
| options |  const WslcLoadImageOptions\* |  in, optional |
| errorMessage |  PWSTR\* |  out, optional |

Return value: `HRESULT`.

Example:

```
WslcLoadImageOptions loadOptions = { 0 };
HRESULT hr = WslcLoadSessionImageFromFile(
    session,
    L"C:\\images\\demo-load.tar",
    &loadOptions,
    NULL);
```

\--------------------------------------------------------------------------------

- title: WslcDeleteSessionImage - WSL
- url: https://wsl.dev/api-reference/c/image-apis/wslcdeletesessionimage/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcdeletesessionimage)

WslcDeleteSessionImage

```
STDAPI WslcDeleteSessionImage(_In_ WslcSession session, _In_z_ PCSTR nameOrID, _Outptr_opt_result_z_ PWSTR* errorMessage);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| session |  WslcSession |  in |
| nameOrID |  PCSTR |  in |
| errorMessage |  PWSTR\* |  out, optional |

Return value: `HRESULT`.

Example:

```
HRESULT hr = WslcDeleteSessionImage(session, "demo/imported:latest", NULL);
```

\--------------------------------------------------------------------------------

- title: WslcListSessionImages - WSL
- url: https://wsl.dev/api-reference/c/image-apis/wslclistsessionimages/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslclistsessionimages)

WslcListSessionImages

```
STDAPI WslcListSessionImages(_In_ WslcSession session, _Outptr_result_buffer_(*count) WslcImageInfo** images, _Out_ uint32_t* count);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| session |  WslcSession |  in |
| images |  WslcImageInfo\*\* |  out |
| count |  uint32\_t\* |  out |

Return value: `HRESULT`.

Header note: `images` is allocated using `CoTaskMemAlloc`; free it with `CoTaskMemFree`.

Example:

```
WslcImageInfo* images = NULL;
uint32_t count = 0;
HRESULT hr = WslcListSessionImages(session, &images, &count);

if (SUCCEEDED(hr))
{
    for (uint32_t i = 0; i < count; ++i)
    {
        printf("%s\n", images[i].name);
    }
    CoTaskMemFree(images);
}
```

\--------------------------------------------------------------------------------

- title: WslcTagSessionImage - WSL
- url: https://wsl.dev/api-reference/c/image-apis/wslctagsessionimage/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslctagsessionimage)

WslcTagSessionImage

```
STDAPI WslcTagSessionImage(_In_ WslcSession session, _In_ const WslcTagImageOptions* options, _Outptr_opt_result_z_ PWSTR* errorMessage);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| session |  WslcSession |  in |
| options |  const WslcTagImageOptions\* |  in |
| errorMessage |  PWSTR\* |  out, optional |

Return value: `HRESULT`.

Example:

```
WslcTagImageOptions tagOptions = { 0 };
tagOptions.image = "docker.io/library/alpine:latest";
tagOptions.repo = "demo/alpine";
tagOptions.tag = "stable";

HRESULT hr = WslcTagSessionImage(session, &tagOptions, NULL);
```

\--------------------------------------------------------------------------------

- title: WslcPushSessionImage - WSL
- url: https://wsl.dev/api-reference/c/image-apis/wslcpushsessionimage/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcpushsessionimage)

WslcPushSessionImage

```
STDAPI WslcPushSessionImage(_In_ WslcSession session, _In_ const WslcPushImageOptions* options, _Outptr_opt_result_z_ PWSTR* errorMessage);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| session |  WslcSession |  in |
| options |  const WslcPushImageOptions\* |  in |
| errorMessage |  PWSTR\* |  out, optional |

Return value: `HRESULT`.

Example:

```
WslcPushImageOptions pushOptions = { 0 };
pushOptions.image = "demo/alpine:stable";
pushOptions.registryAuth = "BASE64_X_REGISTRY_AUTH";
pushOptions.progressCallback = OnImageProgress;
pushOptions.progressCallbackContext = NULL;

HRESULT hr = WslcPushSessionImage(session, &pushOptions, NULL);
```

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: Storage APIs - WSL
- url: https://wsl.dev/api-reference/c/storage-apis/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#storage-apis)

Storage APIs

Members

- [WslcCreateSessionVhdVolume](wslccreatesessionvhdvolume/)- [WslcDeleteSessionVhdVolume](wslcdeletesessionvhdvolume/)

\--------------------------------------------------------------------------------

- title: WslcCreateSessionVhdVolume - WSL
- url: https://wsl.dev/api-reference/c/storage-apis/wslccreatesessionvhdvolume/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslccreatesessionvhdvolume)

WslcCreateSessionVhdVolume

```
STDAPI WslcCreateSessionVhdVolume(_In_ WslcSession session, _In_ const WslcVhdRequirements* options, _Outptr_opt_result_z_ PWSTR* errorMessage);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| session |  WslcSession |  in |
| options |  const WslcVhdRequirements\* |  in |
| errorMessage |  PWSTR\* |  out, optional |

Return value: `HRESULT`.

Header notes:

- `WSLC_VHD_TYPE_FIXED` is only honored by `WslcCreateSessionVhdVolume`.- `uid` and `gid` are honored iff `flags & WSLC_VHD_REQ_FLAG_OWNER`.

Example:

```
WslcVhdRequirements options = { 0 };
options.name = "cache";
options.sizeBytes = (uint64_t)8 * 1024 * 1024 * 1024;
options.type = WSLC_VHD_TYPE_DYNAMIC;
options.flags = WSLC_VHD_REQ_FLAG_OWNER;
options.uid = (uint32_t)1000;
options.gid = (uint32_t)1000;

HRESULT hr = WslcCreateSessionVhdVolume(session, &options, NULL);
```

\--------------------------------------------------------------------------------

- title: WslcDeleteSessionVhdVolume - WSL
- url: https://wsl.dev/api-reference/c/storage-apis/wslcdeletesessionvhdvolume/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcdeletesessionvhdvolume)

WslcDeleteSessionVhdVolume

```
STDAPI WslcDeleteSessionVhdVolume(_In_ WslcSession session, _In_z_ PCSTR name, _Outptr_opt_result_z_ PWSTR* errorMessage);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| session |  WslcSession |  in |
| name |  PCSTR |  in |
| errorMessage |  PWSTR\* |  out, optional |

Return value: `HRESULT`.

Example:

```
HRESULT hr = WslcDeleteSessionVhdVolume(session, "cache", NULL);
```

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: Install and Version APIs - WSL
- url: https://wsl.dev/api-reference/c/install-and-version-apis/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#install-and-version-apis)

Install and Version APIs

Members

- [WslcGetMissingComponents](wslcgetmissingcomponents/)- [WslcGetVersion](wslcgetversion/)- [WslcInstallWithDependencies](wslcinstallwithdependencies/)

\--------------------------------------------------------------------------------

- title: WslcGetMissingComponents - WSL
- url: https://wsl.dev/api-reference/c/install-and-version-apis/wslcgetmissingcomponents/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcgetmissingcomponents)

WslcGetMissingComponents

```
STDAPI WslcGetMissingComponents(_Out_ WslcComponentFlags* missingComponents);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| missingComponents |  WslcComponentFlags\* |  out |

Return value: `HRESULT`.

Example:

```
WslcComponentFlags missingComponents = WSLC_COMPONENT_FLAG_NONE;
HRESULT hr = WslcGetMissingComponents(&missingComponents);
```

\--------------------------------------------------------------------------------

- title: WslcGetVersion - WSL
- url: https://wsl.dev/api-reference/c/install-and-version-apis/wslcgetversion/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcgetversion)

WslcGetVersion

```
STDAPI WslcGetVersion(_Out_writes_(1) WslcVersion* version);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| version |  WslcVersion\* |  out |

Return value: `HRESULT`.

Example:

```
WslcVersion version = { 0 };
HRESULT hr = WslcGetVersion(&version);
if (SUCCEEDED(hr))
{
    printf("%u.%u.%u\n", version.major, version.minor, version.revision);
}
```

\--------------------------------------------------------------------------------

- title: WslcInstallWithDependencies - WSL
- url: https://wsl.dev/api-reference/c/install-and-version-apis/wslcinstallwithdependencies/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcinstallwithdependencies)

WslcInstallWithDependencies

```
STDAPI WslcInstallWithDependencies(_In_opt_ WslcInstallCallback progressCallback, _In_opt_ PVOID context);
```

| Parameter |  Type |  Direction |
| --- | --- | --- |
| progressCallback |  WslcInstallCallback |  in, optional |
| context |  PVOID |  in, optional |

Return value: `HRESULT`.

Header note: callbacks are only made for components actively installed by this call. That list can be acquired beforehand with [WslcGetMissingComponents](wslcgetmissingcomponents/).

Example:

```
void CALLBACK OnInstallProgress(
    WslcComponentFlags component,
    uint32_t progressSteps,
    uint32_t totalSteps,
    PVOID context)
{
    UNREFERENCED_PARAMETER(context);
    printf("component=%u %u/%u\n", (unsigned)component, progressSteps, totalSteps);
}

HRESULT hr = WslcInstallWithDependencies(OnInstallProgress, NULL);
```

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: Enumerations - WSL
- url: https://wsl.dev/api-reference/c/enumerations/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#enumerations)

Enumerations

Members

- [WslcContainerNetworkingMode](wslccontainernetworkingmode/)- [WslcVhdType](wslcvhdtype/)- [WslcVhdRequirementsFlags](wslcvhdrequirementsflags/)- [WslcSessionFeatureFlags](wslcsessionfeatureflags/)- [WslcSessionTerminationReason](wslcsessionterminationreason/)- [WslcPortProtocol](wslcportprotocol/)- [WslcContainerFlags](wslccontainerflags/)- [WslcContainerStartFlags](wslccontainerstartflags/)- [WslcContainerState](wslccontainerstate/)- [WslcSignal](wslcsignal/)- [WslcDeleteContainerFlags](wslcdeletecontainerflags/)- [WslcProcessIOHandle](wslcprocessiohandle/)- [WslcProcessState](wslcprocessstate/)- [WslcImageProgressStatus](wslcimageprogressstatus/)- [WslcComponentFlags](wslccomponentflags/)

\--------------------------------------------------------------------------------

- title: WslcContainerNetworkingMode - WSL
- url: https://wsl.dev/api-reference/c/enumerations/wslccontainernetworkingmode/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslccontainernetworkingmode)

WslcContainerNetworkingMode

```
typedef enum WslcContainerNetworkingMode
{
    WSLC_CONTAINER_NETWORKING_MODE_NONE = 0, // No networking / isolated
    WSLC_CONTAINER_NETWORKING_MODE_BRIDGED = 1
} WslcContainerNetworkingMode;
```

| Enumerator |  Value |
| --- | --- |
| WSLC\_CONTAINER\_NETWORKING\_MODE\_NONE |  0 |
| WSLC\_CONTAINER\_NETWORKING\_MODE\_BRIDGED |  1 |

\--------------------------------------------------------------------------------

- title: WslcVhdType - WSL
- url: https://wsl.dev/api-reference/c/enumerations/wslcvhdtype/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcvhdtype)

WslcVhdType

```
typedef enum WslcVhdType
{
    WSLC_VHD_TYPE_DYNAMIC = 0, // Expanding VHDX (default)
    WSLC_VHD_TYPE_FIXED = 1    // Fixed-allocation VHDX (only honored by WslcCreateSessionVhdVolume)
} WslcVhdType;
```

| Enumerator |  Value |
| --- | --- |
| WSLC\_VHD\_TYPE\_DYNAMIC |  0 |
| WSLC\_VHD\_TYPE\_FIXED |  1 |

\--------------------------------------------------------------------------------

- title: WslcVhdRequirementsFlags - WSL
- url: https://wsl.dev/api-reference/c/enumerations/wslcvhdrequirementsflags/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcvhdrequirementsflags)

WslcVhdRequirementsFlags

```
typedef enum WslcVhdRequirementsFlags
{
    WSLC_VHD_REQ_FLAG_NONE = 0x00000000,
    WSLC_VHD_REQ_FLAG_OWNER = 0x00000001,
} WslcVhdRequirementsFlags;
```

| Enumerator |  Value |
| --- | --- |
| WSLC\_VHD\_REQ\_FLAG\_NONE |  0x00000000 |
| WSLC\_VHD\_REQ\_FLAG\_OWNER |  0x00000001 |

\--------------------------------------------------------------------------------

- title: WslcSessionFeatureFlags - WSL
- url: https://wsl.dev/api-reference/c/enumerations/wslcsessionfeatureflags/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsessionfeatureflags)

WslcSessionFeatureFlags

```
typedef enum WslcSessionFeatureFlags
{
    WSLC_SESSION_FEATURE_FLAG_NONE = 0x00000000,
    WSLC_SESSION_FEATURE_FLAG_ENABLE_GPU = 0x00000004
} WslcSessionFeatureFlags;
```

| Enumerator |  Value |
| --- | --- |
| WSLC\_SESSION\_FEATURE\_FLAG\_NONE |  0x00000000 |
| WSLC\_SESSION\_FEATURE\_FLAG\_ENABLE\_GPU |  0x00000004 |

\--------------------------------------------------------------------------------

- title: WslcSessionTerminationReason - WSL
- url: https://wsl.dev/api-reference/c/enumerations/wslcsessionterminationreason/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsessionterminationreason)

WslcSessionTerminationReason

```
typedef enum WslcSessionTerminationReason
{
    WSLC_SESSION_TERMINATION_REASON_UNKNOWN = 0,
    WSLC_SESSION_TERMINATION_REASON_SHUTDOWN = 1,
    WSLC_SESSION_TERMINATION_REASON_CRASHED = 2,
} WslcSessionTerminationReason;
```

| Enumerator |  Value |
| --- | --- |
| WSLC\_SESSION\_TERMINATION\_REASON\_UNKNOWN |  0 |
| WSLC\_SESSION\_TERMINATION\_REASON\_SHUTDOWN |  1 |
| WSLC\_SESSION\_TERMINATION\_REASON\_CRASHED |  2 |

\--------------------------------------------------------------------------------

- title: WslcPortProtocol - WSL
- url: https://wsl.dev/api-reference/c/enumerations/wslcportprotocol/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcportprotocol)

WslcPortProtocol

```
typedef enum WslcPortProtocol
{
    WSLC_PORT_PROTOCOL_TCP = 0,
    WSLC_PORT_PROTOCOL_UDP = 1
} WslcPortProtocol;
```

| Enumerator |  Value |
| --- | --- |
| WSLC\_PORT\_PROTOCOL\_TCP |  0 |
| WSLC\_PORT\_PROTOCOL\_UDP |  1 |

\--------------------------------------------------------------------------------

- title: WslcContainerFlags - WSL
- url: https://wsl.dev/api-reference/c/enumerations/wslccontainerflags/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslccontainerflags)

WslcContainerFlags

```
typedef enum WslcContainerFlags
{
    WSLC_CONTAINER_FLAG_NONE = 0x00000000,
    WSLC_CONTAINER_FLAG_AUTO_REMOVE = 0x00000001,
    WSLC_CONTAINER_FLAG_ENABLE_GPU = 0x00000002,
    WSLC_CONTAINER_FLAG_PRIVILEGED = 0x00000004,

} WslcContainerFlags;
```

| Enumerator |  Value |
| --- | --- |
| WSLC\_CONTAINER\_FLAG\_NONE |  0x00000000 |
| WSLC\_CONTAINER\_FLAG\_AUTO\_REMOVE |  0x00000001 |
| WSLC\_CONTAINER\_FLAG\_ENABLE\_GPU |  0x00000002 |
| WSLC\_CONTAINER\_FLAG\_PRIVILEGED |  0x00000004 |

\--------------------------------------------------------------------------------

- title: WslcContainerStartFlags - WSL
- url: https://wsl.dev/api-reference/c/enumerations/wslccontainerstartflags/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslccontainerstartflags)

WslcContainerStartFlags

```
typedef enum WslcContainerStartFlags
{
    WSLC_CONTAINER_START_FLAG_NONE = 0x00000000,
    WSLC_CONTAINER_START_FLAG_ATTACH = 0x00000001,

} WslcContainerStartFlags;
```

| Enumerator |  Value |
| --- | --- |
| WSLC\_CONTAINER\_START\_FLAG\_NONE |  0x00000000 |
| WSLC\_CONTAINER\_START\_FLAG\_ATTACH |  0x00000001 |

\--------------------------------------------------------------------------------

- title: WslcContainerState - WSL
- url: https://wsl.dev/api-reference/c/enumerations/wslccontainerstate/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslccontainerstate)

WslcContainerState

```
typedef enum WslcContainerState
{
    WSLC_CONTAINER_STATE_INVALID = 0,
    WSLC_CONTAINER_STATE_CREATED = 1,
    WSLC_CONTAINER_STATE_RUNNING = 2,
    WSLC_CONTAINER_STATE_EXITED = 3,
    WSLC_CONTAINER_STATE_DELETED = 4,
} WslcContainerState;
```

| Enumerator |  Value |
| --- | --- |
| WSLC\_CONTAINER\_STATE\_INVALID |  0 |
| WSLC\_CONTAINER\_STATE\_CREATED |  1 |
| WSLC\_CONTAINER\_STATE\_RUNNING |  2 |
| WSLC\_CONTAINER\_STATE\_EXITED |  3 |
| WSLC\_CONTAINER\_STATE\_DELETED |  4 |

\--------------------------------------------------------------------------------

- title: WslcSignal - WSL
- url: https://wsl.dev/api-reference/c/enumerations/wslcsignal/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcsignal)

WslcSignal

```
typedef enum WslcSignal
{
    WSLC_SIGNAL_NONE = 0,     // No signal; reserved for future use
    WSLC_SIGNAL_SIGHUP = 1,   // SIGHUP: reload / hangup
    WSLC_SIGNAL_SIGINT = 2,   // SIGINT: interrupt (Ctrl-C)
    WSLC_SIGNAL_SIGQUIT = 3,  // SIGQUIT: quit with core dump
    WSLC_SIGNAL_SIGKILL = 9,  // SIGKILL: immediate termination
    WSLC_SIGNAL_SIGTERM = 15, // SIGTERM: graceful shutdown
} WslcSignal;
```

| Enumerator |  Value |
| --- | --- |
| WSLC\_SIGNAL\_NONE |  0 |
| WSLC\_SIGNAL\_SIGHUP |  1 |
| WSLC\_SIGNAL\_SIGINT |  2 |
| WSLC\_SIGNAL\_SIGQUIT |  3 |
| WSLC\_SIGNAL\_SIGKILL |  9 |
| WSLC\_SIGNAL\_SIGTERM |  15 |

\--------------------------------------------------------------------------------

- title: WslcDeleteContainerFlags - WSL
- url: https://wsl.dev/api-reference/c/enumerations/wslcdeletecontainerflags/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcdeletecontainerflags)

WslcDeleteContainerFlags

```
typedef enum WslcDeleteContainerFlags
{
    WSLC_DELETE_CONTAINER_FLAG_NONE = 0,
    WSLC_DELETE_CONTAINER_FLAG_FORCE = 0x01
} WslcDeleteContainerFlags;
```

| Enumerator |  Value |
| --- | --- |
| WSLC\_DELETE\_CONTAINER\_FLAG\_NONE |  0 |
| WSLC\_DELETE\_CONTAINER\_FLAG\_FORCE |  0x01 |

\--------------------------------------------------------------------------------

- title: WslcProcessIOHandle - WSL
- url: https://wsl.dev/api-reference/c/enumerations/wslcprocessiohandle/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcprocessiohandle)

WslcProcessIOHandle

```
typedef enum WslcProcessIOHandle
{
    WSLC_PROCESS_IO_HANDLE_STDIN = 0,
    WSLC_PROCESS_IO_HANDLE_STDOUT = 1,
    WSLC_PROCESS_IO_HANDLE_STDERR = 2
} WslcProcessIOHandle;
```

| Enumerator |  Value |
| --- | --- |
| WSLC\_PROCESS\_IO\_HANDLE\_STDIN |  0 |
| WSLC\_PROCESS\_IO\_HANDLE\_STDOUT |  1 |
| WSLC\_PROCESS\_IO\_HANDLE\_STDERR |  2 |

\--------------------------------------------------------------------------------

- title: WslcProcessState - WSL
- url: https://wsl.dev/api-reference/c/enumerations/wslcprocessstate/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcprocessstate)

WslcProcessState

```
typedef enum WslcProcessState
{
    WSLC_PROCESS_STATE_UNKNOWN = 0,
    WSLC_PROCESS_STATE_RUNNING = 1,
    WSLC_PROCESS_STATE_EXITED = 2,
    WSLC_PROCESS_STATE_SIGNALLED = 3
} WslcProcessState;
```

| Enumerator |  Value |
| --- | --- |
| WSLC\_PROCESS\_STATE\_UNKNOWN |  0 |
| WSLC\_PROCESS\_STATE\_RUNNING |  1 |
| WSLC\_PROCESS\_STATE\_EXITED |  2 |
| WSLC\_PROCESS\_STATE\_SIGNALLED |  3 |

\--------------------------------------------------------------------------------

- title: WslcImageProgressStatus - WSL
- url: https://wsl.dev/api-reference/c/enumerations/wslcimageprogressstatus/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslcimageprogressstatus)

WslcImageProgressStatus

```
typedef enum WslcImageProgressStatus
{
    WSLC_IMAGE_PROGRESS_STATUS_UNKNOWN = 0,
    WSLC_IMAGE_PROGRESS_STATUS_PULLING = 1,     // "Pulling fs layer"
    WSLC_IMAGE_PROGRESS_STATUS_WAITING = 2,     // "Waiting"
    WSLC_IMAGE_PROGRESS_STATUS_DOWNLOADING = 3, // "Downloading"
    WSLC_IMAGE_PROGRESS_STATUS_VERIFYING = 4,   // "Verifying Checksum"
    WSLC_IMAGE_PROGRESS_STATUS_EXTRACTING = 5,  // "Extracting"
    WSLC_IMAGE_PROGRESS_STATUS_COMPLETE = 6     // "Pull complete"
} WslcImageProgressStatus;
```

| Enumerator |  Value |
| --- | --- |
| WSLC\_IMAGE\_PROGRESS\_STATUS\_UNKNOWN |  0 |
| WSLC\_IMAGE\_PROGRESS\_STATUS\_PULLING |  1 |
| WSLC\_IMAGE\_PROGRESS\_STATUS\_WAITING |  2 |
| WSLC\_IMAGE\_PROGRESS\_STATUS\_DOWNLOADING |  3 |
| WSLC\_IMAGE\_PROGRESS\_STATUS\_VERIFYING |  4 |
| WSLC\_IMAGE\_PROGRESS\_STATUS\_EXTRACTING |  5 |
| WSLC\_IMAGE\_PROGRESS\_STATUS\_COMPLETE |  6 |

\--------------------------------------------------------------------------------

- title: WslcComponentFlags - WSL
- url: https://wsl.dev/api-reference/c/enumerations/wslccomponentflags/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#wslccomponentflags)

WslcComponentFlags

```
typedef enum WslcComponentFlags
{
    WSLC_COMPONENT_FLAG_NONE = 0,
    WSLC_COMPONENT_FLAG_VIRTUAL_MACHINE_PLATFORM = 1,
    WSLC_COMPONENT_FLAG_WSL_PACKAGE = 2,
    WSLC_COMPONENT_FLAG_SDK_NEEDS_UPDATE = 4,
} WslcComponentFlags;
```

| Enumerator |  Value |
| --- | --- |
| WSLC\_COMPONENT\_FLAG\_NONE |  0 |
| WSLC\_COMPONENT\_FLAG\_VIRTUAL\_MACHINE\_PLATFORM |  1 |
| WSLC\_COMPONENT\_FLAG\_WSL\_PACKAGE |  2 |
| WSLC\_COMPONENT\_FLAG\_SDK\_NEEDS\_UPDATE |  4 |

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: Error Codes - WSL
- url: https://wsl.dev/api-reference/c/error-codes/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#error-codes)

Error Codes

```
#define WSLC_E_BASE (0x0600)
#define WSLC_E_IMAGE_NOT_FOUND MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, WSLC_E_BASE + 1)             /* 0x80040601 */
#define WSLC_E_CONTAINER_PREFIX_AMBIGUOUS MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, WSLC_E_BASE + 2)  /* 0x80040602 */
#define WSLC_E_CONTAINER_NOT_FOUND MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, WSLC_E_BASE + 3)         /* 0x80040603 */
#define WSLC_E_VOLUME_NOT_FOUND MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, WSLC_E_BASE + 4)            /* 0x80040604 */
#define WSLC_E_CONTAINER_NOT_RUNNING MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, WSLC_E_BASE + 5)       /* 0x80040605 */
#define WSLC_E_CONTAINER_IS_RUNNING MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, WSLC_E_BASE + 6)        /* 0x80040606 */
#define WSLC_E_SESSION_RESERVED MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, WSLC_E_BASE + 7)            /* 0x80040607 */
#define WSLC_E_INVALID_SESSION_NAME MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, WSLC_E_BASE + 8)        /* 0x80040608 */
#define WSLC_E_NETWORK_NOT_FOUND MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, WSLC_E_BASE + 9)           /* 0x80040609 */
#define WSLC_E_WU_SEARCH_FAILED MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, WSLC_E_BASE + 10)           /* 0x8004060A */
#define WSLC_E_SDK_UPDATE_NEEDED MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, WSLC_E_BASE + 11)          /* 0x8004060B */
#define WSLC_E_CONTAINER_DISABLED MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, WSLC_E_BASE + 12)         /* 0x8004060C */
#define WSLC_E_REGISTRY_BLOCKED_BY_POLICY MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, WSLC_E_BASE + 13) /* 0x8004060D */
#define WSLC_E_VOLUME_NOT_AVAILABLE MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, WSLC_E_BASE + 14)       /* 0x8004060E */
#define WSLC_E_SESSION_NOT_FOUND MAKE_HRESULT(SEVERITY_ERROR, FACILITY_ITF, WSLC_E_BASE + 15)          /* 0x8004060F */
```

| Symbol |  Hex Value |
| --- | --- |
| WSLC\_E\_BASE |  0x0600 |
| WSLC\_E\_IMAGE\_NOT\_FOUND |  0x80040601 |
| WSLC\_E\_CONTAINER\_PREFIX\_AMBIGUOUS |  0x80040602 |
| WSLC\_E\_CONTAINER\_NOT\_FOUND |  0x80040603 |
| WSLC\_E\_VOLUME\_NOT\_FOUND |  0x80040604 |
| WSLC\_E\_CONTAINER\_NOT\_RUNNING |  0x80040605 |
| WSLC\_E\_CONTAINER\_IS\_RUNNING |  0x80040606 |
| WSLC\_E\_SESSION\_RESERVED |  0x80040607 |
| WSLC\_E\_INVALID\_SESSION\_NAME |  0x80040608 |
| WSLC\_E\_NETWORK\_NOT\_FOUND |  0x80040609 |
| WSLC\_E\_WU\_SEARCH\_FAILED |  0x8004060A |
| WSLC\_E\_SDK\_UPDATE\_NEEDED |  0x8004060B |
| WSLC\_E\_CONTAINER\_DISABLED |  0x8004060C |
| WSLC\_E\_REGISTRY\_BLOCKED\_BY\_POLICY |  0x8004060D |
| WSLC\_E\_VOLUME\_NOT\_AVAILABLE |  0x8004060E |
| WSLC\_E\_SESSION\_NOT\_FOUND |  0x8004060F |

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: Not Yet Implemented APIs - WSL
- url: https://wsl.dev/api-reference/c/not-yet-implemented-apis/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#not-yet-implemented-apis)

Not Yet Implemented APIs

The following APIs or features are **not yet implemented** and will return **E\_NOTIMPL** when called. This list is provided so callers can plan accordingly:

| API / Feature |  Details |
| --- | --- |
| **WslcSetContainerSettingsPortMappings** — UDP protocol |  Only **TCP** (WSLC\_PORT\_PROTOCOL\_TCP) is supported. Passing WSLC\_PORT\_PROTOCOL\_UDP returns E\_NOTIMPL. |
| **WslcCreateSessionVhdVolume** / **WslcSetSessionSettingsVhd** — fixed VHD type |  Only **dynamic** VHDs (WSLC\_VHD\_TYPE\_DYNAMIC) are supported. Passing WSLC\_VHD\_TYPE\_FIXED returns E\_NOTIMPL. |

\--------------------------------------------------------------------------------

\--------------------------------------------------------------------------------

- title: End-to-End Example - WSL
- url: https://wsl.dev/api-reference/c/end-to-end-example/
- date: 2026-07-15T19:09:52.295Z
- parsing method: defuddle

[Skip to content](#end-to-end-example)

End-to-End Example

The example below shows one full lifecycle:

- Initialize session settings- Create a session- Pull an image- Configure a container- Create and start the container- Inspect it- Create a second process- Stop and delete the container- Release handles and terminate the session

```
#include <winsock2.h>
#include <windows.h>
#include <stdio.h>
#include <objbase.h>
#include <filesystem>
#include "wslcsdk.h"

#pragma comment(lib, "ole32.lib")
#pragma comment(lib, "wslcsdk.lib")

int main()
{
    // Initialize COM
    CoInitializeEx(nullptr, COINIT_MULTITHREADED);

    HRESULT hr;
    PWSTR error = nullptr;

    // 0. Check prerequisites
    WslcComponentFlags missing = WSLC_COMPONENT_FLAG_NONE;
    hr = WslcGetMissingComponents(&missing);
    if (FAILED(hr) || missing != WSLC_COMPONENT_FLAG_NONE) {
        printf("WSL components are missing. Run: wsl --install\n");
        CoUninitialize();
        return 1;
    }

    WslcVersion ver = {};
    WslcGetVersion(&ver);
    printf("WSL version: %u.%u.%u\n", ver.major, ver.minor, ver.revision);

    // 1. Initialize and create a session
    std::filesystem::path storagePath = std::filesystem::current_path();

    WslcSessionSettings sessionSettings;
    hr = WslcInitSessionSettings(L"MyApp", storagePath.c_str(), &sessionSettings);
    if (FAILED(hr)) return 1;

    // Optionally customize resources
    WslcSetSessionSettingsCpuCount(&sessionSettings, 4);
    WslcSetSessionSettingsMemory(&sessionSettings, 4096);

    WslcSession session = nullptr;
    hr = WslcCreateSession(&sessionSettings, &session, &error);
    if (FAILED(hr)) {
        wprintf(L"Session creation failed: %s\n", error ? error : L"unknown");
        CoTaskMemFree(error);
        CoUninitialize();
        return 1;
    }

    // 2. Pull an image
    WslcPullImageOptions pullOpts = {};
    pullOpts.uri = "docker.io/library/alpine:latest";
    hr = WslcPullSessionImage(session, &pullOpts, &error);
    if (FAILED(hr)) {
        wprintf(L"Pull failed: %s\n", error ? error : L"unknown");
        CoTaskMemFree(error);
        WslcTerminateSession(session);
        WslcReleaseSession(session);
        CoUninitialize();
        return 1;
    }

    // 3. Configure an init process
    WslcProcessSettings initProcSettings;
    WslcInitProcessSettings(&initProcSettings);

    PCSTR argv[] = { "/bin/echo", "Hello from WSL Container!" };
    WslcSetProcessSettingsCmdLine(&initProcSettings, argv, 2);

    // 4. Configure and create a container
    WslcContainerSettings containerSettings;
    WslcInitContainerSettings("alpine:latest", &containerSettings);
    WslcSetContainerSettingsName(&containerSettings, "hello-container");
    WslcSetContainerSettingsInitProcess(&containerSettings, &initProcSettings);

    WslcContainer container = nullptr;
    hr = WslcCreateContainer(session, &containerSettings, &container, &error);
    if (FAILED(hr)) {
        wprintf(L"Container creation failed: %s\n", error ? error : L"unknown");
        CoTaskMemFree(error);
        WslcTerminateSession(session);
        WslcReleaseSession(session);
        CoUninitialize();
        return 1;
    }

    // 5. Start the container
    hr = WslcStartContainer(container, WSLC_CONTAINER_START_FLAG_NONE, &error);
    if (FAILED(hr)) {
        wprintf(L"Start failed: %s\n", error ? error : L"unknown");
        CoTaskMemFree(error);
        WslcDeleteContainer(container, WSLC_DELETE_CONTAINER_FLAG_FORCE, nullptr);
        WslcReleaseContainer(container);
        WslcTerminateSession(session);
        WslcReleaseSession(session);
        CoUninitialize();
        return 1;
    }

    // 6. Wait for the init process to exit
    WslcProcess initProc = nullptr;
    hr = WslcGetContainerInitProcess(container, &initProc);
    if (SUCCEEDED(hr)) {
        HANDLE exitEvent = nullptr;
        if (SUCCEEDED(WslcGetProcessExitEvent(initProc, &exitEvent))) {
            WaitForSingleObject(exitEvent, 30000); // 30-second timeout
        }

        INT32 exitCode = 0;
        if (SUCCEEDED(WslcGetProcessExitCode(initProc, &exitCode))) {
            printf("Process exited with code: %d\n", exitCode);
        }
        WslcReleaseProcess(initProc);
    }

    // 7. Clean up
    WslcContainerState containerState = WSLC_CONTAINER_STATE_INVALID;
    if (SUCCEEDED(WslcGetContainerState(container, &containerState)) &&
        containerState == WSLC_CONTAINER_STATE_RUNNING) {
        WslcStopContainer(container, WSLC_SIGNAL_SIGTERM, 10, nullptr);
    }
    WslcDeleteContainer(container, WSLC_DELETE_CONTAINER_FLAG_NONE, nullptr);
    WslcReleaseContainer(container);
    WslcTerminateSession(session);
    WslcReleaseSession(session);

    CoUninitialize();
    return 0;
}
```
