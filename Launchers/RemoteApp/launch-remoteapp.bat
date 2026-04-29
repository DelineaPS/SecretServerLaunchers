@echo off
REM Launch a single pre-approved RemoteApp on a destination instead of a
REM full RDP session. Stages credentials in Windows Credential Manager,
REM runs mstsc against a generated .rdp file, then cleans up.
REM
REM Process Arguments order: $MACHINE $USERNAME $PASSWORD
REM   %1 = destination host
REM   %2 = username
REM   %3 = password
REM
REM The destination must have the target application pre-approved in:
REM HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Terminal Server\TSAppAllowList\Applications
REM Edit "remoteapplicationprogram:s:notepad" below to launch a different
REM pre-approved application.
REM
REM Assumes c:\temp exists. Add `if not exist c:\temp mkdir c:\temp` if not.

(
echo;remoteapplicationmode:i:1
echo;remoteapplicationprogram:s:notepad
echo;disableremoteappcapscheck:i:1
) > "c:\temp\test1.rdp"

cmdkey /delete:%1 >NUL

cmdkey /generic:%1 /user:%1\%2 /pass:"%3" >NUL

mstsc "c:\temp\test1.rdp" /v:%1

timeout /t 3 >NUL

cmdkey /delete:%1 > NUL

del "c:\temp\test1.rdp"
