# ZOC

[ZOC terminal](https://www.emtec.com/zoc/) launcher.

| Launcher field | Value |
|---|---|
| Launcher Type | Process |
| Process Name | `ZOC.EXE` |
| Process Arguments | `/SSH:$USERNAME:$PASSWORD@$MACHINE` |

> [!WARNING]
> The password field **cannot contain `@`** — it will be truncated at the first `@`. ZOC may also reject other special characters. Constrain the secret template's password generator accordingly.
