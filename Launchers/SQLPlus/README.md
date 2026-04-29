# SQL\*Plus — Oracle Database Launcher

SQL\*Plus is Oracle's command-line database client. As with [TOAD](../TOAD), there's no out-of-the-box launcher on the **Oracle Account** template, so this adds one.

SQL\*Plus is generally installed under `C:\apps\<username>\` (the user who installed it), but the installer adds it to the `PATH`, so you can usually call `sqlplus.exe` directly without specifying the full path.

| Launcher field | Value |
|---|---|
| Process Name | `sqlplus.exe` |
| Process Arguments | `$username/$password@$Server:1522/$database` |

## Template fields

Beyond the Oracle Account template's defaults:

- `Server` — Oracle DB hostname or VIP
- `database` — service name / SID
- (Port `1522` is hard-coded. Replace with `$Port` and add a `Port` field if it varies across environments.)
