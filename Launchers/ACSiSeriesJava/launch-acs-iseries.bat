@echo off
REM Launch IBM ACS (Java) — chained calls to acsbundle.jar for CFG, logon,
REM and 5250 emulation. Adjust the `home=` line if ACS is installed
REM somewhere other than C:\Users\Public\IBM\ClientSolutions\.
REM
REM Process Arguments order: $MACHINE $USERNAME $PASSWORD
REM   %1 = system / host
REM   %2 = userid
REM   %3 = password

cls

set home=C:\Users\Public\IBM\ClientSolutions\

java -Xmx1024m -jar %home%\acsbundle.jar /PLUGIN=CFG /SYSTEM=%1 /USERID=%2 /R

java -Xmx1024m -jar %home%\acsbundle.jar /PLUGIN=logon /SYSTEM=%1 /USERID=%2 /PASSWORD=%3

java -Xmx1024m -jar %home%\acsbundle.jar /PLUGIN=5250 /SYSTEM=%1 /sso=1
