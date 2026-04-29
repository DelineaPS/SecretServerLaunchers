# KiTTY

[KiTTY](https://github.com/cyd01/KiTTY) is a fork of PuTTY 0.70 for Microsoft Windows. This launcher uses KiTTY's portable build to do a Telnet session that auto-submits credentials.

## Prerequisites

- A Telnet server listening on port 23 on the destination. (Free option: <https://www.pragmasys.com/telnet-server/download>.)
- KiTTY portable build: <https://github.com/cyd01/KiTTY/releases> — install on the launching machine and use `kitty_portable.exe`.
- Edit `kitty.ini`:
  - Find `#commanddelay=2`, uncomment, and set to `commanddelay=1`.

## Template

Duplicate the **Windows Account** template and rename to **Windows Account (Telnet)**.

Add a custom field named `ShortName` — used in place of the target host's full name when the application expects a NetBIOS-style identifier.

## Launcher

| Launcher field | Value |
|---|---|
| Launcher Type | Process |
| Process Name | `\\<host>\<Share>\kitty_portable.exe` |
| Process Arguments | `-telnet $MACHINE -cmd "$ShortName\$USERNAME\n$PASSWORD\n"` |

Replace `\\<host>\<Share>\` with the UNC path where `kitty_portable.exe` is staged.

## Template launcher mapping

| Template field | Map to |
|---|---|
| Launcher Type to use | KITTY (this launcher) |
| Domain | ShortName |
| Password | Password |
| Username | Username |
