# MMC Snap-in: Active Directory Users and Computers

Launches `dsa.msc` (the Active Directory Users and Computers MMC snap-in) under the secret's credentials. The same pattern works for any MMC snap-in — just swap the `.msc` filename.

Two variants are documented: a verbose PowerShell wrapper that uses `runas`-style credentials, and a simpler revised version that relies on Secret Server's "Run Process As Secret Credentials".

## Variant 1 — PowerShell wrapper

| Launcher field | Value |
|---|---|
| Launcher Name | `ADUC Launcher` |
| Active | Yes |
| Process Name | `powershell.exe` |
| Process Arguments | `-noprofile -executionpolicy bypass -windowstyle hidden -command cmd.exe -workingdirectory $PSHOME -credential $USERNAME\$PASSWORD -ArgumentList "/c dsa.msc"` |
| Run Process As Secret Credentials | Yes |
| Load User Profile | No |
| Use Operating System Shell | No |

### Secret template fields

| Field Name | Description | Type |
|---|---|---|
| Domain | The server or location of the Active Directory Domain | Text |
| Username | The domain username | Text |
| Password | The password of the domain user | Password |
| Notes | Any additional notes | Notes |
| PSHOME | PowerShell home directory | Text |

`$PSHOME` is the directory PowerShell is currently running from; it varies per machine. If it's the same across all machines using the launcher, you can hard-code the path inside Process Arguments instead of making it a template field.

## Variant 2 — Revised (simpler)

| Launcher field | Value |
|---|---|
| Process Name | `powershell.exe` |
| Process Arguments | `-Command "dsa.msc"` |

Configure the launcher in the template with **Launcher Type to use** = your launcher, and map Domain, Password, and Username to the corresponding secret fields.

## Other MMC snap-ins

Replace `dsa.msc` with any other snap-in (e.g. `dnsmgmt.msc`, `gpmc.msc`). For consoles that target a remote computer, see [MMC-RunMSC](../MMC-RunMSC).
