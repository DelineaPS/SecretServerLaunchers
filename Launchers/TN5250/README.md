# TN5250

5250 terminal emulator for AS/400. Launcher targets the [tn5250 SourceForge installer](https://tn5250.sourceforge.net/).

| Launcher field | Value |
|---|---|
| Launcher Name | `AS400 TN5250 Emulator` |
| Launcher Type | Process |
| Active | Yes |
| Process Name | `C:\Program Files (x86)\TN5250\TN5250.exe` |
| Process Arguments | `$HOST env.USER=$USERNAME env.IBMSUBSPW=$PASSWORD` |
| Run Process As Secret Credentials | No |
| Load User Profile | No |
| Use Operating System Shell | No |

Add **Host** as a custom template field (or remap `$HOST` to whatever the template names the destination host).
