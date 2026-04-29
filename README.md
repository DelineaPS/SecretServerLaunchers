# Custom Launchers for Delinea Secret Server

This repository collects **example** custom launcher configurations for [Delinea Secret Server](https://delinea.com/products/secret-server), contributed by the Delinea Professional Services team. Each example shows how to wire up a third-party tool — RDP clients, terminal emulators, database tools, web browsers, etc. — to launch with credentials managed by Secret Server.

> [!IMPORTANT]
> **No implied support.** These examples are offered **as-is** for reference. They are not part of the supported Secret Server product, and Delinea provides no warranty or implied support for them. Test in a non-production environment before using.

## How to use these examples

Each subdirectory under [`Launchers/`](Launchers) covers one tool or scenario. A typical example documents:

- The Secret Server **launcher** configuration: process name, process arguments, and any non-default checkboxes (Run Process As Secret Credentials, Load User Profile, Use Operating System Shell, Wrap custom parameters with quotation marks).
- The associated **secret template** field mappings (Domain, Username, Password, plus any custom fields).
- Any helper scripts (PowerShell, batch, AutoIt) that need to be saved alongside.

To create a launcher in Secret Server:

1. Sign in as a user with **Administer Configuration** permission.
2. Go to **Admin → Secret Templates → Configure Launchers**.
3. Click **New** and copy the values from the relevant example below.
4. Edit the secret template you want the launcher to apply to, click **Configure Launcher**, then **Add New Launcher**, and map the launcher's parameters to template fields.

Variable references like `$USERNAME`, `$PASSWORD`, `$MACHINE`, `$DOMAIN`, `$URL`, `$PORT`, etc. are Secret Server placeholders that are substituted from the secret at launch time. `$user input` (or **Additional Prompt Field Name**) prompts the user at launch.

## Launchers

| Launcher | Description |
|---|---|
| [ActiveDirectoryUsersAndComputers](Launchers/ActiveDirectoryUsersAndComputers) | Launch the AD Users and Computers MMC snap-in (`dsa.msc`) as the secret's identity. Works for any MMC snap-in. |
| [ACSiSeriesJava](Launchers/ACSiSeriesJava) | IBM ACS (Java) launcher for connecting to iSeries / IBM i systems. |
| [ACSLauncher](Launchers/ACSLauncher) | Alternate ACS launcher that takes parameters via CMD (uses `%1`/`%2`/`%3`/`%4`). |
| [AutoIT-SSMS-SqlAuth](Launchers/AutoIT-SSMS-SqlAuth) | Workaround for SSMS 18+ which dropped command-line auth — an AutoIt script types creds into the *Connect to Server* dialog. |
| [AzureMicrosoft365](Launchers/AzureMicrosoft365) | Connect to Azure AD (and other M365 PowerShell modules) using a credential built from the secret. |
| [Chrome](Launchers/Chrome) | Several Chrome variants: Incognito, launch as other user with URL prompt, multi-URL Web Password template, and launcher whitelisting. |
| [Couchbase](Launchers/Couchbase) | Browser launcher with a per-cluster URL whitelist for Couchbase clusters. |
| [Dameware](Launchers/Dameware) | DameWare Mini Remote Control (DWRCC) launcher; supports both direct and centralized-server modes. |
| [FileZilla](Launchers/FileZilla) | FileZilla SFTP launcher; includes the original variant and an updated 2021 version. |
| [Firefox-Incognito](Launchers/Firefox-Incognito) | Firefox in private-browsing mode with a prompted URL. |
| [HeidiSQL](Launchers/HeidiSQL) | HeidiSQL launcher for MySQL/MariaDB (adaptable to MSSQL, PostgreSQL, SQLite). |
| [Kitty](Launchers/Kitty) | KiTTY (PuTTY fork) for telnet sessions that auto-submit credentials. |
| [LDP](Launchers/LDP) | Microsoft LDP.exe LDAP/AD diagnostics tool — variants for `%localappdata%` and `System32` installs. |
| [MappedDrives](Launchers/MappedDrives) | Map a network drive using the secret's credentials, via PowerShell or a `.bat` file. |
| [MMC-RunMSC](Launchers/MMC-RunMSC) | Generic pattern for launching `.msc` consoles against a remote computer. |
| [MobaXterm](Launchers/MobaXterm) | MobaXterm SSH launchers — password auth and SSH-key auth (with REST call to fetch the private key). |
| [PowerShellPSSession](Launchers/PowerShellPSSession) | `Enter-PSSession` launcher for remote PowerShell against a Windows / AD secret. |
| [PuTTY-X11Forwarding](Launchers/PuTTY-X11Forwarding) | The Protocol Handler's bundled PuTTY with `-X` enabled, for X11 forwarding (direct or proxied). |
| [PuTTY-XmingRDS](Launchers/PuTTY-XmingRDS) | XMing X server + PuTTY for RDS multi-user X11 forwarding (one X-server per user). |
| [RDP-RestrictedAdmin](Launchers/RDP-RestrictedAdmin) | RDP via `mstsc /restrictedadmin` for situations where the password must not be exposed to the destination. |
| [RDTabs](Launchers/RDTabs) | Avian Waves RD Tabs launcher. |
| [RemoteApp](Launchers/RemoteApp) | Launch a single pre-approved RemoteApp on a destination instead of a full RDP session. |
| [SecureCRT](Launchers/SecureCRT) | SecureCRT variants — using `%localappdata%` install and using SSH proxy. |
| [SQLPlus](Launchers/SQLPlus) | Oracle SQL\*Plus command-line launcher. |
| [SQLServerManagementStudio](Launchers/SQLServerManagementStudio) | SSMS launchers for Domain, Windows-with-port, and SQL Local User. |
| [TN5250](Launchers/TN5250) | tn5250 sourceforge installer-based launcher for AS/400. |
| [TOAD](Launchers/TOAD) | Toad for Oracle launcher (Quest / Dell paths). |
| [UltraVNC](Launchers/UltraVNC) | UltraVNC vncviewer launcher (paths for both `UltraVNC` and `uvnc bvba` installs). |
| [WinSCP](Launchers/WinSCP) | WinSCP launchers — private-key SCP variant and SFTP-with-SSH-proxy variant. |
| [ZOC](Launchers/ZOC) | ZOC terminal launcher. Note: passwords cannot contain `@`. |

## Variable reference

| Variable | Source |
|---|---|
| `$USERNAME` | Secret's Username field |
| `$PASSWORD` | Secret's Password field |
| `$MACHINE` | Secret's Machine field (or computer name) |
| `$DOMAIN` | Secret's Domain field |
| `$HOST` | Secret's Host field (used by some templates) |
| `$URL` | Secret's URL field (web templates) |
| `$PORT` | Secret's Port field |
| `$user input` | Prompts the user at launch (configured via *Additional Prompt Field Name*) |
| Custom (`$Server`, `$database`, `$Path`, `$ShortName`, `$SECRETID`, …) | Custom field added to the secret template |

The case of variable names should match how Secret Server displays them in the launcher editor.

## Contributing

PRs welcome. Each launcher folder needs at least:

- A `README.md` documenting Process Name, Process Arguments, non-default checkboxes, the secret template field mapping, and any prerequisites.
- Any helper scripts (`.ps1`, `.bat`, `.au3`, `.vbs`) saved in the same folder and referenced from the README.

Please **do not include screenshots that contain real hostnames, usernames, or domains** — replace identifying values with `EXAMPLE`, `CONTOSO`, `corp.example.com`, etc.

## License

This repository is published without an explicit license; all content is © Delinea unless otherwise noted. You may use these examples for reference and adaptation in your own Secret Server deployment.
