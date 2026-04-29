@echo off
REM Map a network drive using credentials passed by Secret Server.
REM Process Arguments order: $Path $Domain $Username $Password
REM   %1 = path (e.g. \\server\share)
REM   %2 = domain
REM   %3 = username
REM   %4 = password

net use m: %1 /user:%2\%3 %4 /p:no
pause
