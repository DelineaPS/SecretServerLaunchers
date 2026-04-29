# LDP

Microsoft's `ldp.exe` LDAP/AD diagnostics tool. Two variants documented depending on where `ldp.exe` lives.

## Variant 1 — From a roaming-profile directory

Useful when `ldp.exe` is dropped into the user's `%localappdata%`.

| Launcher field | Value |
|---|---|
| Launcher Name | `ldp.exe %localappdata% test` |
| Active | Yes |
| Process Name | `cmd` |
| Process Arguments | `/c %localappdata%\test\ldp.exe` |
| Run Process As Secret Credentials | No |
| Load User Profile | No |
| Use Operating System Shell | Yes |

## Variant 2 — From System32

For machines where `ldp.exe` is installed in the standard location.

| Launcher field | Value |
|---|---|
| Launcher Name | `LDP Launcher` |
| Active | Yes |
| Wrap custom parameters with quotation marks | No |
| Record Multiple Windows | Yes |
| Process Name | `cmd` |
| Process Arguments | `/c "C:\Windows\System32\ldp.exe"` |
| Run Process As Secret Credentials | Yes |
| Load User Profile | No |
| Use Operating System Shell | No |
