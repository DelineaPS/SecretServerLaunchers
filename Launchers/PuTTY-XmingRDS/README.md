# XMing X Server + PuTTY + X11 Forwarding (RDS multi-user)

X11 forwarding requires an instance of the X server (with its own display number) for each concurrent user. On Remote Desktop Services hosts where multiple users land, this means starting a per-session XMing instance before launching PuTTY.

A helper script (`launch_xming.ps1`, expected at `C:\Tools\launch_xming.ps1`) does the per-user XMing startup. The PDF source notes the script needs to be obtained separately and is not bundled.

> [!NOTE]
> The `launch_xming.ps1` helper script is not included here. Author it for your environment to: pick a free display number, start `Xming.exe :<n> -multiwindow -clipboard` for the current session, set `DISPLAY` accordingly, then call `putty.exe -ssh "$user"@"$host" -pw "$pw" -X`.

## Launcher configuration

| Launcher field | Value |
|---|---|
| Launcher Name | `SAP XMING X11 Fwd SSH non-proxied` |
| Active | Yes |
| Wrap custom parameters with quotation marks | Yes |
| Record Multiple Windows | Yes |
| Record Additional Processes | `xming.exe` |
| Process Name | `powershell.exe` |
| Process Arguments | `-file C:\tools\launch_xming.ps1 $MACHINE $USERNAME $PASSWORD` |
| Run Process As Secret Credentials | No |
| Load User Profile | No |
| Use Operating System Shell | No |

Adjust the script path if you place it somewhere other than `C:\Tools`.
