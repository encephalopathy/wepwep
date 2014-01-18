#Level Editor FAQ></br>
This document will try to answer any and all questions you may have while using… THE PEW PEW LEVEL EDITOR(trademarked, patent pending, blah blah blah)

##What is the LevelEditor?
The LevelEditor is a java application made to help us create levels and waves quickly for the game. WIth the app, you can place any number of enemies into the game to make up sets of waves which will make up a level, which in turn is a set that makes up the game. The LevelEdtior can Export your game to a .pew file (thanks Zack!) to be played in the game. It can also Import previously made .pew files for easy editing.

##Where can I find the Level Editor?
`wepwep/LevelEditor`

A .jar will be coming soon to launch the application from this location. The LevelEditor has a hard coded location for where it will export and import files so do not move it. It was done this way so you would only need to enter the filename instead of the entire file path.

##What does the format of a LevelEditor file look like?
`Name=w1s1 Number=1`
`Time=2 com.game.enemies.Hater_Normal=5
   Type=com.game.enemies.Hater_Normal Location=69,-46 Rotation=0Weapons=com.game.weapons.primary.SingleshotWeapon Passives=`


##What is a .pew file?
A .pew file is LevelEditor file to be used only for Pew Pew devs. If I catch you sharing .pew files with others, there will be a reckoning.

##Who can I ask about the LevelEditor?
After reading this document, you should be able to know everything and anything about the LevelEditor. But if you have questions not covered here, ask Adam, Brent, or Zack for clarification.

#How To’s

##Importing a File
After launching the application:  
`Find in the top menu bar the “File” option; click “File”`  
`Select “Import”`  
`Enter the name of the file you wish to Import`  

NOTES:  
	1. You may only import .pew files into the LevelEditor  
	2. Your files must exist in the com folder of the repo:
		wepwep/branches/pewpew_corona_port/

##Exporting a File
After launching the application:   
`Find in the top menu bar the “File” option; click “File”`  
`Select “Export”`  
`Enter the name you wish to give your new file`  

NOTES:  
	1. The LevelEditor will only export .pew files  
	2. Your files will ALWAYS export out to the top folder of the project::
		wepwep/branches/pewpew_corona_port/  

##Creating a New Level
After launching the application:  
`Find the “Level” Tab on the top of the menu bar`  
`Click “New Level” from the drop down menu`  
`A pop up will appear and ask you to enter the level name`  
`Click OK when finished`  
`Click the “Level” Tab again to verify that your level is there`  

NOTES:  
The naming scheme for the levels will be world number followed by section number. So World 1 Section 1 will be named: w1s1. This will be the format for every level.
Currently there is NOT possible to re-order levels in the LevelEditor. Once a Level is added to the Editor it is in that order. Ex. If you put w1s1 and w1s3 in and want to put w1s2 in, w1s2 would be at the end of the file with no way to re-organize in the Editor. If you find that you need to re-organize levels, Export your current LevelEditor session, open up the .pew file in any text editor, and copy/paste the entire level into the order that you want.


##Creating a Wave
After launching the application:  
`In order to create a wave, you must first create a Level (as shown above).`  
`Once that is done, click the Level Tab on the top of the menu bar`  
`Move down to the Level you wish to add a Wave to. You will see a > which will open up a sub-menu`  
`On the sub-menu, select “New Wave”.`  
`A pop up will appear and ask you to enter a Time for the wave to occur. This will be in seconds.`  
`Click Ok when finished.`  
`To Verify, go to Level tab, hover over the level you were just working on, and see that a number representing the Time you entered is shown.`

NOTES:
After creating a Wave, the Wave you JUST MADE will become your CURRENT WAVE, which means you will now be working in that wave. EX: I create a Wave at Time 2 for my Current Level. Once I hit OK, the Level Editor will switch over to Time 2. 

##Changing Current Wave
By Default, after launching the application, you will NOT be in a Current Wave. To begin working in a Wave, you must either create one (as shown above) or Import one. Once either requirement is met:  
`Go to the Level Tab and open the drop down menu`  
`Click on the Level you want to work in and hover to the Wave you want to work in`  
`Click on the Number and you will now be in that Wave`  

##Creating a Hater
After launching the application:  
`Find the “Enemy” Tab on the top menu bar`  
`Click Enemy. This will open up a drop down menu listing all of the available Haters to create`  
`Click the Hater type you wish to make`  
`A pop up will appear asking you to put in a rotation for your Hater. Click OK once you are done.`  
`Two pop ups will be displayed: Passives and Weapons.`  
`Choose which Passives to give a Hater. To do this:`  
`1.Click on the Passive Number on the top menu bar. Doing this will open up a drop down menu with all available Passives. The number of slot is dependent on the enemy type.`  
`2.Click on the Passive you wish to equip. You can leave a slot empty by leaving the top menu bar as Passive #.`  
`3.Once you are finished click the red X`  
`Choose which Weapons to give a Hater. To do this:`  
`1.Click on the Weapon Number on the top menu bar. Doing this will open up a drop down menu with all available Weapons. The number of slots is dependent on the enemy type.`  
`2.Click on the Weapon you wish to equip. You can leave a slot empty by leaving the top menu bar as Weapon #.`  
`3.Once you are finished click the red X`  

You now have a Working Enemy to place. Notice the Enemy tab has been changed to the type of Hater you will be placing.

##Placing a Hater
Before you can place an enemy, you must first have a Working Hater. See the above for making one.  
After you have made a Working Enemy:  
`Left click on the GRAY area of the screen to put down an enemy. The black screen is the View of the Player so keep this in mind when placing enemies.`

NOTE:  
You do not need to worry about any coordinate translation. We took care of that for you. Every time you remember that fact, give Adam or Brent a Cookie.

##Erasing a Hater
To Erase a Hater,  
`Right-Click the Hater to erase it.`

NOTE:  
Due to some bug, you must have a Working Enemy before erasing a Hater. This is being looked into but for now remember to have a Working Enemy before attempting to erase.
This also took a while, so give Adam or Brent like half a Cookie due to the bug.