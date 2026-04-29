@echo off
REM Map a network drive using credentials passed by Secret Server. Tolerates
REM spaces in the UNC path (the path is not quoted by Secret Server).
REM Process Arguments order: $Path $Domain $Username $Password
REM   %1 = path (e.g. \\server\share with possible spaces)
REM   %2 = domain
REM   %3 = username
REM   %4 = password

net use m: %1 %4 /user:%2\%3 /p:no
pause
