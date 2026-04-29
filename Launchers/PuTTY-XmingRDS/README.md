# XMing X Server + PuTTY + X11 Forwarding (RDS multi-user)

X11 forwarding requires an instance of the X server (with its own display number) for each concurrent user. On Remote Desktop Services hosts where multiple users land, this means starting a per-session XMing instance before launching PuTTY.

The bundled [`launch_xming.ps1`](launch_xming.ps1) handles the per-user XMing startup. It picks a free X display, sets `$env:DISPLAY`, launches `Xming.exe`, then opens `putty.exe` against the requested host with `-X` to forward X11.

## Helper script

Save [`launch_xming.ps1`](launch_xming.ps1) to `C:\Tools\` (or any other directory accessible to the launching process) on each host that runs the launcher.

What the script does:

1. Reads `param($machine, $username, $password)` passed by the launcher.
2. Greets with a banner.
3. Reads `netstat -an` to find the lowest-numbered free TCP port in the X11 range (6000+) — that becomes the next free X display.
4. Sets `$env:DISPLAY = ":<n>"`.
5. Starts `C:\Program Files (x86)\Xming\Xming.exe :<n> -multiwindow -clipboard`.
6. Starts `C:\tools\putty.exe -X -ssh $machine -l $username -pw $password`.

Adjust the hard-coded paths at the bottom of the script if your XMing or PuTTY installs are elsewhere.

## Template

The built-in **Unix Account (SSH)** template works directly. The Internal source recommends duplicating it and naming it something like **Unix Account (SSH) – X11 Xming** so the launcher only attaches to secrets where X11 forwarding is wanted.

## Create launcher

| Launcher field | Value |
|---|---|
| Launcher Name | `XMING X11 Fwd SSH Non-Proxied` |
| Active | Yes |
| Wrap custom parameters with quotation marks | Yes |
| Record Multiple Windows | Yes |
| Record Additional Processes | `xming.exe` |
| Process Name | `powershell.exe` |
| Process Arguments | `-file C:\tools\launch_xming.ps1 $MACHINE $USERNAME $PASSWORD` |
| Run Process As Secret Credentials | No |
| Load User Profile | No |
| Use Operating System Shell | No |

Adjust the script path in **Process Arguments** if you placed `launch_xming.ps1` somewhere other than `C:\Tools`.

## Configure template launcher

1. **Admin → Secret Templates** → pick the SSH template (or your duplicated one) → **Edit**.
2. **Configure Launcher** — remove any existing launcher.
3. **Add New Launcher**.
4. **Launcher Type to use**: `XMING X11 Fwd SSH Non-Proxied`.
5. Map fields:
   - **Machine** → Machine
   - **Password** → Password
   - **Username** → Username
6. Click **Save**.

Test on an RDS host with two users connected simultaneously to confirm each user gets their own X display number.
