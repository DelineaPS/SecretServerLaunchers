# RD Tabs

[Avian Waves RD Tabs](https://avianwaves.com/Software/RDTabs.aspx) launcher.

| Launcher field | Value |
|---|---|
| Launcher Type | Process |
| Process Name | `c:\program files\Avian Waves\RD Tabs\RDTabs.exe` |
| Process Arguments | `START SERVER $Server /u:$USERNAME /p:$PASSWORD /d:UK` |

## Template notes

- For a **Windows Account** template, change `$Server` to `$MACHINE`.
- For an **AD** template, add a custom `Server` Text field (or set the launcher to **Restrict User Input** so the user is prompted).
- The `/d:UK` flag is a domain hint; replace with your AD domain (or remove if not needed).
