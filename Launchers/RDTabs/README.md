# RD Tabs

Avian Waves RD Tabs launcher.

| Launcher field | Value |
|---|---|
| Process Name | `c:\program files\Avian Waves\RD Tabs\RDTabs.exe` |
| Process Arguments | `START SERVER $Server /u:$USERNAME /p:$PASSWORD /d:UK` |

## Template notes

- If using a **Windows Account** template, change `$SERVER` to `$MACHINE`.
- If using an **AD** template, add a custom `SERVER` field (or set the launcher to **Restrict User Input** so the user is prompted).
- The `/d:UK` flag is a domain hint; replace with your AD domain (or remove if not needed).
