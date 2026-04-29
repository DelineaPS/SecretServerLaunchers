# MMC — Run an MSC against a remote computer

Generic pattern for launching any `.msc` console targeted at a specific remote computer.

```text
Process Arguments: mmc c:\windows\system32\eventvwr.msc /computer:"computername"
```

Example above launches Event Viewer (`eventvwr.msc`) against `computername`.

## Variable-driven version

Replace the hard-coded snap-in and machine with template fields:

```text
Process Arguments: mmc c:\windows\system32\$MSCFILE /computer:"$MACHINE"
```

Add **MSCFILE** as a custom template field (e.g. `eventvwr.msc`, `compmgmt.msc`, `services.msc`) and `MACHINE` as the target host.

Use **Run Process As Secret Credentials** = Yes to authenticate against the remote host with the secret's credentials.
