## BaseBuilding-DayZ ##


Base Building DayZ Project.  This adds a building function in DayZ mod regardless of map.<br>

**I will be providing minimal support for anyone modifying the existing code.  If you have any questions, please message me on git or email me at daimyo21mods@gmail.com**

### Base Building Full Features List: ###

- Ability to build 30+ Arma 2/OA Objects in DayZ and create your ultimate base with your friends
- Buildable Recipe Menu with pictures and Information
- Gate Panels with Keypad access to open and close gates
- Buildable Booby Traps that blow up in 10 meter proximity, crawl to avoid!
- Custom disarm bomb action, with chance to fail based on not having toolbox/entrench tool
- AntiWall feature that doesnt allow players to exit out of vehicles into player made bases.
- Custom buildable removal function with chance to lose toolbox
- Detailed parameters allowing server owners to dictate where things can be built, if they are invincible, etc etc.
- Integrated into DayZ code
- Server restart compatible
- Virtually compatible with any DayZ map.
- Server side Update object feature to allow active player bases to stay updated for cleanup script.

#### Base Building - DayZ 1.2 Changelog

- Optimizations to code and functionality <br>
- Integration of player actions into DayZ fn_selfActions.sqf<br>
- New building mechanic placement<br>
- New Build Recipe Menu by W4rGo (with pictures and detailed info)<br>
- New Detailed but easy-to-change parameters allowing server owners to change individual parameters for each buildable<br>
- New, Buildables update in a 300 meter radius to database when keypanel is used to open gates<br>
- OwnerID refund/removal of buildables<br>
- Remove individual buildables with a code that is given when object is built (code can be given to anyone)<br>
- Updated and cleaned up removal functions<br>
- AntiWall function fixed<br>
- Booby traps no longer blow up static graves on the map, it is specified now to only use booby trap model<br>
- ActiveCombat 1.1 compatible<br>
<br><br>
**Known issues:**
<br>
- Buildables seem to shift on Taviana after server restart (normally its only 1 meter and happens only once)<br>
- Camonets currently cannot be removed by owner or code, only default remove action<br>
<br><br>

### RECOMMENDED TO GET STARTED ###


- **Notepad++** -- [http://notepad-plus-plus.org/download/v6.3.html](http://notepad-plus-plus.org/download/v6.3.html)<br>
- **Notepad++ Compare Plugin** -- [http://sourceforge.net/projects/npp-compare/](http://sourceforge.net/projects/npp-compare/)<br>

### REQUIRED BEFORE INSTALLATION TUTORIAL ###

- **PBO View** (or equivalent pbo tool) --  [http://www.armaholic.com/page.php?id=1434](http://www.armaholic.com/page.php?id=1434)<br>
- **YOUR** servers **`dayz_1.YOURWORLD.pbo`** mission file<br>
- **YOUR** servers **`dayz_server.pbo`** hive server file<br>

## Installation Tutorial ##

**If you know how to unpbo and pbo your mission/server files, skip past step 6<br>**
1. Open PBO View<br>
2. Click Unpack at top (or `Ctrl + U`)<br>
3. Browse harddrive for YOUR **dayz\_1.YOURWORLD.pbo** mission file, select it and `click open`<br>
5. Do this for YOUR **dayz\_server.pbo** file too.<br>
6. Now youll have **YOUR server file** and **YOURWORLD mission file** unpbo'd<br>

##Part 1 - The Basics:
- Download the master branch from [https://github.com/Daimyo21/BaseBuilding-DayZ/archive/master.zip](https://github.com/Daimyo21/BaseBuilding-DayZ/archive/master.zip)<br>

- Extract to folder of your choice.<br>

- Once downloaded, you'll notice 2 folders, **dayz\_1.world** and **dayz\_server**<br>

- **dayz\_1.world** is a generic mission file that can be used with any DayZ map<br>

- **dayz\_server** is a generic bliss server file (last release before Reality), only including the files modified to get Base Building to work when the server restarts.  
Should transfer over to [**Reality Server Build**](https://github.com/thevisad/DayZ-Private-master) easily.<br>
If your using other server files like **Pwnzor**, it shouldnt be hard to implement if you know the server files well<br>

**I will not provide support for any other server build other than Bliss/Reality**
<br><br>
##Part 2 - dayz\_1.world folder:

Lets do the easy stuff first.  
Assuming you have **YOUR MISSION folder** open as well as **dayz\_1.world mission folder** opened <br><br>

- Simply Drag and Drop these files over FROM **dayz\_1.world** TO YOUR **dayz\_1.YOURWORLD** folders main directory:<br>

	>**-buildRecipeBook folder<br>
-dayz\_code folder<br>
-build\_recipe\_dialog.hpp<br>
-build\_recipe\_list\_dialog.hpp<br>
-defines.hpp**<br>


###**Modifying your description.ext:**<br>
- Follow the instructions in the **`description_code.txt`** file in **dayz\_1.world**<br>
- An **EXAMPLE description.ext** is included to show you how the added code should look<br>


###**Modifying your init.sqf:**<br>
- Follow the instructions in the **`init_code.txt`** file in **dayz\_1.world**<br>
- An **EXAMPLE init.sqf** is included to show you how the added code should look<br>


###**dayz\_code folder:**

- Goto **"dayz\_code\compile\\"** folder directory in YOUR **dayz\_1.YOURWORLD** mission folder (that we dragged in earlier)<br>

- **Pay attention to ONLY these files:**

	>**-fn\_selfActions 1.7.4.4 with Base Building 1.2 <br>
-fn\_selfActions 1.7.6.1 Default as of 3-15-2013 no BB<br>
-fn\_selfActions 1.7.6.1 with Base Building 1.2<br>
-player\_build - with ActiveCombat 1.1 compatibility<br>
-player\_build** <br>

###**For people who DO NOT have a modified fn\_selfActions.sqf:<br>**
If you **DO NOT** have a modified **fn\_selfActions.sqf** and are running **1.7.6.1**<br> <br>
- Simply rename 
**"fn\_selfActions 1.7.6.1 with Base Building 1.2"** to **fn\_selfActions.sqf**
<br>

- Then **delete**:

	>**-fn\_selfActions 1.7.4.4 with Base Building 1.2 <br>
-fn\_selfActions 1.7.6.1 Default as of 3-15-2013 no BB<br>**

(do this for whatever version you are running, if your running neither versions shown, Reference off the **README.txt** in the **compile folder**
<br>
###**People WITH Modified fn_selfActions.sqf:**
- Please reference the **README.txt** in the **compile folder** to understand the blocks of code placed in **fn_selfActions.sqf**
<br>


###People NOT running my [**ActiveCombat 1.1**](http://www.tunngle.net/community/topic/112181-activecombat-10-script-for-anti-combat-logging-needs/):

- Delete **"player\_build - with ActiveCombat 1.1 compatibility"** and KEEP **player_build**

###People who are running my [**ActiveCombat 1.1**](http://www.tunngle.net/community/topic/112181-activecombat-10-script-for-anti-combat-logging-needs/):

- Delete **player\_build.sqf** and **rename "player\_build - with ActiveCombat 1.1 compatibility"** to **player_build**
<br><br>

## Part 3 - dayz_server  (Modified Default Bliss) folder


- Start by opening up YOUR **"dayz\_server  (Modified Default Bliss)\README.txt"** 

- The README goes over 3 Sections.

**-Section 1 is mandatory if you want your buildables to be placed properly after server restart.**

- Open YOUR **dayz\_server folder\system\server\_monitor.sqf"**
- Follow instructions for Section 1 to setup the **server\_monitor.sqf**

**-Section 2 is REQUIRED if you did Section 1**

- Open YOUR **dayz\_server folder\init\server\_functions.sqf"**
- Follow instructions for Section 2 to setup the **server\_functions.sqf**

**-Section 3 is optional but recommended for server who want their bases to update in a 300 meter radius of KeyPad Panels**

- Copy the **"dayz\_server  (Modified Default Bliss)\compile\server\_updateNearbyObjects.sqf"**
- Paste and Overwrite YOUR servers  **dayz\_server\compile\server\_updateNearbyObjects.sqf"**
- Open YOUR **dayz\_server folder\compile\server\_updateObject.sqf"**
- Follow instructions for Section 3 to setup the **server\_updateObject.sqf**

-Use PBO View to pbo your **dayz\_1.YOURWORLD folder** and your **dayz\_server folder**


<br><br>
###Enjoy Building your new base!



##CREDITS:

- [**Simple bomb script by Igneous01**](http://www.armaholic...ge.php?id=15033):
- W4rGo for his excellent Build Recipe Menu Dialog
- Operational Gates by Humbleuk and Killzone Kid modified <br>
- DayZ Code from “Rocket” Dean Hall and DayZ community team<br>
- Code conversion algorithm for keypanel access by Xeno<br>
- Killzone Kid, Humbleuk and Ashfor for all their work/inspiration and any code utilized in this - release.<br>
- Ayan4m1/Bliss team Server Package and support<br>
- Entire DayZ community that help with coding and custom hooks/scripts/server support<br>
