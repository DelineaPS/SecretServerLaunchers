# ZOC

Terminal emulator launcher.

| Launcher field | Value |
|---|---|
| Process Name | `ZOC.EXE` |
| Process Arguments | `/SSH:$USERNAME:$PASSWORD@$MACHINE` |

> [!WARNING]
> The password field **cannot contain `@`** — it will get truncated at the first `@`. ZOC may also reject other special characters. Constrain the secret template's password generator accordingly.
