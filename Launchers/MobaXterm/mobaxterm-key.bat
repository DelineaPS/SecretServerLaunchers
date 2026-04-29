@echo off
REM Fetch the SSH private key for the launching secret from Secret Server's
REM REST API, then open MobaXterm pointing -i at the downloaded key.
REM
REM Process Arguments order: $SECRETID $USERNAME $MACHINE
REM   %1 = Secret ID (custom field on the secret template; the integer
REM        Secret Server uses for this secret in its REST API)
REM   %2 = username
REM   %3 = target host
REM
REM Replace <your-secret-server-host> with your Secret Server URL before
REM uploading. The script uses Windows auth against the API.
REM
REM Note: the key is downloaded to c:\key\id_rsa and is NOT purged after
REM       the launcher exits.

START PowerShell.exe -noprofile -executionpolicy bypass -windowstyle hidden -command "new-item -path c:\ -name "Key" -itemtype "directory";$SSURL='https://<your-secret-server-host>/secretserver/winauthwebservices/api/v1/secrets/';$URI=$SSURL+'%1';$API=$URI+'/fields/private-key';Invoke-RestMethod -Uri $API -UseDefaultCredentials -Method Get -ContentType "Application/json" -OutFile "c:\key\id_rsa" -force"

cd "c:\Program Files (x86)\Mobatek\MobaXterm\"

START MobaXterm.exe -newtab "ssh -i c:/key/id_rsa %2@%3"
