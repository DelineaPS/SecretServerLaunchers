# PowerShell — `Enter-PSSession`

Launches a remote PowerShell session via [`Enter-PSSession`](https://learn.microsoft.com/powershell/module/microsoft.powershell.core/enter-pssession) against a prompted hostname using the secret's Windows / Active Directory credentials.

> [!IMPORTANT]
> **Hostname must be FQDN or NETBIOS name, not an IP address.** `Enter-PSSession` uses Kerberos by default, which requires a name (so it can resolve a Service Principal Name). Connecting by IP fails with `WinRM cannot process the request` unless the host is pre-staged in TrustedHosts and authentication is switched to NTLM — out of scope for this launcher.

## Prerequisite

The destination host must have PowerShell remoting enabled (`Enable-PSRemoting`) and the secret's identity must have permission to open a session.

## Launcher

| Launcher field | Value |
|---|---|
| Launcher Name | `Powershell - Enter-PSSession` |
| Launcher Type | Process |
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

The doubled `""` quotes around `$HOSTNAME` in **Process Arguments** are intentional — they survive PowerShell's two-stage parsing so the substituted hostname is correctly quoted in the inner `Enter-PSSession` invocation.

## Template launcher mapping

Use a Windows or Active Directory secret template (the launcher needs Run-as-secret-credentials, which requires a Windows-style identity).

| Template field | Map to |
|---|---|
| Launcher Type to use | `Powershell - Enter-PSSession` |
| Domain | Domain |
| HOSTNAME | `<user input>` |
| Password | Password |
| Username | Username |
