# FileZilla

[FileZilla](https://filezilla-project.org/) SFTP launcher. Two variants documented — the original from the source PDF, and an updated version (2021) using the full install path.

## Variant 1 — Original

| Launcher field | Value |
|---|---|
| Launcher Name | `FileZilla` |
| Launcher Type | Process |
| Active | Yes |
| Wrap custom parameters with quotation marks | Yes |
| Process Name | `filezilla.exe` |
| Process Arguments | `"sftp://$USERNAME:$PASSWORD@$HOST"` |
| Run Process As Secret Credentials | No |
| Load User Profile | No |
| Use Operating System Shell | No |

## Variant 2 — Updated (2021-02-10)

| Launcher field | Value |
|---|---|
| Launcher Name | `FileZilla Launcher` |
| Launcher Type | Process |
| Active | Yes |
| Wrap custom parameters with quotation marks | No |
| Record Multiple Windows | Yes |
| Process Name | `C:\Program Files\FileZilla FTP Client\filezilla.exe` |
| Process Arguments | `"sftp://$USERNAME:$PASSWORD@$HOST"` |
| Run Process As Secret Credentials | No |
| Load User Profile | No |
| Use Operating System Shell | No |
