# MobaXterm

Two SSH launcher variants for MobaXterm: password authentication (Process launcher) and key-based authentication (Batch file launcher with bundled `.bat`).

## Variant 1 — SSH Password Authentication (Process launcher)

1. Go to **Admin → Secret Templates → Configure Launchers → New**.
2. Configure the launcher:

| Launcher field | Value |
|---|---|
| Launcher Name | `MobaXterm SSH` |
| Launcher Type | Process |
| Process Name | `C:\Program Files (x86)\Mobatek\MobaXterm\MobaXterm.exe` |
| Process Arguments | `-newtab "sshpass -p '$PASSWORD' ssh $USERNAME@$MACHINE"` |

> **Password constraints:** A single quote (`'`) in the password breaks the launcher because the argument wraps the password in single quotes. Either remove `'` from the character set used in the secret template's password generator, or be prepared to change passwords that contain it.

Adjust the install path as needed.

3. Edit the **Unix Account (SSH)** template → **Configure Launcher** → **Add New Launcher**:
   - **Launcher Type to use:** the launcher you just created
   - **Domain:** Machine
   - **Password:** Password
   - **Username:** Username
   - Save

## Variant 2 — SSH Key Authentication (Batch file launcher)

The key-auth variant uses a Batch File launcher that downloads the SSH key from Secret Server's REST API at launch, then opens MobaXterm with `-i` pointing at the downloaded key. The script is bundled as [`mobaxterm-key.bat`](mobaxterm-key.bat).

> [!IMPORTANT]
> Edit `mobaxterm-key.bat` before uploading: replace `<your-secret-server-host>` (line 14 of the script) with your Secret Server URL.
>
> Also note: the key is downloaded to `c:\key\id_rsa` and is **not purged** after the launcher exits. The key file name is hard-coded; rework the script if you need it dynamic.

See [Batch file launchers](../../README.md#batch-file-launchers) in the top-level README for the upload-and-attach workflow.

### Launcher settings

| Launcher field | Value |
|---|---|
| Launcher Type | Batch file |
| Batch file | upload [`mobaxterm-key.bat`](mobaxterm-key.bat) |
| Process Arguments | `$SECRETID $USERNAME $MACHINE` |
| Use Operating System Shell | Yes |

### Template mapping

Associate the launcher with **Unix Account (SSH Key Rotation)** (or whichever SSH-key template you use):

| Field | Map to |
|---|---|
| Domain | Machine |
| Password | Private Key Passphrase (unused in this flow) |
| Username | Username |

Add a custom **SecretID** field to the template (Text, not required). Populate it on each test secret with the Secret ID visible in the URL when editing it. (Future enhancement: derive the Secret ID via additional API calls so this manual step isn't needed.)
