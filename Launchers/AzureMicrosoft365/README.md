# Azure / Microsoft 365 PowerShell

Launcher pattern for connecting to Azure or Microsoft 365 PowerShell modules using credentials managed by Secret Server. The launcher starts `powershell.exe`, imports the relevant module, and calls the module's `Connect-*` cmdlet with a `[pscredential]` built from the secret's Username, Domain, and Password.

> [!IMPORTANT]
> When configuring PowerShell process launchers, use **double quotes** around the command — *not* curly braces. Curly braces cause PowerShell to echo the command (and the substituted username/password) to the console, exposing the credentials.

## Templates

The out-of-the-box **Office 365 Account** template covers most Azure / M365 modules. Some services (e.g. SharePoint PnP) need an extra URL — duplicate the template and add a `URL` field for those.

## Create launcher

1. Navigate to **Admin → Secret Templates → Configure Launchers**.
2. Click **New**.
3. Enter a **Launcher Name** — e.g. `Powershell - <Module Name>`.
4. Check **Active**.
5. Uncheck **Record Multiple Windows**.
6. Set **Process Name**: `powershell.exe`.
7. Set **Process Arguments** to the value for the module you're targeting (see below).
8. Click **Save**.

## Configure template launcher

1. **Admin → Secret Templates → Office 365 Account** (or your custom template) → **Edit**.
2. Click **Configure Launcher → Add New Launcher**.
3. **Launcher Type to use** = the launcher you just created.
4. Map fields:
   - **Domain** → Domain
   - **Password** → Password
   - **Username** → Username
5. Click **Save**.

## Process Arguments

### AzureAD module (`AzureAD`)

```powershell
-NoExit -Command "Import-Module AzureAd; Connect-AzureAd -Credential ([pscredential]::new('$USERNAME@$DOMAIN',(ConvertTo-SecureString -String '$PASSWORD' -AsPlainText -Force)));Clear-Host;Clear-History;"
```

`Clear-Host` and `Clear-History` at the end remove the substituted credential from the visible scrollback and command history.

## Other modules

The same `[pscredential]::new(...)` pattern works for many other Azure/M365 modules. PRs welcome — likely candidates:

- **Exchange Online**: `ExchangeOnlineManagement` → `Connect-ExchangeOnline -Credential $cred`
- **Microsoft Teams**: `MicrosoftTeams` → `Connect-MicrosoftTeams -Credential $cred`
- **MSOnline (legacy)**: `MSOnline` → `Connect-MsolService -Credential $cred`
- **SharePoint PnP**: `PnP.PowerShell` → `Connect-PnPOnline -Url $URL -Credentials $cred` (add a `URL` field on the template)
- **Azure Az**: `Az.Accounts` → `Connect-AzAccount -Credential $cred`

> [!NOTE]
> Some of these modules now require certificate-based / app-only auth instead of a username/password credential — the credential pattern shown above only works for tenants that still allow basic auth or where the account isn't subject to MFA / Conditional Access.
