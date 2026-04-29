# MobaXterm

Two SSH launcher variants for MobaXterm: password authentication and key-based authentication.

## Variant 1 — SSH Password Authentication

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

## Variant 2 — SSH Key Authentication

The key-auth variant uses a Batch File launcher that downloads the SSH key from Secret Server's API at launch, then opens MobaXterm with `-i` pointing at the downloaded key.

> The key is downloaded to `c:\key\id_rsa` and is **not purged** after launch in this script. The key file name is hard-coded; rework if you need it dynamic.

### Batch file

Save as a Batch File and reference it from the launcher (use Notepad to avoid formatting issues introduced by Notepad++):

```bat
START PowerShell.exe -noprofile -executionpolicy bypass -windowstyle hidden -command "new-item -path c:\ -name "Key" -itemtype "directory";$SSURL='https://<your-secret-server-host>/secretserver/winauthwebservices/api/v1/secrets/';$URI=$SSURL+'%1';$API=$URI+'/fields/private-key';Invoke-RestMethod -Uri $API -UseDefaultCredentials -Method Get -ContentType "Application/json" -OutFile "c:\key\id_rsa" -force"

cd "c:\Program Files (x86)\Mobatek\MobaXterm\"

START MobaXterm.exe -newtab "ssh -i c:/tempss/id_rsa %2@%3"
```

Replace `<your-secret-server-host>` with your Secret Server URL.

### Launcher settings

| Field | Value |
|---|---|
| Launcher Type | Batch File |
| Process Arguments | `$SECRETID $USERNAME $MACHINE` |
| Use Operating System Shell | Yes |

### Template mapping

Associate the launcher with **Unix Account (SSH Key Rotation)** (or whichever SSH-key template you use):

| Field | Map to |
|---|---|
| Domain | Machine |
| Password | Private Key Passphrase (unused in this flow) |
| Username | Username |

Add a custom **SecretID** field to the template (not required). Populate it on each test secret with the Secret ID visible in the URL when editing it. (Future enhancement: derive the Secret ID via additional API calls so this manual step isn't needed.)
