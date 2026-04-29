# RDP Launcher with `/RestrictedAdmin`

Launches `mstsc` with credentials staged in Windows Credential Manager, paired with [RDP Restricted Admin mode](https://learn.microsoft.com/troubleshoot/windows-server/remote/restricted-admin-mode-for-rdp) on the destination so a password derived from the secret is never sent over the wire.

> [!WARNING]
> **Security caveat.** This launcher uses RDP Restricted Admin mode, which is **less secure** than not exposing the password at all — as with any custom launcher that passes a `$PASSWORD` variable, the password can be observed via Process Monitor or similar tools. Only use this when:
>
> - You have a business reason to expose the password in Secret Server, **and**
> - Group policy prevents users from reusing those credentials elsewhere, **and**
> - You access Secret Server's web UI from a locked-down jump host, **and**
> - You change the password after each use.
>
> Even with one-time-use passwords, the password can be observed for the duration of the session, enabling lateral movement if the jump host itself is compromised.

## Prerequisite — enable Restricted Admin on the destination

On each destination system, set:

```
HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa
    DisableRestrictedAdmin (DWORD) = 0
```

(`DisableRestrictedAdmin = 0` means Restricted Admin mode is allowed.)

## Launcher

| Launcher field | Value |
|---|---|
| Launcher Type | Process |
| Process Name | `powershell.exe` |
| Process Arguments | (see below) |
| Run Process As Secret Credentials | No |
| Load User Profile | No |
| Use Operating System Shell | No |

```powershell
cmdkey /generic:"$DOMAIN" /user:"$USERNAME" /pass:"$PASSWORD"; Start-Process -FilePath "C:\Windows\System32\mstsc.exe" -ArgumentList "/v:$DOMAIN"; Start-Sleep -s 30; cmdkey /delete:$DOMAIN
```

What each step does:

1. `cmdkey /generic:...` — stages the secret's username and password in Windows Credential Manager keyed by `$DOMAIN`.
2. `Start-Process mstsc.exe /v:$DOMAIN` — launches RDP to the host. Windows pulls the just-stored credentials from Credential Manager.
3. `Start-Sleep -s 30` — waits 30 seconds so the user has time to accept the RDP connection prompt.
4. `cmdkey /delete:$DOMAIN` — removes the staged credentials from Credential Manager.

## Template

Associate this launcher with the **Windows Account** template — Restricted Admin mode requires Administrator rights on the destination, so it makes sense to scope this to administrative secrets only.

## Advanced configuration setting

In Secret Server's **Advanced Configuration**, set:

```
RDP Launcher Use Computer Name for Domain   True
```

(Enabled by default in modern releases.)
