The main purpose of these files are to sync the build arrays and object placement when server restarts
as well as update objects when players operate gates (optional)

These are dayz_server files from default bliss before ayan stop working on them (not the latest reality bliss by theVisad)

The files included are the only server files that have been modified (I highly recommend you do NOT and overwrite)
I've commented sections in each file to show where Base Building 1.2 is modified

===IMPORTANT===:
When copying in code, I placed a // ### COPY START  and // ### COPY END from where to begin copying and to stop copying
for each block of code

======= SECTION 1 START ========== "dayz_server\system\server_monitor.sqf"

Blocks of code added in are:
LINE 10:

Code must be added DIRECTLY AFTER: waitUntil{initialized};

// ####Copy START
// ### BASE BUILDING 1.2 ### SERVER SIDE BUILD ARRAYS - START
call build_baseBuilding_arrays;
// ### BASE BUILDING 1.2 ### SERVER SIDE BUILD ARRAYS - END
// ####Copy END

LINE 111:

Must be added directly after:
		
		if (_object isKindOf "TentStorage") then {
			_pos set [2,0];
			_object setpos _pos;
		};
		_object setdir _dir;
		_object setDamage _damage;
		

// ####Copy START
// ##### BASE BUILDING 1.2 Server Side ##### - START
// This sets objects to appear properly once server restarts
		//_object setVariable ["ObjectUID", _worldspace call dayz_objectUID2, true]; // Optional (REMOVE // lines before _object) May fix DayZ.ST issues, or issues related to Panel codes not working thanks nullpo
		if ((_object isKindOf "Static") && !(_object isKindOf "TentStorage")) then {
			_object setpos [(getposATL _object select 0),(getposATL _object select 1), 0];
		};
		//Set Variable
		if (_object isKindOf "Infostand_2_EP1" && !(_object isKindOf "Infostand_1_EP1")) then {
			_object setVariable ["ObjectUID", _worldspace call dayz_objectUID2, true];
		};


				// Set whether or not buildable is destructable
		if (typeOf(_object) in allbuildables_class) then {
			diag_log ("SERVER: in allbuildables_class:" + typeOf(_object) + " !");
			for "_i" from 0 to ((count allbuildables) - 1) do
			{
				_classname = (allbuildables select _i) select _i - _i + 1;
				_result = [_classname,typeOf(_object)] call BIS_fnc_areEqual;
				if (_result) then {
					_requirements = (allbuildables select _i) select _i - _i + 2;

					_isDestructable = _requirements select 13;
					diag_log ("SERVER: " + typeOf(_object) + " _isDestructable = " + str(_isDestructable));
					if (!_isDestructable) then {
						diag_log("Spawned: " + typeOf(_object) + " Handle Damage False");
						_object addEventHandler ["HandleDamage", {false}];
					};
				};
			};
			//gateKeypad = _object addaction ["Defuse", "\z\addons\dayz_server\compile\enterCode.sqf"];
		};
// ##### BASE BUILDING 1.2 Server Side ##### - END
// This sets objects to appear properly once server restarts
// ###COPY END


===== SECTION 1 END =====
		
		
		
========== SECTION 2 START =========== "dayz_server\init\server_functions.sqf"

ADD THIS FUNCTION (block of code) TO THE VERY BOTTOM OF YOUR server_functions.sqf:


// ### COPY START
// BASE BUILDING 1.2 Build Array
build_baseBuilding_arrays = {

// ################################### BUILD LIST ARRAY SERVER SIDE ######################################## START
/*
Build list by Daimyo for SERVER side
Add and remove recipes, Objects(classnames), requirments to build, and town restrictions + extras
This method is used because we are referencing magazines from player inventory as buildables.
Main array (_buildlist) consist of 34 arrays within. These arrays contains parameters for player_build.sqf
From left to right, each array contains 3 elements, 1st: Recipe Array, 2nd: "Classname", 3rd: Requirements array. 
Check comments below for more info on parameters
*/
private["_isDestructable","_classname","_isSimulated","_disableSims","_objectSims","_objectSim","_requirements","_isStructure","_structure","_wallType","_removable","_buildlist","_build_townsrestrict"];
// Count is 34
// Info on Parameters (Copy and Paste to add more recipes and their requirments!):
//[TankTrap, SandBags, Wires, Logs, Scrap Metal, Grenades], "Classname", [_attachCoords, _startPos, _modDir, _toolBox, _eTool, _medWait, _longWait, _inBuilding, _roadAllowed, _inTown, _removable, _isStructure, _isSimulated, _isDestructable];
_buildlist = [
[[0, 1, 0, 0, 1, 1], "Grave", 						[[0,2.5,.1],[0,2,0], 	0, 	true, true, true, false, false, true, true, false, false, true, false]],//Booby Traps --1
[[2, 0, 0, 3, 1, 0], "Concrete_Wall_EP1", 			[[0,5,1.75],[0,2,0], 	0, 	true, false, true, false, false, true, false, false, false, true, false]],//Gate Concrete Wall --2
[[1, 0, 1, 0, 1, 0], "Infostand_2_EP1",				[[0,2.5,.6],[0,2,0], 	0, 	true, false, true, false, false, false, false, false, false, false, false]],//Gate Panel w/ KeyPad --3
[[3, 3, 2, 2, 0, 0], "WarfareBDepot",				[[0,18,2], 	[0,15,0], 	90, true, true, false, true, false, false, false, false, true, true, false]],//WarfareBDepot --4
[[4, 1, 2, 2, 0, 0], "Base_WarfareBBarrier10xTall", [[0,10,1], 	[0,10,0], 	0, 	true, true, false, true, false, false, false, false, false, true, false]],//Base_WarfareBBarrier10xTall --5 
[[2, 1, 2, 1, 0, 0], "WarfareBCamp",				[[0,12,1], 	[0,10,0], 	0, 	true, true, false, true, false, false, false, false, true, true, false]],//WarfareBCamp --6
[[2, 1, 1, 1, 0, 0], "Base_WarfareBBarrier10x", 	[[0,10,.6], [0,10,0], 	0, 	true, true, false, true, false, false, false, false, false, true, false]],//Base_WarfareBBarrier10x --7
[[2, 2, 0, 2, 0, 0], "Land_fortified_nest_big", 	[[0,12,1], 	[2,8,0], 	180,true, true, false, true, false, false, false, false, true, true, false]],//Land_fortified_nest_big --8
[[2, 1, 2, 2, 0, 0], "Land_Fort_Watchtower",		[[0,10,2.2],[0,8,0], 	90, true, true, false, true, false, false, false, false, true, true, false]],//Land_Fort_Watchtower --9
[[4, 1, 1, 3, 0, 0], "Land_fort_rampart_EP1", 		[[0,7,.2], 	[0,8,0], 	0, 	true, true, false, true, false, false, false, true, false, true, false]],//Land_fort_rampart_EP1 --10
[[2, 1, 1, 0, 0, 0], "Land_HBarrier_large", 		[[0,7,1], 	[0,4,0], 	0, 	true, true, true, false, false, false, false, false, false, true, false]],//Land_HBarrier_large --11
[[2, 1, 0, 1, 0, 0], "Land_fortified_nest_small",	[[0,7,1], 	[0,3,0], 	90, true, true, true, false, false, false, false, false, true, true, false]],//Land_fortified_nest_small --12
[[0, 1, 1, 0, 0, 0], "Land_BagFenceRound",			[[0,4,.5], 	[0,2,0], 	180,true, true, false, false, false, false, false, true, false, true, false]],//Land_BagFenceRound --13
[[0, 1, 0, 0, 0, 0], "Land_fort_bagfence_long", 	[[0,4,.3], 	[0,2,0], 	0, 	true, true, false, false, false, false, false, true, false, true, false]],//Land_fort_bagfence_long --14
[[6, 0, 0, 0, 2, 0], "Land_Misc_Cargo2E",			[[0,7,2.6], [0,5,0], 	90, true, false, false, true, false, false, false, false, false, true, false]],//Land_Misc_Cargo2E --15
[[5, 0, 0, 0, 1, 0], "Misc_Cargo1Bo_military",		[[0,7,1.3], [0,5,0], 	90, true, false, false, true, false, false, false, false, false, true, false]],//Misc_Cargo1Bo_military --16
[[3, 0, 0, 0, 1, 0], "Ins_WarfareBContructionSite",	[[0,7,1.3], [0,5,0], 	90, true, false, false, true, false, false, false, false, false, true, false]],//Ins_WarfareBContructionSite --17
[[1, 1, 0, 2, 1, 0], "Land_pumpa",					[[0,3,.4], 	[0,3,0], 	0, 	true, true, true, false, false, false, false, true, false, true, false]],//Land_pumpa --18
[[1, 0, 0, 0, 0, 0], "Land_CncBlock",				[[0,3,.4], 	[0,2,0], 	0, 	true, false, false, false, false, true, true, true, false, true, false]],//Land_CncBlock --19
[[4, 0, 0, 0, 0, 0], "Hhedgehog_concrete",			[[0,5,.6], 	[0,4,0], 	0, 	true, true, false, true, false, true, false, false, false, true, false]],//Hhedgehog_concrete --20
[[1, 0, 0, 0, 1, 0], "Misc_cargo_cont_small_EP1",	[[0,5,1.3], [0,4,0], 	90, true, false, false, false, false, false, false, true, false, true, false]],//Misc_cargo_cont_small_EP1 --21
[[1, 0, 0, 2, 0, 0], "Land_prebehlavka",			[[0,6,.7], 	[0,3,0], 	90, true, false, false, false, false, false, false, true, false, true, true]],//Land_prebehlavka(Ramp) --22
[[2, 0, 0, 0, 0, 0], "Fence_corrugated_plate",		[[0,4,.6], 	[0,3,0], 	0,	true, false, false, false, false, false, false, true, false, true, true]],//Fence_corrugated_plate --23
[[2, 0, 1, 0, 0, 0], "ZavoraAnim", 					[[0,5,4.0], [0,5,0], 	0, 	true, false, false, false, false, true, false, true, false, true, true]],//ZavoraAnim --24
[[0, 0, 7, 0, 1, 0], "Land_tent_east", 				[[0,8,1.7], [0,6,0], 	0, 	true, false, false, true, false, false, false, false, true, true, true]],//Land_tent_east --25
[[0, 0, 6, 0, 1, 0], "Land_CamoNetB_EAST",			[[0,10,2], 	[0,10,0], 	0, 	true, false, false, true, false, false, false, true, true, true, true]],//Land_CamoNetB_EAST --26
[[0, 0, 5, 0, 1, 0], "Land_CamoNetB_NATO", 			[[0,10,2], 	[0,10,0], 	0, 	true, false, false, true, false, false, false, true, true, true, true]],//Land_CamoNetB_NATO --27
[[0, 0, 4, 0, 1, 0], "Land_CamoNetVar_EAST",		[[0,10,1.2],[0,7,0], 	0, 	true, false, true, false, false, false, false, true, false, true, true]],//Land_CamoNetVar_EAST --28
[[0, 0, 3, 0, 1, 0], "Land_CamoNetVar_NATO", 		[[0,10,1.2],[0,7,0], 	0, 	true, false, true, false, false, false, false, true, false, true, true]],//Land_CamoNetVar_NATO --29
[[0, 0, 2, 0, 1, 0], "Land_CamoNet_EAST",			[[0,8,1.2], [0,7,0], 	0, 	true, false, true, false, false, false, false, true, false, true, true]],//Land_CamoNet_EAST --30
[[0, 0, 1, 0, 1, 0], "Land_CamoNet_NATO",			[[0,8,1.2], [0,7,0], 	0, 	true, false, true, false, false, false, false, true, false, true, true]],//Land_CamoNet_NATO --31
[[0, 0, 2, 2, 0, 0], "Fence_Ind_long",				[[0,5,.6], 	[-4,1.5,0], 0, 	true, false, true, false, false, false, false, true, false, true, true]], //Fence_Ind_long --32
[[0, 0, 2, 0, 0, 0], "Fort_RazorWire",				[[0,5,.8], 	[0,4,0], 	0, 	true, false, false, false, false, false, false, true, false, true, true]],//Fort_RazorWire --33
[[0, 0, 1, 0, 0, 0], "Fence_Ind",  					[[0,4,.7], 	[0,2,0], 	0, 	true, false, false, false, false, false, true, true, false, true, true]] //Fence_Ind 	--34 *** Remember that the last element in array does not get comma ***
];
// Build allremovables array for remove action
for "_i" from 0 to ((count _buildlist) - 1) do
{
	_removable = (_buildlist select _i) select _i - _i + 1;
	if (_removable != "Grave") then { // Booby traps have disarm bomb
	allremovables set [count allremovables, _removable];
	};
};
// Build classnames array for use later
for "_i" from 0 to ((count _buildlist) - 1) do
{
	_classname = (_buildlist select _i) select _i - _i + 1;
	allbuildables_class set [count allbuildables_class, _classname];
};


/*
*** Remember that the last element in ANY array does not get comma ***
Notice lines 47 and 62
*/
// Towns to restrict from building in. (Type exact name as shown on map, NOT Case-Sensitive but spaces important)
// ["Classname", range restriction];
// NOT REQUIRED SERVER SIDE, JUST ADDED IN IF YOU NEED TO USE IT
_build_townsrestrict = [
["Lyepestok", 1000],
["Sabina", 900],
["Branibor", 600],
["Bilfrad na moru", 400],
["Mitrovice", 350],
["Seven", 300],
["Blato", 300]
];
// Here we are filling the global arrays with this local list
allbuildables = _buildlist;
allbuild_notowns = _build_townsrestrict;

// ################################### BUILD LIST ARRAY SERVER SIDE ######################################## END

};
//##### COPY END


// =======SECTION 2 END=========




========= SECTION 3 START ============= "dayz_server\compile\server_updateObject.sqf"

In your default server_updateObject.sqf (BLISS OR REALITY BUILD)

Find _object_inventory = {

blah blah blah default code

};

And replace with this:
// ###COPY START
_object_inventory = {
// ### BASE BUILDING 1.2 ### START 
//This forces object to write to database changing the inventory of the object twice 
// so it updates the object from operate_gates.sqf 

	private["_inventory","_previous","_key"];
	// This writes to database if object is buildable
	if (typeOf(_object) in allbuildables_class) then {
	//First lets make inventory [[[],[]],[[],[]],[[],[]]] so it updates object in DB
			_inventory = [[[],[]],[[],[]],[[],[]]];
		if (_objectID == "0") then {
			_key = format["CHILD:309:%1:%2:",_uid,_inventory];
		} else {
			_key = format["CHILD:303:%1:%2:",_objectID,_inventory];
		};
		diag_log ("HIVE: Buildable: "+ str(_key));
		_key call server_hiveWrite;
	//Since we cant actually read from DB, lets make inventory this [], than write it again, to insure its updated to DB
			_inventory = [];
		if (_objectID == "0") then {
			_key = format["CHILD:309:%1:%2:",_uid,_inventory];
		} else {
			_key = format["CHILD:303:%1:%2:",_objectID,_inventory];
		};
		diag_log ("HIVE: Buildable: "+ str(_key));
		_key call server_hiveWrite;
// DO DEFAULT server_updateObject if not a buildable
	} else {
			_inventory = [
			getWeaponCargo _object,
			getMagazineCargo _object,
			getBackpackCargo _object
		];
	

		_previous = str(_object getVariable["lastInventory",[]]);
		if (str(_inventory) != _previous) then {
			_object setVariable["lastInventory",_inventory];
			if (_objectID == "0") then {
				_key = format["CHILD:309:%1:%2:",_uid,_inventory];
			} else {
				_key = format["CHILD:303:%1:%2:",_objectID,_inventory];
			};
			diag_log ("HIVE: WRITE: "+ str(_key));
			_key call server_hiveWrite;
		};
	};
};
// ### BASE BUILDING 1.2 ### END
// ###COPY END


//=======SECTION 3 END =========

DONE!