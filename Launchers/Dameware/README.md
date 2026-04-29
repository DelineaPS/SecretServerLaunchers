# Dameware

DameWare Mini Remote Control launcher.

> **Note:** In recent versions of DameWare Mini Remote Control, passing the password through has been observed to fail. Test in your environment before relying on it.

## Direct (per-workstation install) variant

In Secret Server, go to **Admin → Secret Templates → Configure Launchers** and create a new launcher named **Dameware**.

| Field | Value |
|---|---|
| Process Name | `C:\Program Files (x86)\SolarWinds\DameWare Remote Support\DWRCC.exe` |
| Process Arguments | `-c: -h: -a:2 -m:$MACHINE -u:$USERNAME -p:$PASSWORD -d:$DOMAIN` |

Then create a secret template (or extend an existing one) with **Domain**, **Username**, **Password**, **Machine** fields, and associate the launcher with the template.

### Notes

- **Process Name** may differ per environment. For local execution, set it to the local install of `DWRCC.exe`. For remote execution, ensure the secret's account has permission to execute the remote process and the source system has SMB access to the destination.
- If **Run Process As Secret Credentials** is unchecked, Secret Server tries to access the destination using the currently logged-in Windows user's credentials.

## Centralized server variant

If connecting through a DameWare central server, additional template fields are needed (defaults vary by deployment; the documented defaults are `user`/`user`, change them to match your installation):

| Template Field | Default field type |
|---|---|
| Domain | Text |
| Username | Text |
| Password | Password (masked) |
| BH (Backend Host) | Text |
| BPN (Backend Port Number) | Text |
| BU (Backend Username) | Text |
| BPS (Backend Password) | Password (masked) |

Configure the launcher with arguments that reference these custom fields per the DameWare Remote Support documentation, and check **Run Process As Secret Credentials**.
