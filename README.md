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
- WAIT FOR HOST: Look at new description_code.txt in dayz_1.world folder.  It explains a fix for this.

###Important for people experiencing broken codes!<br>
- **If CODE for Keypanels/Removing Objects were once working consistently but no longer work, you MUST go inside your database tool (workbench for me) under instance_deployables table, filter the "Code" for that object/panel and find it in table, then manually delete it!  If its not filtering, remove some numbers slowly until you get closest match and verify that its the object!**
<br><br>



### RECOMMENDED TO GET STARTED ###


- [Notepad++](http://notepad-plus-plus.org/download/v6.3.html)<br>
- [Notepad++ Compare Plugin](http://sourceforge.net/projects/npp-compare/)<br>
- [Arma 2 SQF Syntax Highlights for Notepad++ HIGHLY RECOMMENDED](http://forums.bistudio.com/showthread.php?91939-Notepad-SQF-syntax-highlight)<br>
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

### For People Running Reality Server Build for 1.7.6.1:
<br>
In YOUR **"dayz\_server\init\server\_functions.sqf"** 
<br>
Find this function:
>**check\_publishobject = { <br>
"bunch of code inside" <br>
};**

And Change this line:
>**if ((typeOf \_object) in \_allowedObjects) then {**

to:

>**if ((typeOf \_object) in \_allowedObjects || (typeOf \_object) in allbuildables\_class) then {**

This will insure that your buildables will write to database.
<br><br>


- First, go into YOUR **server_publishObject.sqf** Found in **"dayz\_server\compile\"** and change this:

>if (!(_object isKindOf "Building")) exitWith {<br>
deleteVehicle _object;<br>
};

TO:
> //if (!(_object isKindOf "Building")) exitWith {<br>
//deleteVehicle _object;<br>
//};

###Also for Reality Build users on 1.7.6.1 or objects not removing from Database after restart:

In
**"dayz_1.world\dayz\_code\actions\player\_remove.sqf"**


Change this:

>**if (isServer) then {
    dayzDeleteObj call local\_deleteObj;
};**

to this:



>**if (isServer) then {
    dayzDeleteObj call server\_deleteObj;
};**

Continue below.


- Now open the **"dayz\_server  (Modified Default Bliss)\README.txt"** 
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

##Battleye Filters:

**Can be found in the battleye folder.**  Not 100% sure if that is all the filters, please report any kicks that you do not know how to resolve or simply change to log only! 

Line 20 - 23 in scripts.txt add:

    !"_detonate = \"grenade\" createVehicle _pos;"


    5 createVehicle !"\"createVehicle\"," !"createVehicleLocal" !"createVehicle [\"WeaponHolder\", _iPos, [], _radius, \"CAN_COLLIDE\"" !"_fire = createVehicle [_classname, _location, [], 0, \"CAN_COLLIDE\"" !"_object = createVehicle [_classname, _location, [], 0, \"CAN_COLLIDE\"" !"if (_height < 100) then {\n_bolt = createVehicle [\"BoltSteelF\", _endPos, [], 0, \"CAN_COLLIDE\"];\n_bolt setPosATL _endPos;" !"_tent = createVehicle [\"TentStorage\", _location, [], 0, \"CAN_COLLIDE\"];\n_tent setdir _dir;" !"if ((random _int)>2.2) then\n{\n_b=\"SmallSecondary\" createvehicle (getpos _v);\n};" !"exitwith {};\n_b=\"SmallSecondary\" createvehicle (_v modelToWorld _effect2pos);\n} foreach (_list);" !"_bag = createVehicle [format[\"WeaponHolder_%1\",_item],getPosATL player,[], 0, \"CAN_COLLIDE\"];\n_bag setdir (getDir player);" !"_bag = createVehicle [\"WeaponHolder_ItemTent\",_pos,[], 0, \"CAN_COLLIDE\"];\n_bag setdir _dir;\nplayer reveal _bag;" !"_object = createVehicle [_classname, _location, [], 0, \"CAN_COLLIDE\"];\n_object setDir _dir;\nplayer reveal _object;" !"_item = createVehicle [_iItem, _iPos, [], _radius, \"CAN_COLLIDE\"];" !"_item = createVehicle [\"WeaponHolder\", position player, [], 0.0, \"CAN_COLLIDE\"];" !"_holder = \"WeaponHolder\" createVehicle _pos;" !"_bolt = createVehicle [\"WoodenArrowF\", _endPos, [], 0, \"CAN_COLLIDE\"];" !"_weapon = createVehicle [_classname, _location, [], 0, \"CAN_COLLIDE\"];" !"_fire = createVehicle [_classname, _location, [], 0, \"CAN_COLLIDE\"];" !"_weapon = _classname createVehicle _location;\n_weapon setDir _dir;\n_weapon setpos _location;\nplayer reveal _weapon;" !"dayz_hasFire = createVehicle [_classname, _location, [], 0, \"CAN_COLLIDE\"];"


    5 createVehicleLocal !"\"createVehicleLocal\"," !"_point = \"Logic\" createVehicleLocal getPosATL _unit;" !"_object =  _type createVehicleLocal _position;" !"_fl = \"#particlesource\" createVehicleLocal getpos _v;" !"_lightArea = \"#lightpoint\" createVehicleLocal (getPosATL _flare);" !"_lightSpark = \"#lightpoint\" createVehicleLocal (getPosATL _flare);" !"_source = \"#particlesource\" createVehicleLocal getpos (_this select 0);" !"_source = \"#particlesource\" createVehicleLocal _pos;\n_source setParticleParams" !"_smoke = \"#particlesource\" createVehicleLocal _pos;\n_smoke attachto [_v,[0,0,0],\"destructionEffect1\"];" !"_Crater= \"CraterLong\" createvehiclelocal [_pos select 0, _pos select 1, 0];\n_Crater setdir (_dir + (180 * _i));" !"_source = \"#particlesource\" createVehicleLocal getPosATL _unit;"

    1 disableUserInput !"\"disableUserInput\"," !"disableUserInput false;"

Ill update as long as people message me with kicks due to base building
##Database:


**BaseBuilding_Deployables.sql** can be found in:<br>      
>**"BaseBuilding-DayZ\basebuilding\database"**

- In MYSQL Workbench (or whatever you use to manage DB): 
- Set your default schema (the database you want to execute scripts on)
- Make sure you backup and delete your current deployable list. (also keep track of your current primary key IDs for your deployables as MINE may be different.)
- Go to: <br> File >> Open SQL scripts >> and find/open **BaseBuilding_Deployables.sql**

Execute the script.

<br>
###Enjoy Building your new base!

##Modifying Buildable Parameters##
###build_list.sqf:

- **Found in:
"dayz\_1.world\dayz\_code\external\dy\_work\build\_list.sqf"**

This is the file used to modify parameters such as:

- Recipe requirements
- _toolBox required?
- _eTool required?
- _medWait, _longWait (how long to build, if neither, then _smallWait)
-  _inBuilding allowed?
-  _roadAllowed ?
-  _inTown ?
-  _removable (can it be removed by default removal?)
-  _isStructure (is the buildable a structure?
-  _isSimulated (does it have physics?) 
-  _isDestructable (can it be destroyed?)

Alternatively, if you modify any of these parameters, they are **ONLY client side**.  In order to make sure these parameters stay persistent on server restart, you must modify the:

>build\_baseBuilding\_arrays = { BUNCH OF CODE SIMILAR TO BUILD_LIST.sqf };

Found in the **"dayz\_server  (Modified Default Bliss)\init\server\_functions.sqf"** that we installed earlier

You can simply copy and paste the:

>_buildlist = [ ENTIRE ARRAY WITH PARAMETERS YOU CHANGED ];

from **"dayz\_1.world\dayz\_code\external\dy\_work\build\_list.sqf"**

Into the server\_functions.sqf's 
**\_buildlist = [ SERVER BUILD LIST ARRAY ];**

Detailed information can be found inside the build_list.sqf  itself on how to modify these parameter arrays!

## Other Scripts

####player_bomb.sqf 
found in **dayz\_1.world\dayz\_code\external\dy\_work\player\_bomb.sqf**

Controls functionality of player placed bombs, modify at your own risk!

####anti_discWall.sqf
Anti measure for player exploits into walls
####antiWall.sqf
When player gets out of vehicle, it teleports him into the vehicle he was getting out of to counter he/she glitching through walls.

####dialog_menus by W4rGo
I recommend not modifying this and you must have permission from [**W4rGo**](https://github.com/w4rgo) to do so.


<br><br>
##CREDITS:

- [**Simple bomb script by Igneous01**](http://forums.bistudio.com/showthread.php?123621-Simple-Bomb-defusal-with-keypad):
- [**W4rGo**](https://github.com/w4rgo) for his excellent Build Recipe Menu Dialog
- Operational Gates by Humbleuk and Killzone Kid modified <br>
- DayZ Code from “Rocket” Dean Hall and DayZ community team<br>
- Code conversion algorithm for keypanel access by Xeno<br>
- Killzone Kid, Humbleuk and Ashfor for all their work/inspiration and any code utilized in this - release.<br>
- Ayan4m1/Bliss team Server Package and support<br>
- Entire DayZ community that help with coding and custom hooks/scripts/server support<br>
