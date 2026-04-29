# Mapped Drives

Map a network drive using a secret's credentials. Two approaches: PowerShell, or a batch-file launcher.

## PowerShell launcher

| Launcher field | Value |
|---|---|
| Launcher Name | `NetUse MapDrive1 with letter PS` |
| Active | Yes |
| Additional Prompt Field Name | `Path` |
| Process Name | `powershell` |
| Process Arguments | `net use r: $PATH /user:$DOMAIN\$USERNAME $PASSWORD /p:no` |
| Run Process As Secret Credentials | No |
| Load User Profile | No |
| Use Operating System Shell | No |
| Wrap custom parameters with quotation marks | Yes |

> [!IMPORTANT]
> Do **not** use single quotes around `$PATH`, `$DOMAIN\$USERNAME`, or `$PASSWORD`. Single quotes around the substituted values cause the launcher to fail. With **Wrap custom parameters with quotation marks** = Yes, Secret Server inserts the necessary quotes for you.

Adjust the drive letter (`r:`) as needed and add `/persistent:no` if you don't want the mapping kept across logoff.

## Batch-file launcher

Save a `.bat` file (`NETUSE.BAT`) containing one of the following, then create a Batch File launcher pointing at it.

### NETUSE.BAT — drive letter only

```bat
net use m: %1 /user:%2\%3 %4 /p:no
pause
```

### NETUSE2.BAT — quoted paths (handles spaces in path)

```bat
net use o: "%1" "%4" /user:"%2\%3" /p:no
pause
```

> The PDF source notes the second variant should actually be:
>
> ```bat
> net use m: %1 %4 /user:%2\%3 /p:no
> pause
> ```
>
> with the `pause` so the operator can see the result before the window closes.

### Launcher arguments

When configuring the Batch File launcher, pass arguments in this order to match `%1`-`%4`:

```
$Path $Domain $Username $Password
```

Map `Path` to the **Additional Prompt Field Name** so it's prompted at launch time, or to a custom template field if it's stable for that secret.
