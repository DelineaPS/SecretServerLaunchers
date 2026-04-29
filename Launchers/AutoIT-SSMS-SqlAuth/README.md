# Using AutoIt to launch SSMS 18+ with SQL Authentication

[SSMS](https://learn.microsoft.com/sql/ssms/sql-server-management-studio-ssms) 18+ removed support for `-P` (password) on the command line. This launcher works around that by using [AutoIt](https://www.autoitscript.com/) to type credentials into SSMS's *Connect to Server* dialog programmatically, then clicking **Connect**.

The launcher is a session connector + child launcher pair so the AutoIt executable runs on a Remote Desktop Services host rather than every user's workstation.

## Setup

1. **Install AutoIt** on the machines that will run the launcher. For session-connector use, install on the RDS host: <https://www.autoitscript.com/site/autoit/downloads/>
2. Open [`ssms-sql-auth.au3`](ssms-sql-auth.au3) with **SciTE** (the AutoIt script editor that ships with the install).
3. **Compile** to an `.exe`: SciTE → **Tools → Compile**.
4. **Save** the `.exe` to a path accessible to all users (the source document used `c:\autoit\`).
5. **Configure the child launcher** in Secret Server (note the double quotes around variables — they're required so passwords containing spaces survive AutoIt's command-line parsing):

   | Launcher field | Value |
   |---|---|
   | Launcher Type | Process |
   | Process Name | `c:\autoit\ssms-sql-auth.exe` |
   | Process Arguments | `"$Server" "$USERNAME" "$PASSWORD"` |

6. **Wrap with a session-connector launcher** so the script runs through the RDS host. In the parent (session-connector) launcher's settings, choose the child launcher from step 5.
7. **Create a secret template** with `Server`, `Username`, `Password` fields and attach the session-connector launcher.

## Script

[`ssms-sql-auth.au3`](ssms-sql-auth.au3) — written by Simon Hughes. Adjust the SSMS path at the top of the script to match the install:

```au3
$Path = "C:\Program Files (x86)\Microsoft SQL Server Management Studio 18\Common7\IDE\Ssms.exe"
```

The script:

1. Launches `ssms.exe`.
2. Waits for the *Connect to Server* dialog.
3. Sets **Authentication** to *SQL Server Authentication*.
4. Fills in the server instance, username, and password from `$CmdLine[1..3]`.
5. Re-activates the dialog and clicks **Connect**.

## Limitations

- Brittle to SSMS UI changes. If a future SSMS version renames the controls, the `[NAME:...]` selectors in the script will need to be re-discovered with AutoIt's *Window Info* tool.
- The password is briefly visible in `Process Monitor` traces while AutoIt types it — same caveat as any launcher that passes a password on the command line.
