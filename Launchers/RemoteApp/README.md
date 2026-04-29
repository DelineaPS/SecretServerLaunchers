# RemoteApp

Local-application custom launchers normally rely on the application being installed locally. With the standard RDP launcher you can connect to an endpoint and manually launch an app, but it's inconvenient. This launcher starts an RDP session whose shell is set to a single, pre-approved RemoteApp.

## Notes

- The remote application must be **pre-approved** on the destination via a registry change (see below).
- The script assumes `c:\temp` exists. Add a check or `mkdir` if you need it created first.
- The example targets a single application. You can amend the script to accept the application from a Secret field or user input.

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

## Step 2 — Script

Save as a `.bat` file:

```bat
echo off

(
echo;remoteapplicationmode:i:1
echo;remoteapplicationprogram:s:notepad
echo;disableremoteappcapscheck:i:1
) > "c:\temp\test1.rdp"

cmdkey /delete:%1 >NUL

cmdkey /generic:%1 /user:%1\%2 /pass:"%3" >NUL

mstsc "c:\temp\test1.rdp" /v:%1

timeout /t 3 >NUL

cmdkey /delete:%1 > NUL

del "c:\temp\test1.rdp"
```

What each part does:

- **Lines 1–6:** build a `.rdp` file marked as a RemoteApp connection running `notepad`.
- **Line 7:** clear any old credentials for this destination.
- **Line 8:** stage the secret's credentials in Credential Manager.
- **Line 9:** launch the RDP session against `%1` (the destination).
- **Line 10:** brief pause while the session establishes.
- **Lines 11–12:** clean up the staged credential and temporary `.rdp` file.

## Step 3 — Launcher

Create a **Batch File** launcher pointing at the script above. Pass arguments in this order to populate `%1`, `%2`, `%3`:

```
$MACHINE $USERNAME $PASSWORD
```

When the launcher fires, you'll see a brief RemoteApp window before the destination opens with just the chosen application instead of a full desktop.

## Troubleshooting

If you sometimes see "credentials did not work" prompts that resolve when you re-enter the password, adjust the local (or GPO) security settings per [this guide](https://www.thewindowsclub.com/your-credentials-did-not-work-in-remote-desktop-on-windows-10).
