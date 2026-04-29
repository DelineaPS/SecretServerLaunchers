# RDP Launcher with `/RestrictedAdmin`

Launches `mstsc` with credentials staged in Windows Credential Manager so the password is never sent to the destination, paired with RDP Restricted Admin mode on the destination.

> [!WARNING]
> **Security note from the source document.** This method utilizes RDP Restricted Admin mode, which is **less secure** than not exposing the password at all — as is the case for any custom launcher that passes a `$password` variable, the password can be exposed via Process Monitor or other tools. Only use this when:
>
> - You have a business reason to expose the password in Secret Server, **and**
> - You enforce via group policy that users cannot reuse those credentials elsewhere, **and**
> - You access Secret Server's web UI from a locked-down jump host, **and**
> - You change the password after each use.
>
> Even with one-time-use passwords, the password can be exposed via Process Monitor for the duration of the session, enabling lateral movement if the jump host itself is compromised.

## Pre-requisite — enable Restricted Admin on the destination

On each destination system, set:

```
HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa
    DisableRestrictedAdmin (DWORD) = 0
```

(`DisableRestrictedAdmin` value of `0` means Restricted Admin mode is allowed.)

## Launcher

| Launcher field | Value |
|---|---|
| Launcher Type | PowerShell |
| Process Arguments | (see below) |

```powershell
cmdkey /generic:"$domain" /user:"$username" /pass:"$password"; Start-Process -FilePath "C:\Windows\System32\mstsc.exe" -ArgumentList "/v:$domain"; Start-Sleep -s 30; cmdkey /delete:$domain"
```

What each step does:

1. `cmdkey /generic:...` — stages the secret's username and password in Windows Credential Manager keyed by `$domain`.
2. `Start-Process mstsc.exe /v:$domain` — launches RDP to the host. Windows pulls the just-stored credentials from Credential Manager.
3. `Start-Sleep -s 30` — waits 30 seconds so the user has time to accept the RDP connection prompt.
4. `cmdkey /delete:$domain` — removes the staged credentials from Credential Manager.

## Template

Associate this launcher with the **Windows Account** template — Restricted Admin mode requires Administrator rights on the destination, so it makes sense to scope this to administrative secrets only.

## Advanced configuration setting

In Secret Server's **Advanced Configuration**, set:

```
RDP Launcher Use Computer Name for Domain   True
```

(Should be enabled by default in modern releases.)
