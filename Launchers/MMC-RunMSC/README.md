# MMC — Run an MSC against a remote computer

Generic pattern for launching any [Microsoft Management Console](https://learn.microsoft.com/troubleshoot/windows-server/system-management-components/what-is-microsoft-management-console) (`.msc`) snap-in targeted at a specific remote computer.

## Hard-coded variant

| Launcher field | Value |
|---|---|
| Launcher Type | Process |
| Process Arguments | `mmc c:\windows\system32\eventvwr.msc /computer:"computername"` |

The example launches Event Viewer (`eventvwr.msc`) against `computername`.

## Variable-driven variant

Replace the hard-coded snap-in and machine with template fields:

| Launcher field | Value |
|---|---|
| Launcher Type | Process |
| Process Arguments | `mmc c:\windows\system32\$MscFile /computer:"$MACHINE"` |
| Run Process As Secret Credentials | Yes |

Add a custom **MscFile** Text field on the secret template (e.g. `eventvwr.msc`, `compmgmt.msc`, `services.msc`). `$MACHINE` is the destination host.

**Run Process As Secret Credentials** = Yes authenticates against the remote host with the secret's credentials.
