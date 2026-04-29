# TOAD — Oracle Database Launcher

[Toad for Oracle](https://www.quest.com/products/toad-for-oracle/) is a database client commonly used by Oracle DBAs. There's no out-of-the-box launcher on the **Oracle Account** template; this example adds one.

The install path differs based on whether the Quest subscription edition or the older Dell-branded suite is installed. Pick whichever matches the environment.

## Variant 1 — Quest subscription edition

| Launcher field | Value |
|---|---|
| Launcher Type | Process |
| Process Name | `C:\Program Files\Quest Software\Toad for Oracle Subscription\toad.exe` |
| Process Arguments | `-C $USERNAME/$PASSWORD@$Server:1522/$Database` |

## Variant 2 — Dell / Toad 12.9

| Launcher field | Value |
|---|---|
| Launcher Type | Process |
| Process Name | `C:\Program Files\Dell\Toad for Oracle 2016 Suite\Toad for Oracle 12.9\toad.exe` |
| Process Arguments | `-C $USERNAME/$PASSWORD@$Server:1522/$Database` |

## Template fields

Beyond the **Oracle Account** template's defaults, add:

- `Server` (Text) — Oracle DB hostname or VIP
- `Database` (Text) — service name / SID

Port `1522` is hard-coded in **Process Arguments**. If port varies across environments, add a `Port` field and replace `1522` with `$Port`.
