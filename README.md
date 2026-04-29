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
2. Go to **Admin → Secret Templates → Configure Launchers** (or search for **Launchers**).
3. Click **New** (or **Create**) and copy the values from the relevant example below.
4. Edit the secret template you want the launcher to apply to, click **Configure Launcher**, then **Add New Launcher**, and map the launcher's parameters to template fields.

See [Creating Custom Launchers](https://docs.delinea.com/online-help/secret-server/launcher-protocol-handler/launchers/procedures/custom-launchers/creating-custom-launchers/index.htm) in the official Delinea documentation for the full set of fields on the launcher page.

Variable references like `$USERNAME`, `$PASSWORD`, `$MACHINE`, `$DOMAIN`, `$URL`, `$PORT`, etc. are Secret Server placeholders that are substituted from the secret at launch time. `$user input` (or **Additional Prompt Field Name**) prompts the user at launch.

## Batch file launchers

Several launchers in this repo are **Batch file** launchers — Secret Server uploads a `.bat` you provide, then runs it with the secret's variables passed as positional arguments (`%1`, `%2`, …) at launch time. This is different from a **Process** launcher, which runs an existing `.exe` directly.

To create a batch file launcher in Secret Server (full reference: [Creating Custom Launchers](https://docs.delinea.com/online-help/secret-server/launcher-protocol-handler/launchers/procedures/custom-launchers/creating-custom-launchers/index.htm)):

1. **Admin → Secret Templates → Launchers** tab → **Create**.
2. Set **Launcher Type** to **Batch file**.
3. Give it a **Launcher Name** (e.g. `Batch Launcher - Mapped Drive`).
4. Leave **State** as **Enabled**.
5. Configure tracking/recording as needed (**Track multiple windows**, **Record additional processes**, **Wrap custom parameters with quotation marks**).
6. Under **Windows settings**:
   - **Batch file**: upload the `.bat` from the relevant launcher folder (e.g. [`Launchers/MappedDrives/netuse-letter.bat`](Launchers/MappedDrives/netuse-letter.bat)).
   - **Process arguments**: the *positional* arguments to pass to the `.bat`, in order — these become `%1`, `%2`, … inside the script. Each launcher's README in this repo documents the expected order. Example: `$USERNAME $MACHINE $NOTES $PRIVATEKEY $PRIVATEKEYPASSPHRASE`.
   - **Run process as secret credentials**: usually **No** — the `.bat` already pulls the creds via `%1`/`%2`/`%3`.
   - **Use Operating System Shell**: usually **No**.
7. Click **Save**.

Then attach the launcher to a secret template under **Configure Launcher** on the template, and map each `$variable` in **Process Arguments** to the right secret field.

### Batch-file launchers in this repo

| Launcher | Bundled `.bat` |
|---|---|
| [ACSiSeriesJava](Launchers/ACSiSeriesJava) | [`launch-acs-iseries.bat`](Launchers/ACSiSeriesJava/launch-acs-iseries.bat) |
| [ACSLauncher](Launchers/ACSLauncher) | [`launch-acs-positional.bat`](Launchers/ACSLauncher/launch-acs-positional.bat) |
| [MappedDrives](Launchers/MappedDrives) | [`netuse-letter.bat`](Launchers/MappedDrives/netuse-letter.bat), [`netuse-path.bat`](Launchers/MappedDrives/netuse-path.bat) |
| [MobaXterm](Launchers/MobaXterm) (SSH key auth) | [`mobaxterm-key.bat`](Launchers/MobaXterm/mobaxterm-key.bat) |
| [RemoteApp](Launchers/RemoteApp) | [`launch-remoteapp.bat`](Launchers/RemoteApp/launch-remoteapp.bat) |

## Launchers

### Remote Desktop & RemoteApp

| Launcher | Description |
|---|---|
| [Dameware](Launchers/Dameware) | [DameWare Mini Remote Control](https://www.dameware.com/products/dameware-mini-remote-control) (DWRCC); supports both direct and centralized-server modes. |
| [RDP-RestrictedAdmin](Launchers/RDP-RestrictedAdmin) | RDP via [`mstsc /restrictedadmin`](https://learn.microsoft.com/windows/win32/termserv/mstsc) for situations where the password must not be exposed to the destination. |
| [RDTabs](Launchers/RDTabs) | [Avian Waves RD Tabs](https://avianwaves.com/Software/RDTabs.aspx) launcher. |
| [RemoteApp](Launchers/RemoteApp) | Launch a single pre-approved [RemoteApp](https://learn.microsoft.com/windows-server/remote/remote-desktop-services/clients/remote-desktop-allow-access) on a destination instead of a full RDP session. |
| [UltraVNC](Launchers/UltraVNC) | [UltraVNC](https://uvnc.com/) `vncviewer.exe` launcher (paths for both `UltraVNC` and `uvnc bvba` installs). |

### SSH / terminal emulators

| Launcher | Description |
|---|---|
| [Kitty](Launchers/Kitty) | [KiTTY](https://github.com/cyd01/KiTTY) (PuTTY fork) for telnet sessions that auto-submit credentials. |
| [MobaXterm](Launchers/MobaXterm) | [MobaXterm](https://mobaxterm.mobatek.net/) SSH launchers — password auth and SSH-key auth (with REST call to fetch the private key). |
| [PuTTY-X11Forwarding](Launchers/PuTTY-X11Forwarding) | The Protocol Handler's bundled [PuTTY](https://www.putty.org/) with `-X` enabled, for X11 forwarding (direct or proxied). |
| [PuTTY-XmingRDS](Launchers/PuTTY-XmingRDS) | [XMing](http://www.straightrunning.com/XmingNotes/) X server + PuTTY for RDS multi-user X11 forwarding (one X-server per user). |
| [SecureCRT](Launchers/SecureCRT) | [VanDyke SecureCRT](https://www.vandyke.com/products/securecrt/) variants — using `%localappdata%` install and using SSH proxy. |
| [ZOC](Launchers/ZOC) | [ZOC terminal](https://www.emtec.com/zoc/) launcher. Note: passwords cannot contain `@`. |

### Database clients

| Launcher | Description |
|---|---|
| [AutoIT-SSMS-SqlAuth](Launchers/AutoIT-SSMS-SqlAuth) | Workaround for SSMS 18+ which dropped command-line auth — an [AutoIt](https://www.autoitscript.com/) script types creds into the *Connect to Server* dialog. |
| [Couchbase](Launchers/Couchbase) | Browser launcher with a per-cluster URL whitelist for [Couchbase](https://www.couchbase.com/) clusters. |
| [HeidiSQL](Launchers/HeidiSQL) | [HeidiSQL](https://www.heidisql.com/) launcher for MySQL/MariaDB (adaptable to MSSQL, PostgreSQL, SQLite). |
| [SQLPlus](Launchers/SQLPlus) | Oracle [SQL\*Plus](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqpug/) command-line launcher. |
| [SQLServerManagementStudio](Launchers/SQLServerManagementStudio) | [SSMS](https://learn.microsoft.com/sql/ssms/sql-server-management-studio-ssms) launchers for Domain, Windows-with-port, and SQL local user. |
| [TOAD](Launchers/TOAD) | [Toad for Oracle](https://www.quest.com/products/toad-for-oracle/) launcher (Quest / Dell paths). |

### Web browsers

| Launcher | Description |
|---|---|
| [Chrome](Launchers/Chrome) | Several [Chrome](https://www.google.com/chrome/) variants: Incognito, launch as other user with URL prompt, multi-URL Web Password template, and launcher whitelisting. |
| [Firefox-Incognito](Launchers/Firefox-Incognito) | [Firefox](https://www.mozilla.org/firefox/) in private-browsing mode with a prompted URL. |

### File transfer & network drives

| Launcher | Description |
|---|---|
| [FileZilla](Launchers/FileZilla) | [FileZilla](https://filezilla-project.org/) SFTP launcher; includes the original variant and an updated 2021 version. |
| [MappedDrives](Launchers/MappedDrives) | Map a network drive using the secret's credentials, via PowerShell or a `.bat` file. |
| [WinSCP](Launchers/WinSCP) | [WinSCP](https://winscp.net/) launchers — private-key SCP variant and SFTP-with-SSH-proxy variant. |

### Windows administration & PowerShell

| Launcher | Description |
|---|---|
| [ActiveDirectoryUsersAndComputers](Launchers/ActiveDirectoryUsersAndComputers) | Launch the AD Users and Computers MMC snap-in (`dsa.msc`) as the secret's identity. Works for any MMC snap-in. |
| [AzureMicrosoft365](Launchers/AzureMicrosoft365) | Connect to Azure AD via PowerShell using a credential built from the secret. Adaptable to other M365 modules. |
| [LDP](Launchers/LDP) | Microsoft's [`LDP.exe`](https://learn.microsoft.com/troubleshoot/windows-server/identity/ldp-overview) LDAP/AD diagnostics tool — variants for `%localappdata%` and `System32` installs. |
| [MMC-RunMSC](Launchers/MMC-RunMSC) | Generic pattern for launching `.msc` consoles against a remote computer. |
| [PowerShellPSSession](Launchers/PowerShellPSSession) | [`Enter-PSSession`](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/enter-pssession) launcher for remote PowerShell against a Windows / AD secret. |

### IBM i / iSeries

| Launcher | Description |
|---|---|
| [ACSiSeriesJava](Launchers/ACSiSeriesJava) | [IBM Access Client Solutions](https://www.ibm.com/support/pages/ibm-i-access-client-solutions) (Java) launcher for connecting to iSeries / IBM i systems. |
| [ACSLauncher](Launchers/ACSLauncher) | Alternate ACS launcher that takes parameters via CMD (uses `%1`/`%2`/`%3`/`%4`); supports an explicit IP address parameter. |
| [TN5250](Launchers/TN5250) | [tn5250](https://tn5250.sourceforge.net/) sourceforge installer-based launcher for AS/400. |

## Variable reference

Built-in Secret Server variables (use UPPERCASE in process arguments):

| Variable | Source |
|---|---|
| `$USERNAME` | Secret's Username field |
| `$PASSWORD` | Secret's Password field |
| `$MACHINE` | Secret's Machine field (or computer name) |
| `$DOMAIN` | Secret's Domain field |
| `$HOST` | Secret's Host field (used by SSH-proxy templates) |
| `$URL` | Secret's URL field (web templates) |
| `$PORT` | Secret's Port field |
| `$NOTES` | Secret's Notes field |
| `$PRIVATEKEY` / `$PRIVATE KEY` | SSH private-key field on key-rotation templates |
| `$PRIVATEKEYPASSPHRASE` | Passphrase on the SSH private-key field |
| `$SECRETID` | Custom field convention used in this repo for the secret's numeric ID — must be added manually as a Text field on the template |
| `$SESSIONKEY` | Identifier the launcher passes to the launched process; can be used to anonymously check the secret back in via the `CheckInSecretByKey` API |
| `$user input` | Prompts the user at launch; configured via *Additional Prompt Field Name* |
| Custom fields (`$Server`, `$Database`, `$Path`, `$ShortName`, …) | Use PascalCase to match the field name on the secret template |

Variable names are case-insensitive in Secret Server, but matching the canonical case above keeps process-argument strings easier to read.

## Contributing

PRs welcome.

### Adding a new launcher

Each launcher folder needs:

- A `README.md` documenting:
  - **Launcher** config table (Process Name / Process Arguments / non-default checkboxes).
  - **Template** field mapping table (which secret field maps to each variable).
  - Any prerequisites (registry settings, install paths, user permissions).
- Any helper scripts (`.ps1`, `.bat`, `.au3`, `.vbs`) saved in the same folder, named with lowercase-with-hyphens, and referenced from the README.
- A short link to the upstream tool's homepage on first mention (e.g. *[FileZilla](https://filezilla-project.org/)*).

### Adding a variant

When a folder covers multiple variants of the same tool (e.g. SSMS Domain / SQL local user, FileZilla original / 2021 update):

- Use sequential `## Variant N — Short label` headings.
- Keep field tables in the same column order across variants. List each launcher field in the same row even if the value differs (rather than omitting fields that are at default).

### Sanitization rules

**Do not include screenshots or other content with real internal hostnames, usernames, or domains.** Replace identifying values with placeholders: `EXAMPLE`, `CONTOSO`, `corp.example.com`, `<your-secret-server-host>`, etc. The same applies to log paths, share names, and backup-host fields.

### Testing expectations

Test every launcher in a non-production Secret Server before submitting. Note tested versions (Secret Server release, target tool version) in a "Tested on" line if version compatibility matters.

## License

This repository is published without an explicit license; all content is © Delinea unless otherwise noted. You may use these examples for reference and adaptation in your own Secret Server deployment.
