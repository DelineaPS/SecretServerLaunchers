# ACS IBM Java Launcher for iSeries

[IBM Access Client Solutions](https://www.ibm.com/support/pages/ibm-i-access-client-solutions) (ACS) is a Java application for connecting to IBM i (iSeries) systems. This batch-file launcher chains three `acsbundle.jar` invocations: configure, log on, then 5250 emulation with single sign-on.

## Bundled batch file

[`launch-acs-iseries.bat`](launch-acs-iseries.bat). Adjust the `set home=` line if ACS is installed somewhere other than `C:\Users\Public\IBM\ClientSolutions\`.

## Launcher

See [Batch file launchers](../../README.md#batch-file-launchers) in the top-level README for the upload-and-attach workflow.

| Launcher field | Value |
|---|---|
| Launcher Type | Batch file |
| Batch file | upload [`launch-acs-iseries.bat`](launch-acs-iseries.bat) |
| Process Arguments | `$MACHINE $USERNAME $PASSWORD` |
| Run Process As Secret Credentials | No |
| Use Operating System Shell | No |

Map the standard secret-template fields (Machine, Username, Password) to the corresponding Secret Server variables on the template's launcher configuration.

See also: [ACSLauncher](../ACSLauncher) for a variant that also passes an explicit IP address (useful when the system hostname differs from how clients should resolve it).
