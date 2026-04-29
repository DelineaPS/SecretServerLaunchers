# PowerShell — `Enter-PSSession`

Launches a remote PowerShell session against a prompted hostname using the secret's Windows / Active Directory credentials.

> [!IMPORTANT]
> **Hostname must be FQDN or NETBIOS name, not an IP address.** `Enter-PSSession` uses Kerberos by default, which requires a name (so it can resolve a Service Principal Name). Connecting by IP fails with `WinRM cannot process the request` unless you pre-stage the host in TrustedHosts and switch to NTLM — out of scope for this launcher.

## Prerequisite

The destination host must have PowerShell remoting enabled (`Enable-PSRemoting`) and the secret's identity must have permission to open a session.

## Launcher

| Launcher field | Value |
|---|---|
| Launcher Name | `Powershell - Enter-PSSession` |
| Active | Yes |
| Use Additional Prompt | Yes |
| Additional Prompt Field Name | `HOSTNAME` |
| Use Custom Image? | No |
| Wrap custom parameters with quotation marks | No |
| Record Multiple Windows | No |
| Process Name | `powershell.exe` |
| Process Arguments | `-NoExit -Command "Enter-PSSession -ComputerName ""$HOSTNAME"""` |
| Run Process As Secret Credentials | Yes |
| Load User Profile | Yes |
| Use Operating System Shell | No |

The doubled `""` quotes around `$HOSTNAME` in the Process Arguments are intentional — they survive PowerShell's two-stage parsing so the substituted hostname is correctly quoted in the inner `Enter-PSSession` invocation.

## Template launcher mapping

Use a Windows or Active Directory secret template (the launcher needs Run-as-secret-credentials, which requires a Windows-style identity).

1. **Admin → Secret Templates** → pick your template → **Edit**.
2. **Configure Launcher** — if there's an existing launcher, remove it.
3. **Add New Launcher**.
4. **Launcher Type to use**: `Powershell - Enter-PSSession`.
5. Map fields:
   - **Domain** → Domain
   - **HOSTNAME** → `<user input>`
   - **Password** → Password
   - **Username** → Username
6. Click **Save**.
