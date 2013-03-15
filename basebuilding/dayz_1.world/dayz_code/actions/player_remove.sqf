private["_func_ownerRemove","_qtyS","_qtyW","_qtyL","_qtyM","_qtyG","_qtyT","_removable","_eTool","_result","_building","_dialog","_classname","_requirements","_objectID","_objectUID","_obj","_cnt","_id","_tblProb","_locationPlayer","_randNum2","_smallWloop","_medWloop","_longWloop","_wait","_longWait","_medWait","_highP","_medP","_lowP","_failRemove","_canRemove","_randNum","_text","_dir","_pos","_isWater","_inVehicle","_onLadder","_hasToolbox","_canDo","_hasEtool"];
disableserialization;
_obj = cursorTarget;
if (_obj isKindof "Grave") then {
_text = "Bomb";
cutText [format["You can only disarm %1 to remove it",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit";
};
// Get ObjectID or UID
if (!isNull _obj) then {
_objectID = _obj getVariable["ObjectID","0"];
_objectUID = _obj getVariable["ObjectUID","0"];
};

_ownerID = _obj getVariable ["characterID","0"];
// Pre-Checks
_dir = direction _obj;
_pos = getposATL _obj;
_locationPlayer = player modeltoworld [0,0,0];
_onLadder 		= (getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
_isWater 		= (surfaceIsWater _locationPlayer) or dayz_isSwimming;
_inVehicle 		= (vehicle player != player);
_building 		= nearestObject [player, "Building"];
_onLadder 		=		(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
_hasToolbox 	= 	"ItemToolbox" in items player;
_canDo 			= (!r_drag_sqf and !r_player_unconscious and !_onLadder); //USE!!
_hasEtool 		= 	"ItemEtool" in weapons player;

//Booleans
_canRemove 		= false;
_failRemove		= false;
_result 		= false;

//Integers
_longWloop 		= 6; // larger object loop, decrease to decrease time
_medWloop 		= 4;
_smallWloop 	= 3;
_tblProb 		= 30;
_lowP 			= 35;
_medP 			= 70;
_highP 			= 95;
_cnt 			= 0;
_wait 			= 10;

_qtyT = 0;
_qtyS = 0; //144752844454260
_qtyW = 0;
_qtyL = 0;
_qtyM = 0;
_qtyG = 0;
// Do percentages
_randNum = round(random 100);
_randNum2 = round(random 100);

//Others
if(_isWater) then {cutText [localize "str_player_26", "PLAIN DOWN"];breakOut "exit";};
if(_onLadder) then {cutText [localize "str_player_21", "PLAIN DOWN"];breakOut "exit";};
if (_inVehicle) then {cutText [localize "Can't do this in vehicle", "PLAIN DOWN"];breakOut "exit";};

_func_ownerRemove = {

for "_i" from 0 to ((count allbuildables) - 1) do
	{
		_classname = (allbuildables select _i) select _i - _i + 1;
		_result = [typeOf(_obj),_classname] call BIS_fnc_areEqual;
			if (_result) then {
				_recipe = (allbuildables select _i) select _i - _i;
				//[_qtyT, _qtyS, _qtyW, _qtyL, _qtyM, _qtyG]
				_qtyT = _recipe select 0;
				_qtyS = _recipe select 1;
				_qtyW = _recipe select 2;
				_qtyL = _recipe select 3;
				_qtyM = _recipe select 4;
				_qtyG = _recipe select 5;
			};
	};
	if (_qtyT > 0) then {
		for "_i" from 1 to _qtyT do { _result = [player,"ItemTankTrap"] call BIS_fnc_invAdd;  };
	};
	if (_qtyS > 0) then {
		for "_i" from 1 to _qtyS do { _result = [player,"ItemSandbag"] call BIS_fnc_invAdd;  };
	};
	if (_qtyW > 0) then {
		for "_i" from 1 to _qtyW do { _result = [player,"ItemWire"] call BIS_fnc_invAdd;  };
	};
	if (_qtyL > 0) then {
		for "_i" from 1 to _qtyL do { _result = [player,"PartWoodPile"] call BIS_fnc_invAdd; };
	};
	if (_qtyM > 0) then {
		for "_i" from 1 to _qtyM do { _result = [player,"PartGeneric"] call BIS_fnc_invAdd;  };
	};
	if (_qtyG > 0) then {
		for "_i" from 1 to _qtyG do { _result = [player,"HandGrenade_west"] call BIS_fnc_invAdd;  };
	};
	cutText [format["Owner refunded for object %1",typeof(_obj)], "PLAIN DOWN",1];
		dayzDeleteObj = [_objectID,_objectUID];
	publicVariableServer "dayzDeleteObj";
	if (isServer) then {
		dayzDeleteObj call local_deleteObj;
	};
		deletevehicle _obj; 
		breakout "exit";

};


		_validObject = _obj getVariable ["validObject",false];
if (removeObject && _validObject) then {
	call _func_ownerRemove;
};

if ( _ownerID == dayz_characterID ) then { 
	call _func_ownerRemove;
};
remProc = true;

//Determine camoNet since camoNets cannot be targeted with Crosshair

switch (true) do
{
	case(camoNetB_East distance player < 10 && isNull _obj):
	{
		_obj = camoNetB_East;
		_objectID = _obj getVariable["ObjectID",0];
		_objectUID = _obj getVariable["ObjectUID","0"];
	};
	case(camoNetVar_East distance player < 10 && isNull _obj):
	{
		_obj = camoNetVar_East;
		_objectID = _obj getVariable["ObjectID",0];
		_objectUID = _obj getVariable["ObjectUID","0"];
	};
	case(camoNet_East distance player < 10 && isNull _obj):
	{
		_obj = camoNet_East;
		_objectID = _obj getVariable["ObjectID",0];
		_objectUID = _obj getVariable["ObjectUID","0"];
	};
	case(camoNetB_Nato distance player < 10 && isNull _obj):
	{
		_obj = camoNetB_Nato;
		_objectID = _obj getVariable["ObjectID",0];
		_objectUID = _obj getVariable["ObjectUID","0"];
	};
	case(camoNetVar_Nato distance player < 10 && isNull _obj):
	{
		_obj = camoNetVar_Nato;
		_objectID = _obj getVariable["ObjectID",0];
		_objectUID = _obj getVariable["ObjectUID","0"];
	};
	case(camoNet_Nato distance player < 10 && isNull _obj):
	{
		_obj = camoNet_Nato;
		_objectID = _obj getVariable["ObjectID",0];
		_objectUID = _obj getVariable["ObjectUID","0"];
	};

};


// Check what object is returned from global array, then return classname
	for "_i" from 0 to ((count allbuildables) - 1) do
	{
		_classname = (allbuildables select _i) select _i - _i + 1;
		_result = [typeOf(_obj),_classname] call BIS_fnc_areEqual;
			if (_result) then {
				//_text = _classname;
				_text = getText (configFile >> "CfgVehicles" >> typeOf cursorTarget >> "displayName");
				_requirements = (allbuildables select _i) select _i - _i + 2;
			};
	};
if (!_hasToolbox) then {cutText [format["You need a tool box to remove %1",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
		
//Get Requirements from build_list.sqf global array [_attachCoords, _startPos, _modDir, _toolBox, _eTool, _medWait, _longWait, _inBuilding, _roadAllowed, _inTown];
_eTool 			= _requirements select 4;
_medWait 		= _requirements select 5;
_longWait 		= _requirements select 6;
_removable 		= _requirements select 10;
if (!_removable) then {cutText [format["%1 is not allowed to be removed!",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
switch (true) do
{
	case(_longWait):
	{
		if (_eTool) then {
			if (!_hasEtool) then {cutText [format["You need an entrenching tool to remove %1",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
		};
		if (!_hasToolbox) then {cutText [format["You need a tool box to remove %1",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
		if (_randNum > _highP) then {_tblProb = _tblProb + 40;_canRemove = true;} else {_tblProb = _tblProb + 40;_failRemove = true;_longWait = true; };
	};
	case(_medWait):
	{
		if (_eTool) then {
			if (!_hasToolbox) then {cutText [format["You need a tool box to remove %1",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
		};
		if (!_hasEtool) then {cutText [format["You need an entrenching tool to remove %1",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
		if (_randNum > _medP) then {_tblProb = _tblProb + 20;_canRemove = true;} else {_tblProb = _tblProb + 20; _failRemove = true; _medWait = true;};
	};
	case(!_medWait && !_longWait):
	{
		if (_eTool) then {
			if (!_hasToolbox) then {cutText [format["You need a tool box to remove %1",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
		};
		if (!_hasEtool) then {cutText [format["You need an entrenching tool to remove %1",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
		if (_randNum > _lowP) then {_canRemove = true;} else { _failRemove = true;};
	};
};


//BuiltItems = ["Land_CncBlock","Land_ladder_half","Land_prebehlavka","Misc_cargo_cont_small_EP1","Land_fort_rampart_EP1","Hhedgehog_concrete","Land_ladder_half","Land_A_Castle_Stairs_A","Ins_WarfareBContructionSite","Misc_Cargo1Bo_military","Land_Misc_Cargo2E","Barrack2","Land_rails_bridge_40","Land_HBarrier1","Land_BagFenceRound","Land_fortified_nest_small","Land_HBarrier_large","Base_WarfareBBarrier10x","bunkerMedium02","Base_WarfareBBarrier10xTall","Land_Fort_Watchtower","Land_fortified_net_big","Fence_Ind","Fort_RazorWire","Land_podlejzacka","Land_camoNet_Nato","Land_camoNetB_Nato","Land_camoNetVar_Nato"];

switch (true) do
{
	case(_longWait && _canRemove):
	{
		_cnt = _longWloop;
		_cnt = _cnt * 10;
		for "_i" from 0 to _longWloop do
		{
			cutText [format["Attempting to deconstruct %1  %2 seconds left.  \nMove from current position to cancel\n %3 percent chance to fail, %4 percent chance to lose toolbox",_text,_cnt + 10,_highP,_tblProb], "PLAIN DOWN",1];
			if (player distance _locationPlayer > 0.2) then {cutText [format["Removal canceled for %1, position of player moved",_text], "PLAIN DOWN",1]; remProc = false; breakOut "exit";};
			if (!_canDo || _onLadder || _inVehicle) then {cutText [format["Removal canceled for %1, player is unable to continue",_text], "PLAIN DOWN",1]; remProc = false; breakOut "exit";};
			player playActionNow "Medic";
			_dialog = findDisplay 106;
			sleep 1;
			[player,"repair",0,false] call dayz_zombieSpeak;
			_id = [player,50,true,(getPosATL player)] spawn player_alertZombies;
			sleep _wait;
			_hasToolbox = 	"ItemToolbox" in items player;
			if (!_hasToolbox) then {cutText [format["You need a tool box to remove %1",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
			if (!(isNull _dialog)) then {cutText [format["Removal canceled for %1, you opened your gear menu.",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
			_cnt = _cnt - 10;
		};
		_hasToolbox = 	"ItemToolbox" in items player;
		if (!_hasToolbox) then {cutText [format["You need a tool box to remove %1",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
		if (!isNull _obj && _randNum2 < _tblProb) then {player removeWeapon "ItemToolbox"; cutText ["Your toolbox was used up!", "PLAIN DOWN"];};
			sleep 1.5;
	};
	case(_medWait && _canRemove):
	{
		_cnt = _medWloop;
		_cnt = _cnt * 10;
		for "_i" from 0 to _medWloop do
		{
			cutText [format["Attempting to deconstruct %1  %2 seconds left.  \nMove from current position to cancel\n %3 percent chance to fail, %4 percent chance to lose toolbox",_text,_cnt + 10,_medP,_tblProb], "PLAIN DOWN",1];
			if (player distance _locationPlayer > 0.2) then {cutText [format["Removal canceled for %1, position of player moved",_text], "PLAIN DOWN",1]; remProc = false; breakOut "exit";};
			if (!_canDo || _onLadder || _inVehicle) then {cutText [format["Removal canceled for %1, player is unable to continue",_text], "PLAIN DOWN",1]; remProc = false; breakOut "exit";};
			player playActionNow "Medic";
			_dialog = findDisplay 106;
			sleep 1;
			[player,"repair",0,false] call dayz_zombieSpeak;
			_id = [player,50,true,(getPosATL player)] spawn player_alertZombies;
			sleep _wait;
			_hasToolbox = 	"ItemToolbox" in items player;
			if (!_hasToolbox) then {cutText [format["You need a tool box to remove %1",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
			if (!(isNull _dialog)) then {cutText [format["Removal canceled for %1, you opened your gear menu.",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
			_cnt = _cnt - 10;
	};
			_hasToolbox = 	"ItemToolbox" in items player;
			if (!_hasToolbox) then {cutText [format["You need a tool box to remove %1",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
			if (!isNull _obj && _randNum2 < _tblProb) then {player removeWeapon "ItemToolbox"; cutText ["Your toolbox was used up!", "PLAIN DOWN"];};
			sleep 1.5;
	};
	case((!_medWait && !_longWait) && _canRemove):
	{
		_cnt = _smallWloop;
		_cnt = _cnt * 10;
		for "_i" from 0 to _smallWloop do
		{
			cutText [format["Attempting to deconstruct %1  %2 seconds left.  \nMove from current position to cancel\n %3 percent chance to fail, %4 percent chance to lose toolbox",_text,_cnt + 10,_lowP,_tblProb], "PLAIN DOWN",1];
			if (player distance _locationPlayer > 0.2) then {cutText [format["Removal canceled for %1, position of player moved",_text], "PLAIN DOWN",1]; remProc = false; breakOut "exit";};
			if (!_canDo || _onLadder || _inVehicle) then {cutText [format["Removal canceled for %1, player is unable to continue",_text], "PLAIN DOWN",1]; remProc = false; breakOut "exit";};
			player playActionNow "Medic";
			_dialog = findDisplay 106;
			sleep 1;
			[player,"repair",0,false] call dayz_zombieSpeak;
			_id = [player,50,true,(getPosATL player)] spawn player_alertZombies;
			sleep _wait;
			_hasToolbox = 	"ItemToolbox" in items player;
			if (!_hasToolbox) then {cutText [format["You need a tool box to remove %1",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
			if (!(isNull _dialog)) then {cutText [format["Removal canceled for %1, you opened your gear menu.",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
			_cnt = _cnt - 10;
		};
			_hasToolbox = 	"ItemToolbox" in items player;
			if (!_hasToolbox) then {cutText [format["You need a tool box to remove %1",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
			if (!isNull _obj && _randNum2 < _tblProb) then {player removeWeapon "ItemToolbox"; cutText ["Your toolbox was used up!", "PLAIN DOWN"];};
			sleep 1.5;
	};
	case(_longWait && _failRemove):
	{
		_cnt = _longWloop;
		_cnt = _cnt * 10;
		for "_i" from 0 to _longWloop do
		{
			cutText [format["Attempting to deconstruct %1  %2 seconds left.  \nMove from current position to cancel\n %3 percent chance to fail, %4 percent chance to lose toolbox",_text,_cnt + 10,_highP,_tblProb], "PLAIN DOWN",1];
			if (player distance _locationPlayer > 0.2) then {cutText [format["Removal canceled for %1, position of player moved",_text], "PLAIN DOWN",1]; remProc = false; breakOut "exit";};
			if (!_canDo || _onLadder || _inVehicle) then {cutText [format["Removal canceled for %1, player is unable to continue",_text], "PLAIN DOWN",1]; remProc = false; breakOut "exit";};
			player playActionNow "Medic";
			_dialog = findDisplay 106;
			sleep 1;
			[player,"repair",0,false] call dayz_zombieSpeak;
			_id = [player,50,true,(getPosATL player)] spawn player_alertZombies;
			sleep _wait;
			_hasToolbox = 	"ItemToolbox" in items player;
			if (!_hasToolbox) then {cutText [format["You need a tool box to remove %1",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
			if (!(isNull _dialog)) then {cutText [format["Removal canceled for %1, you opened your gear menu.",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
			_cnt = _cnt - 10;
		};
			_hasToolbox = 	"ItemToolbox" in items player;
			if (!_hasToolbox) then {cutText [format["You need a tool box to remove %1",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
			if (!isNull _obj && _randNum2 < _tblProb) then {player removeWeapon "ItemToolbox"; cutText ["Your toolbox was used up!", "PLAIN DOWN"];};
			sleep 1.5;
			cutText [format["You failed to remove %1!",_text], "PLAIN DOWN",6]; remProc = false; breakOut "exit";
	};
	case(_medWait && _failRemove):
	{
		_cnt = _medWloop;
		_cnt = _cnt * 10;
		for "_i" from 0 to _medWloop do
		{
			cutText [format["Attempting to deconstruct %1  %2 seconds left.  \nMove from current position to cancel\n %3 percent chance to fail, %4 percent chance to lose toolbox",_text,_cnt + 10,_medP,_tblProb], "PLAIN DOWN",1];
			if (player distance _locationPlayer > 0.2) then {cutText [format["Removal canceled for %1, position of player moved",_text], "PLAIN DOWN",1]; remProc = false; breakOut "exit";};
			if (!_canDo || _onLadder || _inVehicle) then {cutText [format["Removal canceled for %1, player is unable to continue",_text], "PLAIN DOWN",1]; remProc = false; breakOut "exit";};
			player playActionNow "Medic";
			_dialog = findDisplay 106;
			sleep 1;
			[player,"repair",0,false] call dayz_zombieSpeak;
			_id = [player,50,true,(getPosATL player)] spawn player_alertZombies;
			sleep _wait;
			_hasToolbox = 	"ItemToolbox" in items player;
			if (!_hasToolbox) then {cutText [format["You need a tool box to remove %1",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
			if (!(isNull _dialog)) then {cutText [format["Removal canceled for %1, you opened your gear menu.",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
			_cnt = _cnt - 10;
		};
			_hasToolbox = 	"ItemToolbox" in items player;
			if (!_hasToolbox) then {cutText [format["You need a tool box to remove %1",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
			if (!isNull _obj && _randNum2 < _tblProb) then {player removeWeapon "ItemToolbox"; cutText ["Your toolbox was used up!", "PLAIN DOWN"];};
			sleep 1.5;
			cutText [format["You failed to remove %1!",_text], "PLAIN DOWN",6]; remProc = false; breakOut "exit";
	};
	case((!_medWait && !_longWait) && _failRemove):
	{
		_cnt = _smallWloop;
		_cnt = _cnt * 10;
		for "_i" from 0 to _smallWloop do
		{
			cutText [format["Attempting to deconstruct %1  %2 seconds left.  \nMove from current position to cancel\n %3 percent chance to fail, %4 percent chance to lose toolbox",_text,_cnt + 10,_lowP,_tblProb], "PLAIN DOWN",1];
			if (player distance _locationPlayer > 0.2) then {cutText [format["Removal canceled for %1, position of player moved",_text], "PLAIN DOWN",1]; remProc = false; breakOut "exit";};
			if (!_canDo || _onLadder || _inVehicle) then {cutText [format["Removal canceled for %1, player is unable to continue",_text], "PLAIN DOWN",1]; remProc = false; breakOut "exit";};
			player playActionNow "Medic";
			_dialog = findDisplay 106;
			sleep 1;
			[player,"repair",0,false] call dayz_zombieSpeak;
			_id = [player,50,true,(getPosATL player)] spawn player_alertZombies;
			sleep _wait;
			_hasToolbox = 	"ItemToolbox" in items player;
			if (!_hasToolbox) then {cutText [format["You need a tool box to remove %1",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
			if (!(isNull _dialog)) then {cutText [format["Removal canceled for %1, you opened your gear menu.",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
			_cnt = _cnt - 10;
		};
			_hasToolbox = 	"ItemToolbox" in items player;
			if (!_hasToolbox) then {cutText [format["You need a tool box to remove %1",_text], "PLAIN DOWN",1];remProc = false; breakOut "exit"; };
			if (!isNull _obj && _randNum2 < _tblProb) then {player removeWeapon "ItemToolbox"; cutText ["Your toolbox was used up!", "PLAIN DOWN"];};
			sleep 1.5;
			cutText [format["You failed to remove %1!",_text], "PLAIN DOWN",6]; remProc = false; breakOut "exit";
	};

};

//Player removes object successfully
if (!isNull _obj) then {
cutText [format["You removed a %1 successfully!",_text], "PLAIN DOWN"];
//	dayzDeleteObj = [_dir, _pos, _objectID, _objectUID];
	dayzDeleteObj = [_objectID,_objectUID];
publicVariableServer "dayzDeleteObj";
if (isServer) then {
	dayzDeleteObj call local_deleteObj;
};
sleep .1;
deleteVehicle _obj;
};
remProc = false;