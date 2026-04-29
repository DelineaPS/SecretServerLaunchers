# Mapped Drives

Map a network drive using a secret's credentials via [`net use`](https://learn.microsoft.com/windows-server/administration/windows-commands/net-use). Two approaches: PowerShell (Process launcher), or a `.bat` file (Batch file launcher).

## PowerShell launcher (Process)

| Launcher field | Value |
|---|---|
| Launcher Name | `NetUse MapDrive1 with letter PS` |
| Launcher Type | Process |
| Active | Yes |
| Additional Prompt Field Name | `Path` |
| Wrap custom parameters with quotation marks | Yes |
| Process Name | `powershell` |
| Process Arguments | `net use r: $Path /user:$DOMAIN\$USERNAME $PASSWORD /p:no` |
| Run Process As Secret Credentials | No |
| Load User Profile | No |
| Use Operating System Shell | No |

> [!IMPORTANT]
> Do **not** use single quotes around `$Path`, `$DOMAIN\$USERNAME`, or `$PASSWORD`. Single quotes around the substituted values cause the launcher to fail. With **Wrap custom parameters with quotation marks** = Yes, Secret Server inserts the necessary quotes for you.

Adjust the drive letter (`r:`) as needed and add `/persistent:no` to drop the mapping at logoff.

## Batch file launchers

Two `.bat` variants are bundled. See [Batch file launchers](../../README.md#batch-file-launchers) in the top-level README for the upload-and-attach workflow.

### `netuse-letter.bat` — drive letter only

[`netuse-letter.bat`](netuse-letter.bat) wraps:

```bat
net use m: %1 /user:%2\%3 %4 /p:no
pause
```

| Launcher field | Value |
|---|---|
| Launcher Type | Batch file |
| Batch file | upload [`netuse-letter.bat`](netuse-letter.bat) |
| Process Arguments | `$Path $DOMAIN $USERNAME $PASSWORD` |
| Run Process As Secret Credentials | No |
| Use Operating System Shell | No |

### `netuse-path.bat` — drive letter, tolerates spaces in the UNC path

[`netuse-path.bat`](netuse-path.bat) is the recommended variant from the source document:

```bat
net use m: %1 %4 /user:%2\%3 /p:no
pause
```

| Launcher field | Value |
|---|---|
| Launcher Type | Batch file |
| Batch file | upload [`netuse-path.bat`](netuse-path.bat) |
| Process Arguments | `$Path $DOMAIN $USERNAME $PASSWORD` |
| Run Process As Secret Credentials | No |
| Use Operating System Shell | No |

In all variants, map `Path` to the **Additional Prompt Field Name** to prompt at launch, or to a custom template field if it's stable for that secret.
