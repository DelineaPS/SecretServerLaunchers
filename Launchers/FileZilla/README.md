# FileZilla

Two variants — the original launcher, and an updated version (2021) using the full install path.

## Variant 1 — Original

| Launcher field | Value |
|---|---|
| Launcher Name | `FileZilla` |
| Active | Yes |
| Process Name | `filezilla.exe` |
| Process Arguments | `"sftp://$Username:$Password@$Host"` |
| Run Process As Secret Credentials | No |
| Load User Profile | No |
| Use Operating System Shell | No |

## Variant 2 — Updated (2021-02-10)

| Launcher field | Value |
|---|---|
| Launcher Name | `FileZilla Launcher` |
| Active | Yes |
| Wrap custom parameters with quotation marks | No |
| Record Multiple Windows | Yes |
| Process Name | `C:\Program Files\FileZilla FTP Client\filezilla.exe` |
| Process Arguments | `"sftp://$username:$password@$host"` |
| Run Process As Secret Credentials | No |
| Load User Profile | No |
| Use Operating System Shell | No |
