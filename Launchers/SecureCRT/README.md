# SecureCRT

Two SecureCRT launcher variants: one for installs in `%localappdata%`, one routed through an SSH proxy.

## Variant 1 — Installed in `%localappdata%`

Process launcher that shells through `cmd.exe` so `%localappdata%` is expanded by the shell before `start` resolves the SecureCRT path.

| Launcher field | Value |
|---|---|
| Launcher Type | Process |
| Process Name | `cmd.exe` |
| Process Arguments | `/c start "%localappdata%\VanDyke Software\SecureCRT\SecureCRT.exe" /NOSAVE /SSH2 $MACHINE /L $USERNAME /PASSWORD "$PASSWORD"` |

The double quotes around the SecureCRT install path matter — they handle the space in *VanDyke Software*.

## Variant 2 — SSH Proxy

| Launcher field | Value |
|---|---|
| Process Name | `c:\program files\vandyke software\clients\securecrt.exe` |
| Process Arguments | `/SSH2 /AUTH keyboard-interactive /PASSWORD $PASSWORD /P $PORT /L $USERNAME $HOST` |

Add **Port** and **Host** as custom fields on the secret template if they aren't already present.
