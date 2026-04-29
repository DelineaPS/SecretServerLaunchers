# Inbuilt PuTTY Launcher + X11 Forwarding

Wraps the PuTTY that ships with the Secret Server Protocol Handler so X11 forwarding (`-X`) is enabled — the built-in PuTTY launcher does not enable this by default.

Two flavors depending on whether the connection is direct or proxied.

## Variant 1 — Non-proxied (direct)

| Launcher field | Value |
|---|---|
| Process Name | `"C:\Program Files\Thycotic Software Ltd\Secret Server Protocol Handler\putty.exe"` |
| Process Arguments | `-ssh "$USERNAME"@"$MACHINE" -pw $PASSWORD -X` |

## Variant 2 — Proxied

| Launcher field | Value |
|---|---|
| Process Name | `"C:\Program Files\Thycotic Software Ltd\Secret Server Protocol Handler\putty.exe"` |
| Process Arguments | `-ssh "$USERNAME"@"$HOST" -pw $PASSWORD -X` |

The proxied variant uses `$HOST` instead of `$MACHINE` because the SSH proxy session sets `$HOST` to the destination while `$MACHINE` is set to the proxy. Add **Host** as a custom field on the secret template if needed.
