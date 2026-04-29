# ACS Launcher (positional parameters with explicit IP address)

Alternate IBM ACS launcher that takes a separate `IPADDR` parameter — useful when the system hostname differs from how clients should resolve it (e.g. via a load balancer VIP).

## Bundled batch file

[`launch-acs-positional.bat`](launch-acs-positional.bat). Replace `<loc>` in the script with the full path to your IBMiAccess install directory (e.g. `C:\Users\Public\IBM\ClientSolutions\`) before uploading.

## Launcher

See [Batch file launchers](../../README.md#batch-file-launchers) in the top-level README for the upload-and-attach workflow.

| Launcher field | Value |
|---|---|
| Launcher Type | Batch file |
| Batch file | upload [`launch-acs-positional.bat`](launch-acs-positional.bat) |
| Process Arguments | `$MACHINE $USERNAME $PASSWORD $IPADDR` |
| Run Process As Secret Credentials | No |
| Use Operating System Shell | No |

`$IPADDR` is a custom field on the secret template. Add it as a Text field if not already present.

See also: [ACSiSeriesJava](../ACSiSeriesJava) for the simpler variant without the explicit IPADDR.
