# TOAD — Oracle Database Launcher

Toad for Oracle is a database client commonly used by Oracle DBAs. There's no out-of-the-box launcher on the **Oracle Account** template; this example adds one.

The install path differs based on whether you have Quest's subscription edition or the older Dell-branded suite. Pick whichever matches your environment.

## Launcher (Quest subscription)

| Launcher field | Value |
|---|---|
| Process Name | `C:\Program Files\Quest Software\Toad for Oracle Subscription\toad.exe` |
| Process Arguments | `-C $username/$password@$Server:1522/$database` |

## Launcher (Dell / Toad 12.9)

| Launcher field | Value |
|---|---|
| Process Name | `C:\Program Files\Dell\Toad for Oracle 2016 Suite\Toad for Oracle 12.9\toad.exe` |
| Process Arguments | `-C $username/$password@$Server:1522/$database` |

## Template fields

Beyond the Oracle Account template's defaults you'll need:

- `Server` — Oracle DB hostname or VIP
- `database` — service name / SID
- (Port `1522` is hard-coded in the example. Add a `Port` field and replace `1522` with `$Port` if your environments vary.)
