# RemoteApp

Local-application custom launchers normally rely on the application being installed locally. With the standard RDP launcher you can connect to an endpoint and manually launch an app, but it's inconvenient. This launcher starts an RDP session whose shell is set to a single, pre-approved RemoteApp.

## Notes

- The remote application must be **pre-approved** on the destination via a registry change (see below).
- The script assumes `c:\temp` exists. Add `if not exist c:\temp mkdir c:\temp` if you need it created on first run.
- The example targets a single application (`notepad`). Edit the `remoteapplicationprogram:s:notepad` line in the bundled script to launch a different pre-approved application, or amend further to accept the application name from a Secret field or user input.

## Step 1 — Approve the application on the destination

Adapted from Microsoft's RemoteApp documentation.

1. Open `regedit` and navigate to:
   ```
   HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Terminal Server\TSAppAllowList
   ```
2. Set `fDisabledAllowList` to `1`.
3. Add a new key under `TSAppAllowList` named `Applications`.
4. Add a new key under `Applications` (any name, e.g. `123456`).
5. Inside that key, create two String Values:
   - `Name` — display name
   - `Path` — full path to the application's executable (e.g. `C:\Windows\System32\notepad.exe`)

## Step 2 — Bundled batch file

[`launch-remoteapp.bat`](launch-remoteapp.bat) is the script. It:

- **Lines 1–6 (the parenthesised echo block):** build a `.rdp` file marked as a RemoteApp connection running `notepad`.
- **Line 7:** clear any old credentials for this destination.
- **Line 8:** stage the secret's credentials in Credential Manager.
- **Line 9:** launch the RDP session against `%1` (the destination).
- **Line 10:** brief pause while the session establishes.
- **Lines 11–12:** clean up the staged credential and temporary `.rdp` file.

## Step 3 — Launcher

See [Batch file launchers](../../README.md#batch-file-launchers) in the top-level README for the upload-and-attach workflow.

| Launcher field | Value |
|---|---|
| Launcher Type | Batch file |
| Batch file | upload [`launch-remoteapp.bat`](launch-remoteapp.bat) |
| Process Arguments | `$MACHINE $USERNAME $PASSWORD` |
| Run Process As Secret Credentials | No |
| Use Operating System Shell | No |

When the launcher fires, you'll see a brief RemoteApp window before the destination opens with just the chosen application instead of a full desktop.

## Troubleshooting

If you sometimes see "credentials did not work" prompts that resolve when you re-enter the password, adjust the local (or GPO) security settings per [this guide](https://www.thewindowsclub.com/your-credentials-did-not-work-in-remote-desktop-on-windows-10).
