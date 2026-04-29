# SecureCRT

Two SecureCRT launcher variants: one for installs in `%localappdata%`, one routed through an SSH proxy.

## Variant 1 — Installed in `%localappdata%`

| Launcher field | Value |
|---|---|
| Launcher Type | Batch File |
| Batch contents | `/c start %localappdata%\"VanDyke Software"\SecureCRT\SecureCRT.exe /NOSAVE /SSH2 $MACHINE /L $USERNAME /PASSWORD "$PASSWORD"` |

If you'd rather configure this as a Process launcher rather than a batch file, set:

```text
Process Name:      cmd.exe
Process Arguments: /c start "%localappdata%\VanDyke Software\SecureCRT\SecureCRT.exe" /NOSAVE /SSH2 $MACHINE /L $USERNAME /PASSWORD "$PASSWORD"
```

## Variant 2 — SSH Proxy

| Launcher field | Value |
|---|---|
| Process Name | `c:\program files\vandyke software\clients\securecrt.exe` |
| Process Arguments | `/SSH2 /AUTH keyboard-interactive /PASSWORD $PASSWORD /P $PORT /L $USERNAME $HOST` |

Add **Port** and **Host** as custom fields on the secret template if they aren't already present.
