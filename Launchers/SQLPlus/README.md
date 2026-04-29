# SQL\*Plus — Oracle Database Launcher

[SQL\*Plus](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqpug/) is Oracle's command-line database client. As with [TOAD](../TOAD), there's no out-of-the-box launcher on the **Oracle Account** template, so this adds one.

SQL\*Plus is typically installed under `C:\apps\<username>\` (the user who installed it). The installer adds `sqlplus.exe` to `PATH`, so the launcher can call it by name without a full path.

## Launcher

| Launcher field | Value |
|---|---|
| Launcher Type | Process |
| Process Name | `sqlplus.exe` |
| Process Arguments | `$USERNAME/$PASSWORD@$Server:1522/$Database` |

## Template fields

Beyond the **Oracle Account** template's defaults, add:

- `Server` (Text) — Oracle DB hostname or VIP
- `Database` (Text) — service name / SID

Port `1522` is hard-coded in **Process Arguments**. If port varies across environments, add a `Port` field and replace `1522` with `$Port`.
