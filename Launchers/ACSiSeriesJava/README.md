# ACS IBM Java Launcher for iSeries

IBM Access Client Solutions (ACS) is a Java application for connecting to IBM i (iSeries) systems. This batch-file launcher chains three `acsbundle.jar` invocations: configure, log on, then 5250 emulation with single sign-on.

## Batch file contents

```bat
cls
@echo off

Set home=C:\Users\Public\IBM\ClientSolutions\

java -Xmx1024m -jar %home%\acsbundle.jar /PLUGIN=CFG /SYSTEM=$MACHINE /USERID=$USERNAME /R

java -Xmx1024m -jar %home%\acsbundle.jar /PLUGIN=logon /SYSTEM=$MACHINE /USERID=$USERNAME /PASSWORD=$PASSWORD

java -Xmx1024m -jar %home%\acsbundle.jar /PLUGIN=5250 /SYSTEM=$MACHINE /sso=1
```

Adjust `home=` to match your ACS install location.

## Launcher type

Configure as a **Batch File** launcher with the contents above. Map the standard secret template fields (Machine, Username, Password) to the corresponding Secret Server variables.

See also: [ACSLauncher](../ACSLauncher) for the variant that uses positional `%1`/`%2`/`%3`/`%4` parameters instead of inline `$VARIABLE` substitution.
