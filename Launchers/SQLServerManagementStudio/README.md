# SQL Server Management Studio (SSMS)

Three SSMS launcher variants: a domain account launcher (with two flavors), a domain alternative that supports per-instance ports, and a SQL local-user launcher.

> **Heads up:** SSMS 18+ removed support for `-P` (password) on the command line, so the local-user variant below only works with SSMS up to 17. For SSMS 18+ with SQL authentication, see [AutoIT-SSMS-SqlAuth](../AutoIT-SSMS-SqlAuth).

## Variant 1 — Domain Account (SSMS 16/17)

> Enable **Load User Profile** is critical here, particularly if the secret's user has never logged on to the launching machine before.

| Launcher field | Value |
|---|---|
| Launcher Name | `SQL Server Launcher Domain User` |
| Active | Yes |
| Process Name | `C:\Program Files (x86)\Microsoft SQL Server\130\Tools\Binn\ManagementStudio\Ssms.exe` |
| Process Arguments | `-E` |
| Run Process As Secret Credentials | Yes |
| Load User Profile | No |
| Use Operating System Shell | No |

## Variant 2 — Domain Account (SSMS 18+)

| Launcher field | Value |
|---|---|
| Launcher Name | `SQL Domain User Launcher` |
| Wrap custom parameters with quotation marks | No |
| Record Multiple Windows | Yes |
| Process Name | `"C:\Program Files (x86)\Microsoft SQL Server Management Studio 18\Common7\IDE\ssms.exe"` |
| Process Arguments | `-E -S $server\$instance` |
| Run Process As Secret Credentials | No |
| Load User Profile | No |
| Use Operating System Shell | No |

Add `server` and `instance` as custom template fields.

## Variant 3 — Domain Account Alternative (per-instance port)

```text
Process Arguments: -E -S $User Input,$Port
```

If you're connecting to instances that share a Windows account but listen on different ports, pass the port via user input. Pair this with a launcher whitelist so the user gets a dropdown of valid `server,port` values per Windows account.

## Variant 4 — SQL Local User

| Launcher field | Value |
|---|---|
| Launcher Name | `SQL Server Launcher Local User` |
| Additional Prompt Field Name | `Server` |
| Process Name | `Ssms.exe` |
| Process Arguments | `-S $Server -U $Username -P $Password` |
| Run Process As Secret Credentials | No |
| Load User Profile | No |
| Use Operating System Shell | No |

This relies on SSMS accepting `-P` on the command line — works on SSMS 17 and earlier; broken on 18+.
