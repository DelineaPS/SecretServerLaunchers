@echo off
REM Alternate IBM ACS launcher that takes a separate IPADDR (useful when
REM the system hostname differs from how clients should resolve it, e.g.
REM via a load balancer VIP).
REM
REM Replace <loc> below with the full path to your IBMiAccess install
REM directory (e.g. C:\Users\Public\IBM\ClientSolutions\).
REM
REM Process Arguments order: $MACHINE $USERNAME $PASSWORD $IPADDR
REM   %1 = system
REM   %2 = userid
REM   %3 = password
REM   %4 = IP address

java -Xmx1024m -jar <loc>IBMiAccess_v1r1\acsbundle.jar /PLUGIN=CFG /SYSTEM=%1 /IPADDR=%4 /USERID=%2 /R

java -Xmx1024m -jar <loc>IBMiAccess_v1r1\acsbundle.jar /PLUGIN=logon /SYSTEM=%1 /USERID=%2 /PASSWORD=%3

java -Xmx1024m -jar <loc>IBMiAccess_v1r1\acsbundle.jar /PLUGIN=5250 /SYSTEM=%1 /sso=1
