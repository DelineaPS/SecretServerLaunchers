;ssms.exe with sql credential launcher script
;Author: Simon Hughes

;set filepath of ssms.exe
$Path = "C:\Program Files (x86)\Microsoft SQL Server Management Studio 18\Common7\IDE\Ssms.exe"
;execute ssms.exe
ShellExecute($Path)
;wait for the 'connect to server' window to appear
WinWaitActive("Connect to Server", "", 0)
;set auth mode to SQL authentication
ControlSend("Connect to Server", "", "[NAME:comboBoxAuthentication]", "[NAME:SQL]")
;set server instance to servername passed from Secret Server launcher in cmd line parameter 1
ControlSetText("Connect to Server", "", "[NAME:serverInstance]", $CmdLine[1], 1)
;set username to username passed from Secret Server launcher in cmd line parameter 2
ControlSetText("Connect to Server", "", "[NAME:userName]", $CmdLine[2], 1)
;set password to password passed from Secret Server launcher in cmd line parameter 3
ControlSetText("Connect to Server", "", "[NAME:password]", $CmdLine[3], 1)
;reactivate the connect to server window, required for the click of buttons within the window
WinActivate("Connect to Server")
;click the connect button
ControlClick("Connect to Server", "", "[NAME:connect]")
