REM lets try a loop
REM %TMP% == C:\Users\YOURUSERNAME\AppData\Local\Temp

:loop
tail -n 2 Journal.SOMEBIGNUMBER.log |grep StartJump >> "C:\Users\YOURUSERNAME\Saved Games\Frontier Developments\Elite Dangerous\Jumped.txt"
ping -n 4 127.0.0.1 >NUL:
goto loop

REM use app Activate within a ps command to actually fire the F10 : 
REM https://stackoverflow.com/questions/29066742/watch-file-for-changes-and-run-command-with-powershell

