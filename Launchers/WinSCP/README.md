# WinSCP

[WinSCP](https://winscp.net/) launcher variants — a private-key SCP launcher and an SFTP launcher routed through an SSH proxy.

## Variant 1 — Private key (SCP)

| Launcher field | Value |
|---|---|
| Launcher Name | `WinSCP private key` |
| Launcher Type | Process |
| Active | Yes |
| Process Name | `"C:\Program Files (x86)\WinSCP\WinSCP.exe"` |
| Process Arguments | `scp://"$USERNAME"@$MACHINE /privatekey="$PRIVATE KEY" /log="C:\Users\administrator.TESTDOMAIN\Desktop\winscp2.log"` |
| Use Operating System Shell | No |

Replace the `/log=` path with one writable by the user running the launcher.

### Template fields

Add a custom field named `PRIVATE KEY` (file contents of the private key) on the secret template — populate from a generated SSH key on the target host.

## Variant 2 — SFTP through an SSH proxy

| Launcher field | Value |
|---|---|
| Launcher Name | `WinSCP Proxied Process` |
| Launcher Type | Process |
| Active | Yes |
| Wrap custom parameters with quotation marks | No |
| Process Name | `C:\Program Files (x86)\WinSCP\WinSCP.exe` |
| Process Arguments | `$USERNAME:$PASSWORD@$HOST:$PORT` |
| Use Operating System Shell | No |

### Template launcher mapping

| Field | Map to |
|---|---|
| Host | Machine |
| Password | Password |
| Port | `<use default>` (default value `22`) |
| Username | Username |

### WinSCP advanced site settings (set once in WinSCP itself)

After connecting, open **Advanced Site Settings** in the WinSCP login dialog and set:

| Section | Field | Value |
|---|---|---|
| Environment → Shell | Shell | `/bin/bash` |
| Environment → Shell | Return code variable | `Autodetect` |

These are stored per-site in WinSCP and don't go into the Secret Server launcher.
