# TN5250

5250 terminal emulator for AS/400. Launcher targets the installer at <https://tn5250.sourceforge.net>.

| Launcher field | Value |
|---|---|
| Launcher Name | `AS400 TN5250 Emulator` |
| Active | Yes |
| Process Name | `C:\Program Files (x86)\TN5250\TN5250.exe` |
| Process Arguments | `$Host env.USER=$Username env.IBMSUBSPW=$Password` |
| Run Process As Secret Credentials | No |
| Load User Profile | No |
| Use Operating System Shell | No |

Add **Host** as a custom template field (or remap `$Host` to whatever your template names the destination host).
