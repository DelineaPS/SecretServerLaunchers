# MobaXterm

[MobaXterm](https://mobaxterm.mobatek.net/) SSH launchers — password authentication (Process launcher) and key-based authentication (Batch file launcher with a bundled `.bat`).

## Variant 1 — SSH Password Authentication (Process launcher)

| Launcher field | Value |
|---|---|
| Launcher Name | `MobaXterm SSH` |
| Launcher Type | Process |
| Active | Yes |
| Process Name | `C:\Program Files (x86)\Mobatek\MobaXterm\MobaXterm.exe` |
| Process Arguments | `-newtab "sshpass -p '$PASSWORD' ssh $USERNAME@$MACHINE"` |
| Run Process As Secret Credentials | No |
| Load User Profile | No |
| Use Operating System Shell | No |

> [!IMPORTANT]
> A single quote (`'`) in the password breaks the launcher because the argument wraps the password in single quotes. Either remove `'` from the character set used in the secret template's password generator, or be prepared to change passwords that contain it.

Adjust the install path as needed.

### Template launcher mapping

Edit the **Unix Account (SSH)** template → **Configure Launcher** → **Add New Launcher**:

| Template field | Map to |
|---|---|
| Domain | Machine |
| Password | Password |
| Username | Username |

## Variant 2 — SSH Key Authentication (Batch file launcher)

The key-auth variant uses a Batch File launcher that downloads the SSH key from Secret Server's REST API at launch, then opens MobaXterm with `-i` pointing at the downloaded key. The script is bundled as [`mobaxterm-key.bat`](mobaxterm-key.bat).

> [!IMPORTANT]
> Edit `mobaxterm-key.bat` before uploading: replace `<your-secret-server-host>` with your Secret Server URL.
>
> The downloaded key is placed at `c:\key\id_rsa` and is **not purged** after the launcher exits. The key file name is hard-coded; rework the script if you need it dynamic.

See [Batch file launchers](../../README.md#batch-file-launchers) in the top-level README for the upload-and-attach workflow.

### Launcher

| Launcher field | Value |
|---|---|
| Launcher Type | Batch file |
| Batch file | upload [`mobaxterm-key.bat`](mobaxterm-key.bat) |
| Process Arguments | `$SECRETID $USERNAME $MACHINE` |
| Use Operating System Shell | Yes |

### Template launcher mapping

Associate the launcher with **Unix Account (SSH Key Rotation)** (or whichever SSH-key template is in use):

| Template field | Map to |
|---|---|
| Domain | Machine |
| Password | Private Key Passphrase (unused in this flow) |
| Username | Username |

Add a custom **SecretID** field to the template (Text, not required). Populate it on each test secret with the Secret ID visible in the URL when editing it. (Future enhancement: derive the Secret ID via additional API calls so this manual step isn't needed.)
