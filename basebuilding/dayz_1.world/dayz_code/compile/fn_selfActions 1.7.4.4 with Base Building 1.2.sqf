scriptName "Functions\misc\fn_selfActions.sqf";
/***********************************************************
	ADD ACTIONS FOR SELF
	- Function
	- [] call fnc_usec_selfActions;
************************************************************/
private["_menClose","_hasBandage","_hasEpi","_hasMorphine","_hasBlood","_vehicle","_inVehicle","_color","_part"];

_vehicle = vehicle player;
_inVehicle = (_vehicle != player);
_bag = unitBackpack player;
_classbag = typeOf _bag;
_isWater = 		(surfaceIsWater (position player)) or dayz_isSwimming;
_hasAntiB = 	"ItemAntibiotic" in magazines player;
_hasFuelE = 	"ItemJerrycanEmpty" in magazines player;
_hasRawMeat = 	"FoodSteakRaw" in magazines player;
_hasKnife = 	"ItemKnife" in items player;
_hasToolbox = 	"ItemToolbox" in items player;
//_hasTent = 		"ItemTent" in items player;
_onLadder =		(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
_nearLight = 	nearestObject [player,"LitObject"];
_canPickLight = false;

if (!isNull _nearLight) then {
	if (_nearLight distance player < 4) then {
		_canPickLight = isNull (_nearLight getVariable ["owner",objNull]);
	};
};
_canDo = (!r_drag_sqf and !r_player_unconscious and !_onLadder);

//##### BASE BUILDING 1.2 Custom Actions (CROSSHAIR IS TARGETING NOTHING) #####
// #### START1 ####
_currentSkin = typeOf(player);
			// Get closest camonet since we cannot target with crosshair Base Building Script, got lazy here, didnt fix with array
			camoNetB_East = nearestObject [player, "Land_CamoNetB_EAST"];
			camoNetVar_East = nearestObject [player, "Land_CamoNetVar_EAST"];
			camoNet_East = nearestObject [player, "Land_CamoNet_EAST"];
			camoNetB_Nato = nearestObject [player, "Land_CamoNetB_NATO"];
			camoNetVar_Nato = nearestObject [player, "Land_CamoNetVar_NATO"];
			camoNet_Nato = nearestObject [player, "Land_CamoNet_NATO"];
	// Check mags in player inventory to show build recipe menu	
	_mags = magazines player;
	if ("ItemTankTrap" in _mags || "ItemSandbag" in _mags || "ItemWire" in _mags || "PartWoodPile" in _mags || "PartGeneric" in _mags) then {
		hasBuildItem = true;
	} else { hasBuildItem = false;};
	//Build Recipe Menu Action
	if((speed player <= 1) && hasBuildItem && _canDo) then {
		if (s_player_recipeMenu < 0) then {
			s_player_recipeMenu = player addaction [("<t color=""#0074E8"">" + ("Build Recipes") +"</t>"),"buildRecipeBook\build_recipe_dialog.sqf","",5,false,true,"",""];
		};
	} else {
		player removeAction s_player_recipeMenu;
		s_player_recipeMenu = -1;
	};

	//Add in custom eventhandlers or whatever on skin change
	if (_currentSkin != globalSkin) then {
		globalSkin = _currentSkin;
		player removeEventHandler ["AnimChanged",0];
		player removeMPEventHandler ["MPHit", 0]; 
		player removeEventHandler ["AnimChanged", 0];
		haloAction = player addEventHandler ["AnimChanged", {_this spawn ss_halo;}];
		ehWall = player addEventHandler ["AnimChanged", { player call antiWall; } ];
		empHit = player addMPEventHandler ["MPHit", {_this spawn fnc_plyrHit;}];
	};
	// Remove CamoNets, (Not effecient but works)
	if((isNull cursorTarget) && _hasToolbox && _canDo && !remProc && !procBuild && 
		(camoNetB_East distance player < 10 or 
		camoNetVar_East distance player < 10 or 
		camoNet_East distance player < 10 or 
		camoNetB_Nato distance player < 10 or 
		camoNetVar_Nato distance player < 10 or 
		camoNet_Nato distance player < 10)) then {
		if (s_player_deleteCamoNet < 0) then {
			s_player_deleteCamoNet = player addaction [("<t color=""#F01313"">" + ("Remove Netting") +"</t>"),"dayz_code\actions\player_remove.sqf","",1,true,true,"",""];
		};
	} else {
		player removeAction s_player_deleteCamoNet;
		s_player_deleteCamoNet = -1;
	};
//##### BASE BUILDING 1.2 Custom Actions (CROSSHAIR IS TARGETING NOTHING) #####
// #### END1 ####

//Grab Flare
if (_canPickLight and !dayz_hasLight) then {
	if (s_player_grabflare < 0) then {
		_text = getText (configFile >> "CfgAmmo" >> (typeOf _nearLight) >> "displayName");
		s_player_grabflare = player addAction [format[localize "str_actions_medical_15",_text], "\z\addons\dayz_code\actions\flare_pickup.sqf",_nearLight, 1, false, true, "", ""];
		s_player_removeflare = player addAction [format[localize "str_actions_medical_17",_text], "\z\addons\dayz_code\actions\flare_remove.sqf",_nearLight, 1, false, true, "", ""];
	};
} else {
	player removeAction s_player_grabflare;
	player removeAction s_player_removeflare;
	s_player_grabflare = -1;
	s_player_removeflare = -1;
};

// Anything below this line is only when players Crosshair has a target and (player distance cursorTarget < 4) << default
if (!isNull cursorTarget and !_inVehicle and (player distance cursorTarget < 4)) then {	//Has some kind of target
	_isHarvested = cursorTarget getVariable["meatHarvested",false];
	_isVehicle = cursorTarget isKindOf "AllVehicles";
	_isMan = cursorTarget isKindOf "Man";
	_ownerID = cursorTarget getVariable ["characterID","0"];
	_isAnimal = cursorTarget isKindOf "Animal";
	_isZombie = cursorTarget isKindOf "zZombie_base";
	_isDestructable = cursorTarget isKindOf "BuiltItems";
	_isTent = cursorTarget isKindOf "TentStorage";
	_isFuel = false;
	_isAlive = alive cursorTarget;
	_text = getText (configFile >> "CfgVehicles" >> typeOf cursorTarget >> "displayName");
	if (_hasFuelE) then {
		_isFuel = (cursorTarget isKindOf "Land_Ind_TankSmall") or (cursorTarget isKindOf "Land_fuel_tank_big") or (cursorTarget isKindOf "Land_fuel_tank_stairs") or (cursorTarget isKindOf "Land_wagon_tanker");
	};
	//diag_log ("OWNERID = " + _ownerID + " CHARID = " + dayz_characterID + " " + str(_ownerID == dayz_characterID));
	
	
//##### BASE BUILDING 1.2 Custom Actions (CROSSHAIR HAS A TARGET) #####
// ##### START #####
	// Operate Gates
	if ((dayz_myCursorTarget != cursorTarget) && (cursorTarget isKindOf "Infostand_2_EP1") && keyValid) then {
		_lever = cursorTarget;
		{dayz_myCursorTarget removeAction _x} forEach s_player_gateActions;s_player_gateActions = [];
		dayz_myCursorTarget = _lever;
		_gates = nearestObjects [_lever, ["Concrete_Wall_EP1"], 100];
		if (count _gates > 0) then {
			_handle = dayz_myCursorTarget addAction ["Operate Gate", "dayz_code\external\keypad\fnc_keyPad\operate_gates.sqf", _lever, 1, false, true, "", ""];
			s_player_gateActions set [count s_player_gateActions,_handle];
		};
	};

	// Remove Object Custom removal test
	if((typeOf(cursortarget) in allremovables) && _hasToolbox && _canDo && !remProc && !procBuild && !removeObject) then {
		if (s_player_deleteBuild < 0) then {
			s_player_deleteBuild = player addAction [format[localize "str_actions_delete",_text], "dayz_code\actions\player_remove.sqf",cursorTarget, 1, true, true, "", ""];
		};
	} else {
		player removeAction s_player_deleteBuild;
		s_player_deleteBuild = -1;
	};
	

	// Enter Code to Operate Gates Action
	if((speed player <= 1) && !keyValid && (typeOf(cursortarget) == "Infostand_2_EP1") && cursorTarget distance player < 5 && _canDo) then {
		if (s_player_enterCode < 0) then {
			s_player_enterCode = player addaction [("<t color=""#4DFF0D"">" + ("Enter Key Code to Operate Gate") +"</t>"),"dayz_code\external\keypad\fnc_keyPad\enterCode.sqf","",5,false,true,"",""];
		};
	} else {
		player removeAction s_player_enterCode;
		s_player_enterCode = -1;
	};
	
	// Enter Code to remove object
	if((speed player <= 1) && !removeObject && (typeOf(cursortarget) in allbuildables_class) && cursorTarget distance player < 5 && _canDo) then {
			if (s_player_codeObject < 0) then {
				s_player_codeObject = player addaction [("<t color=""#8E11F5"">" + ("Enter Code of Object to remove") +"</t>"),"dayz_code\external\keypad\fnc_keyPad\enterCode.sqf","",5,false,true,"",""];
			};
	} else {
		player removeAction s_player_codeObject;
		s_player_codeObject = -1;
	};
	
	// Remove Object from code
	if((typeOf(cursortarget) in allbuildables_class) && _canDo && removeObject && !procBuild && !remProc) then {
		_validObject = cursortarget getVariable ["validObject",false];
		if (_validObject) then {
			if (s_player_codeRemove < 0) then {
				s_player_codeRemove = player addaction [("<t color=""#8E11F5"">" + ("Base Owners Remove Object") +"</t>"),"dayz_code\actions\player_remove.sqf","",5,false,true,"",""];
			};
		} else {
			player removeAction s_player_codeRemove;
			s_player_codeRemove = -1;
		};
	} else {
		player removeAction s_player_codeRemove;
		s_player_codeRemove = -1;
	};

	// Smelt Items/Smelt Recipe Menu Action - W4rGo
	if((inflamed cursorTarget && cursorTarget distance player < 5) && _canDo && !remProc && !procBuild) then {
		if (s_player_smeltItems < 0) then {
			s_player_smeltItems = player addaction[("<t color=""#ffb000"">" + ("Smelt Items") +"</t>"),"dayz_code\actions\player_smelt.sqf","",1,true,true,"", ""];
		};
		if (s_player_smeltRecipes < 0) then {
			s_player_smeltRecipes = player addaction[("<t color=""#00adeb"">" + ("Smelt Recipes") +"</t>"),"dayz_code\actions\player_smeltBook.sqf","",1,true,true,"", ""];	
		};
	} else {
		player removeAction s_player_smeltItems;
		s_player_smeltItems = -1;
		player removeAction s_player_smeltRecipes;
		s_player_smeltRecipes = -1;
	};
	// Disarm Booby Trap Action
	if(_hasToolbox && _canDo && !remProc && !procBuild && (cursortarget iskindof "Grave" && cursortarget distance player < 2.5 && !(cursortarget iskindof "Body" || cursortarget iskindof "GraveCross1" || cursortarget iskindof "GraveCross2" || cursortarget iskindof "GraveCrossHelmet" || cursortarget iskindof "Land_Church_tomb_1" || cursortarget iskindof "Land_Church_tomb_2" || cursortarget iskindof "Land_Church_tomb_3" || cursortarget iskindof "Mass_grave"))) then {
		if (s_player_disarmBomb < 0) then {
			s_player_disarmBomb = player addaction [("<t color=""#F01313"">" + ("Disarm Bomb") +"</t>"),"dayz_code\actions\player_disarmBomb.sqf","",1,true,true,"", ""];
		};
	} else {
		player removeAction s_player_disarmBomb;
		s_player_disarmBomb = -1;
	};
	
	
//##### BASE BUILDING 1.2 Custom Actions (CROSSHAIR HAS A TARGET) #####
// ##### END #####

// THIS NEEDS TO BE REMOVED \/ \/ \/ For BASE BUILDING REMOVAL TO WORK
	//Allow player to delete objects
/* << REMOVE THESE TOO!	
if(_isDestructable and _hasToolbox and _canDo) then {
		if (s_player_deleteBuild < 0) then {
			s_player_deleteBuild = player addAction [format[localize "str_actions_delete",_text], "\z\addons\dayz_code\actions\remove.sqf",cursorTarget, 1, true, true, "", ""];
		};
	} else {
		player removeAction s_player_deleteBuild;
		s_player_deleteBuild = -1;
	};
*/	//<< REMOVE THESE TOO!
// THIS NEEDS TO BE REMOVED /\ /\ /\ For BASE BUILDING REMOVAL TO WORK

	/*
	//Allow player to force save
	if((_isVehicle or _isTent) and _canDo and !_isMan) then {
		if (s_player_forceSave < 0) then {
			s_player_forceSave = player addAction [format[localize "str_actions_save",_text], "\z\addons\dayz_code\actions\forcesave.sqf",cursorTarget, 1, true, true, "", ""];
		};
	} else {
		player removeAction s_player_forceSave;
		s_player_forceSave = -1;
	};
	*/
	
	//Allow player to fill jerrycan
	if(_hasFuelE and _isFuel and _canDo) then {
		if (s_player_fillfuel < 0) then {
			s_player_fillfuel = player addAction [localize "str_actions_self_10", "\z\addons\dayz_code\actions\jerry_fill.sqf",[], 1, false, true, "", ""];
		};
	} else {
		player removeAction s_player_fillfuel;
		s_player_fillfuel = -1;
	};
	
	if (!alive cursorTarget and _isAnimal and _hasKnife and !_isHarvested and _canDo) then {
		if (s_player_butcher < 0) then {
			s_player_butcher = player addAction [localize "str_actions_self_04", "\z\addons\dayz_code\actions\gather_meat.sqf",cursorTarget, 3, true, true, "", ""];
		};
	} else {
		player removeAction s_player_butcher;
		s_player_butcher = -1;
	};
	
	//Fireplace Actions check
	if(inflamed cursorTarget and _hasRawMeat and _canDo) then {
		if (s_player_cook < 0) then {
			s_player_cook = player addAction [localize "str_actions_self_05", "\z\addons\dayz_code\actions\cook.sqf",cursorTarget, 3, true, true, "", ""];
		};
	} else {
		player removeAction s_player_cook;
		s_player_cook = -1;
	};
	if(cursorTarget == dayz_hasFire and _canDo) then {
		if ((s_player_fireout < 0) and !(inflamed cursorTarget) and (player distance cursorTarget < 3)) then {
			s_player_fireout = player addAction [localize "str_actions_self_06", "\z\addons\dayz_code\actions\fire_pack.sqf",cursorTarget, 0, false, true, "",""];
		};
	} else {
		player removeAction s_player_fireout;
		s_player_fireout = -1;
	};
	
	//place tent
	//if(_hasTent and _canDo) then {
	//		s_player_placetent = player addAction [localize "Place Tent", "\z\addons\dayz_code\actions\tent_pitch.sqf",cursorTarget, 0, false, true, "", ""];
	//} else {
	//	player removeAction s_player_placetent;
	//	s_player_placetent = -1;
	//};
	
	//Packing my tent
	if(cursorTarget isKindOf "TentStorage" and _canDo and _ownerID == dayz_characterID) then {
		if ((s_player_packtent < 0) and (player distance cursorTarget < 3)) then {
			s_player_packtent = player addAction [localize "str_actions_self_07", "\z\addons\dayz_code\actions\tent_pack.sqf",cursorTarget, 0, false, true, "",""];
		};
	} else {
		player removeAction s_player_packtent;
		s_player_packtent = -1;
	};
	
	//Repairing Vehicles
	if ((dayz_myCursorTarget != cursorTarget) and !_isMan and _hasToolbox and (damage cursorTarget < 1)) then {
		_vehicle = cursorTarget;
		{dayz_myCursorTarget removeAction _x} forEach s_player_repairActions;s_player_repairActions = [];
		dayz_myCursorTarget = _vehicle;

		_allFixed = true;
		_hitpoints = _vehicle call vehicle_getHitpoints;
		
		{
			_damage = [_vehicle,_x] call object_getHit;
			_part = "PartGeneric";
			
			//change "HitPart" to " - Part" rather than complicated string replace
			_cmpt = toArray (_x);
			_cmpt set [0,20];
			_cmpt set [1,toArray ("-") select 0];
			_cmpt set [2,20];
			_cmpt = toString _cmpt;
				
			if(["Engine",_x,false] call fnc_inString) then {
				_part = "PartEngine";
			};
					
			if(["HRotor",_x,false] call fnc_inString) then {
				_part = "PartVRotor"; //yes you need PartVRotor to fix HRotor LOL
			};

			if(["Fuel",_x,false] call fnc_inString) then {
				_part = "PartFueltank";
			};
			
			if(["Wheel",_x,false] call fnc_inString) then {
				_part = "PartWheel";

			};
					
			if(["Glass",_x,false] call fnc_inString) then {
				_part = "PartGlass";
			};

			// get every damaged part no matter how tiny damage is!
			if (_damage > 0) then {
				
				_allFixed = false;
				_color = "color='#ffff00'"; //yellow
				if (_damage >= 0.5) then {_color = "color='#ff8800'";}; //orange
				if (_damage >= 0.9) then {_color = "color='#ff0000'";}; //red

				_string = format["<t %2>Repair%1</t>",_cmpt,_color]; //Repair - Part
				_handle = dayz_myCursorTarget addAction [_string, "\z\addons\dayz_code\actions\repair.sqf",[_vehicle,_part,_x], 0, false, true, "",""];
				s_player_repairActions set [count s_player_repairActions,_handle];

			};
					
		} forEach _hitpoints;
		if (_allFixed) then {
			_vehicle setDamage 0;
		};
	};
	
	if (_isMan and !_isAlive and !_isZombie) then {
		if (s_player_studybody < 0) then {
			s_player_studybody = player addAction [localize "str_action_studybody", "\z\addons\dayz_code\actions\study_body.sqf",cursorTarget, 0, false, true, "",""];
		};
	} else {
		player removeAction s_player_studybody;
		s_player_studybody = -1;
	};	
} else {
	//Engineering
	{dayz_myCursorTarget removeAction _x} forEach s_player_repairActions;s_player_repairActions = [];
	dayz_myCursorTarget = objNull;
	
// ### BASE BUILDING 1.2 ### For gates: 
// ### START ###
	{dayz_myCursorTarget removeAction _x} forEach s_player_gateActions;s_player_gateActions = [];
	dayz_myCursorTarget = objNull;	
// ### BASE BUILDING 1.2 ### For gates: 
// ### END ###

	//Others
	player removeAction s_player_deleteBuild;//replaced with bb 1.2 removal
	s_player_deleteBuild = -1;
	
// ### BASE BUILDING 1.2 ### Add in these: 
// ### START ###
	player removeAction s_player_codeRemove;
	s_player_codeRemove = -1;
	player removeAction s_player_forceSave;
	s_player_forceSave = -1;
	player removeAction s_player_disarmBomb;
	s_player_disarmBomb = -1;
	player removeAction s_player_codeObject;
	s_player_codeObject = -1;
	player removeAction s_player_enterCode;
	s_player_enterCode = -1;
	player removeAction s_player_smeltRecipes;
	s_player_smeltRecipes = -1;
	player removeAction s_player_smeltItems;
	s_player_smeltItems = -1;
// ### BASE BUILDING 1.2 ### Add in these:
// ### END ###
	
	player removeAction s_player_butcher;
	s_player_butcher = -1;
	player removeAction s_player_cook;
	s_player_cook = -1;
	player removeAction s_player_fireout;
	s_player_fireout = -1;
	player removeAction s_player_packtent;
	s_player_packtent = -1;
	player removeAction s_player_fillfuel;
	s_player_fillfuel = -1;
	player removeAction s_player_studybody;
	s_player_studybody = -1;
};