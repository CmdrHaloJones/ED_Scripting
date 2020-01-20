#lifted  from  stackoverflow:
#https://stackoverflow.com/questions/29066742/watch-file-for-changes-and-run-command-with-powershell
#
#Feature: Send {F10} key to Elite Dangerous on each new system
#Expects:
#	FSDJournal.cmd - uses unixUtils to place latest FSDJump from elite dangerous journal into a new file "Jumped.txt"
#Configure: 
#	FSDJournal.cmd needs name of realtime Journal file added eg Journal.200116222233.01.
#Watches:
#	Jumped.txt 
#
#On Change of Jumped.txt
#	App Activet Elite Dangerous
#	Sleep
#	send {F10} key event
#
#Test : Use Notepad.txt instead of Elite Dangerous
#	Use 
#	echo test >journal.log to test no change / no event creation against watcher
#	Use
#	echo FSDJump >journal.log to test change / no event creation against watcher
#

#Kick Off Journal Watchers
Invoke-Item FSDJournal.cmd
sleep 1
Invoke-Item DriveChargeJournal.cmd
sleep1

Function RunMyStuff {
    # app activate and send keystroke notepad and F5 in test
    # but Elite Dangerous and F10 in production
    #Ref: https://superuser.com/questions/1249976/sendkeys-method-in-powershell/1250038
    Clear-Host # remove previous console output
    #
    #send key from PShell is too quick for elite polling so use F10-Elite.ahk instead
    #
    #$wshell = New-Object -ComObject wscript.shell;
    # 		$wshell.AppActivate('test.txt - Notepad') # note pad used in test
    #$wshell.AppActivate('Elite - Dangerous (CLIENT)');  # ED client
    #Sleep 1;
    # 		$wshell.SendKeys('{f5}') #timestamp in notepad used in test
    #$wshell.SendKeys('{f10}') #F10 screenshot in Elite is not working, switch to use reddit alternative
    #Keypress -ScanCode 0x79
    Invoke-Item F10-Elite.ahk
    [System.Console]::Beep() #Beep used in debug
    
    Sleep 2
    # 		$wshell.SendKeys('~') #timestamp # Notepad enter key used in test
    #		Sleep 2
    # 		$wshell.SendKeys('^s') #save to remove * from window title # notepad save 
}

Function Watch {    
    $global:FileChanged = $false 
    $folder = "C:\Users\YOURUSERNAME\Saved Games\Frontier Developments\Elite Dangerous"
    $filter = "Jumped.txt"
    
    $watcher = New-Object IO.FileSystemWatcher $folder, $filter -Property @{ 
        IncludeSubdirectories = $false 
        EnableRaisingEvents = $true
    }

    Register-ObjectEvent $Watcher "Changed" -Action {$global:FileChanged = $true} > $null

    while ($true){
        while ($global:FileChanged -eq $false){
            # We need this to block the IO thread until there is something to run 
            # so the script doesn't finish. If we call the action directly from 
            # the event it won't be able to write to the console
            Start-Sleep -Milliseconds 100
        }

        # a file has changed, run our stuff on the I/O thread so we can see the output
        RunMyStuff

        # reset and go again
        $global:FileChanged = $false
    }
}

#RunMyStuff # run the action at the start so I can see the current output
Watch