# UltraVNC

Launches UltraVNC's `vncviewer.exe`, passing username/password and connecting to the secret's machine. Two variants documented for the two common install paths.

## Variant 1 — Standard install

| Launcher field | Value |
|---|---|
| Launcher Name | `VNC` |
| Active | Yes |
| Process Name | `C:\Program Files (x86)\UltraVNC\vncviewer.exe` |
| Process Arguments | `/user $USERNAME /password $PASSWORD -connect $MACHINE` |
| Run Process As Secret Credentials | No |
| Load User Profile | No |
| Use Operating System Shell | No |

## Variant 2 — `uvnc bvba` install

| Launcher field | Value |
|---|---|
| Launcher Name | `Ultra VNC Launcher` |
| Wrap custom parameters with quotation marks | Yes |
| Record Multiple Windows | Yes |
| Process Name | `"C:\Program Files\uvnc bvba\UltraVNC\vncviewer.exe"` |
| Process Arguments | `/user $USERNAME /password $PASSWORD -connect $MACHINE` |
| Run Process As Secret Credentials | No |
| Load User Profile | No |
| Use Operating System Shell | No |
