
              |   |
              +   +
          .,;:||V||:;,.


+===Cmdr Halo Jone's ED Script repo ===+


The Caveat bit:

This repo is meant for augmenting personal experiences of gameplay.

All software developed via this repo is subject to the license contained.

However, all sofwtare also is expected to be within the spirit of Frontier Development's End User License Agreement. 

Any violation of this agreement should be reported immediately to the owner whereupon it will be removed forthwith.

Game End User License Agreement:
https://www.frontierstore.net/ed-eula/



The Content:

So far, just a BuckyBall script.



---------------------------------------
BuckyBall script

++++++++++++Function: ++++++++++++

Automatically capture screen shots on entrance to a new Star System

Automatically capture screen shots on leaving your existing Star System

++++++++++++WHY WOULD YOU WANT IT: ++++++++++++

combining all the screenshots into a gif or movie will show where you have been, nice if you like exploring the Galaxy

++++++++++++Prerequisites: ++++++++++++

1) UnixUtils : https://sourceforge.net/projects/unxutils/

Expected location: extract all unixUtils to c:\utils\bin\


2) Powershell : https://docs.microsoft.com/en-us/powershell/scripting/getting-started/getting-started-with-windows-powershell?view=powershell-7

3) AutoHotkey : https://www.autohotkey.com/docs/Tutorial.htm


++++++++++++Scripts: ++++++++++++


FSDJournal.cmd
- A cmd script that will poll an Elite Dangerous journal file for the word "FSDJump"
- does this every 2 seconds
- uses tail to pull last 2 lines of journal
- should "fire" twice per jump entry to system
- increase number of lines in tail to capture more bitmaps per system jump
- must be edited to include current Journal file name ( changes on each run of Elite Dangerous ) #ToDO
- outputs the line from journal file to "Jumped.txt"

DriveChargeJournal.cmd
- A cmd script that will poll an Elite Dangerous journal file for the word "StartJump"
- does this every 2 seconds
- uses tail to pull last 2 lines of journal
- should "fire" twice per jump exit from system
- increase number of lines in tail to capture more bitmaps per system jump
- must be edited to include current Journal file name ( changes on each run of Elite Dangerous ) #ToDO
- outputs the line from journal file to "Jumped.txt"

F10-Elite.ahk
- A Auto Hot Key script which will force a screenshot capture in Elite by :
	Find Elite Dangerous application
	Activate Elite Dangerous application
	Send an F10 Key down
	Wait a bit
	Send an F10 Key up
	
watchFile.ps1
- a powershell script that will:
- implement watcher i/o file system object on "Jumped.txt"
- on change of this file, will run F10-Elite.ahk auto hotkey


++++++++++++Installation: ++++++++++++

Place prerequisites in appropriate folders
Place unixUtils file location within path environment variable
place all scripts in :

		C:\Users\YOURUSERNAME\Saved Games\Frontier Developments\Elite Dangerous\



++++++++++++configuration: ++++++++++++


FSDJournal.cmd
	change line 5 :
		Journal.SOMEBIGNUMBER.log 
	to the current journal file found in 
		C:\Users\YOURUSERNAME\Saved Games\Frontier Developments\Elite Dangerous\

	Change line 5
		\YOURUSERNAME\
	to the folder that corresponds to your username
	


DriveChargeJournal.cmd
	change line 5 :
		Journal.SOMEBIGNUMBER.log 
	to the current journal file found in 
		C:\Users\YOURUSERNAME\Saved Games\Frontier Developments\Elite Dangerous\

	Change line 5
		\YOURUSERNAME\
	to the folder that corresponds to your username

watchFile.ps1
	change line 56 :
		\YOURUSERNAME\
	to the folder that corresponds to your username



++++++++++++Usage: ++++++++++++

1) start Elite Dangerous
2) obtain latest journal file
3) see configuration steps above
4) After all configuration, execute watchFile.ps1 by right clicking and selecting "run with Powershell"



++++++++++++Whats it doing to my PC ? ++++++++++++

Running this ps1 script will do the following:

Open two commandline scripts which continually look at your journal file
Output the results to an intermediate "Jumped.txt" file 
Watch jumped.txt for changes made to this file
On change to jumped.txt, will run AutoHotkey script which causes Elite to take a screen shot ( F10 Key )
Plays a small system "Beep" on successful completion ( feel free to remove )

! This will create many screenshot bitmaps at this location :

C:\Users\YOURUSERNAME\Pictures\Frontier Developments\Elite Dangerous

typically it will generate 4 screen shots per jump ( two on exit, two on entrance )

Author takes no responsibility for any damage / drive filling / drive failure etc

Use this software entirely at your own risk



++++++++++++Whats with those PING statements? ++++++++++++

No these are not dialling home to a secret rebel base. These are jus sending a ping to your local loopback address ( i.e. doing nothing )

They are there to implement a simple delay to checking the journal file. #TODO : remove and place with something nicer ?








