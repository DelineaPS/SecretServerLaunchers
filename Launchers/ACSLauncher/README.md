# ACS Launcher (positional parameters)

Alternate IBM ACS launcher that takes parameters via `%1`, `%2`, `%3`, `%4` rather than inline `$VARIABLE` substitution.

## Batch contents

```bat
java -Xmx1024m -jar <loc>IBMiAccess_v1r1\acsbundle.jar /PLUGIN=CFG /SYSTEM=%1 /IPADDR=%4 /USERID=%2 /R

java -Xmx1024m -jar <loc>IBMiAccess_v1r1\acsbundle.jar /PLUGIN=logon /SYSTEM=%1 /USERID=%2 /PASSWORD=%3

java -Xmx1024m -jar <loc>IBMiAccess_v1r1\acsbundle.jar /PLUGIN=5250 /SYSTEM=%1 /sso=1
```

Replace `<loc>` with the full path to your IBMiAccess install directory (e.g. `C:\Users\Public\IBM\ClientSolutions\`).

## Launcher arguments

When wiring the Batch File launcher into a template, supply arguments in this order:

```
$MACHINE $USERNAME $PASSWORD $IPADDR
```

The `$IPADDR` field is a custom template field — useful when the system hostname differs from how clients should resolve to it (e.g. via a load balancer VIP).

See also: [ACSiSeriesJava](../ACSiSeriesJava) for a variant that uses inline `$VARIABLE` substitution.
