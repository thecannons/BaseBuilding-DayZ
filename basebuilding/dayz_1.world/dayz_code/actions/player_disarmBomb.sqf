private["_disarmChance","_kaBoom","_detonate","_objectID","_objectUID","_bomb","_cnt","_classname","_id","_tblProb","_locationPlayer","_randNum2","_smallWloop","_medWloop","_longWloop","_text","_wait","_longWait","_medWait","_smallWait","_highP","_medP","_lowP","_failRemove","_canRemove","_randNum","_classname","_dir","_pos","_text","_isWater","_inVehicle","_onLadder","_hasToolbox","_canDo","_hasEtool"];
_bomb = cursorTarget;
_dir = direction _bomb;
_pos = getposATL _bomb;
_longWloop = 6;
_kaBoom = false;
if (!isNull _bomb) then {
_objectID = _bomb getVariable["ObjectID",0];
_objectUID = _bomb getVariable["ObjectUID","0"];
};
_locationPlayer = player modeltoworld [0,0,0];
_onLadder =		(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
_isWater = 		(surfaceIsWater _locationPlayer) or dayz_isSwimming;
_inVehicle = (vehicle player != player);
_building = nearestObject [player, "Building"];
_onLadder =		(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
_hasToolbox = 	"ItemToolbox" in items player;
_canDo = (!r_drag_sqf and !r_player_unconscious and !_onLadder); //USE!!
_hasEtool = 	"ItemEtool" in weapons player;
_canRemove = false;
_failRemove = false;
_longWait = false;
_medWait = false;
_smallWait = false;
_longWloop = 6;
_medWloop = 4;
_smallWloop = 3;
_tblProb = 30;
_disarmChance = 50;
_cnt = 0;
_text = "";
_wait = 10;
if(_isWater) then {cutText [localize "str_player_26", "PLAIN DOWN"];breakOut "exit";};
if(_onLadder) then {cutText [localize "str_player_21", "PLAIN DOWN"];breakOut "exit";};
if (_inVehicle) then {cutText [localize "Can't do this in vehicle", "PLAIN DOWN"];breakOut "exit";};
remProc = false;
_randNum = round(random 100);
_randNum2 = round(random 100);

_classname = _bomb;
if (_classname isKindof "Grave") then {
_classname = "Grave";
};
switch (_classname) do
{
	case "Grave":
	{
		_text = "Booby Trap";
		if (_hasToolbox) then {_disarmChance = _disarmChance + 30;};
		if (_hasEtool) then {_disarmChance = _disarmChance + 10;};
		if (_hasToolbox && _hasEtool) then {_smallWait = true;};
		if (_hasToolbox && !_hasEtool) then {_medWait = true;};
		if (!_hasToolbox && _hasEtool) then {_medWait = true;};
		if (!_hasToolbox && !_hasEtool) then {_longWait = true;};
		if (_randNum < _disarmChance) then {_canRemove = true;} else {_failRemove = true;};
	};
		default {
		cutText ["You didnt select a bomb!", "PLAIN DOWN"];
		remProc = true; breakOut "exit";
	};
};
cutText [format["You need an entrenching tool to remove %1",_classname], "PLAIN DOWN",1];


if (_longWait && _canRemove) then {
	_cnt = _longWloop;
	_cnt = _cnt * 10 + 10;
	for "_i" from 0 to _longWloop do
	{
		cutText [format["Attempting to disarm %1  %2 seconds left.  Move from current position to cancel",_text,_cnt], "PLAIN DOWN",1];
		if (player distance _locationPlayer > 0.2) then {cutText [format["Removal canceled for %1, position of player moved",_text], "PLAIN DOWN",1]; remProc = true; breakOut "exit";};
		if (!_canDo || _onLadder || _inVehicle) then {cutText [format["Removal canceled for %1, player is unable to continue",_text], "PLAIN DOWN",1]; remProc = true; breakOut "exit";};
		player playActionNow "Medic";
		sleep 1;
		[player,"repair",0,false] call dayz_zombieSpeak;
		_id = [player,50,true,(getPosATL player)] spawn player_alertZombies;
		sleep _wait;
		_cnt = _cnt - 10;
	};
	if (!isNull _bomb && _randNum2 < _tblProb) then {player removeWeapon "ItemToolbox"; cutText ["Your toolbox was used up!", "PLAIN DOWN"];};
		sleep 1.5;
} else {
if (_medWait && _canRemove) then {
	_cnt = _medWloop;
	_cnt = _cnt * 10 + 10;
	for "_i" from 0 to _medWloop do
	{
		cutText [format["Attempting to disarm %1  %2 seconds left.  Move from current position to cancel",_text,_cnt], "PLAIN DOWN",1];
		if (player distance _locationPlayer > 0.2) then {cutText [format["Removal canceled for %1, position of player moved",_text], "PLAIN DOWN",1]; remProc = true; breakOut "exit";};
		if (!_canDo || _onLadder || _inVehicle) then {cutText [format["Removal canceled for %1, player is unable to continue",_text], "PLAIN DOWN",1]; remProc = true; breakOut "exit";};
		player playActionNow "Medic";
		sleep 1;
		[player,"repair",0,false] call dayz_zombieSpeak;
		_id = [player,50,true,(getPosATL player)] spawn player_alertZombies;
		sleep _wait;
		_cnt = _cnt - 10;
	};
		if (!isNull _bomb && _randNum2 < _tblProb) then {player removeWeapon "ItemToolbox"; cutText ["Your toolbox was used up!", "PLAIN DOWN"];};
		sleep 1.5;
} else {
if (_smallWait && _canRemove) then {
	_cnt = _smallWloop;
	_cnt = _cnt * 10 + 10;
	for "_i" from 0 to _smallWloop do
	{
		cutText [format["Attempting to disarm %1  %2 seconds left.  Move from current position to cancel",_text,_cnt], "PLAIN DOWN",1];
		if (player distance _locationPlayer > 0.2) then {cutText [format["Removal canceled for %1, position of player moved",_text], "PLAIN DOWN",1]; remProc = true; breakOut "exit";};
		if (!_canDo || _onLadder || _inVehicle) then {cutText [format["Removal canceled for %1, player is unable to continue",_text], "PLAIN DOWN",1]; remProc = true; breakOut "exit";};
		player playActionNow "Medic";
		sleep 1;
		[player,"repair",0,false] call dayz_zombieSpeak;
		_id = [player,50,true,(getPosATL player)] spawn player_alertZombies;
		sleep _wait;
		_cnt = _cnt - 10;
	};
		if (!isNull _bomb && _randNum2 < _tblProb) then {player removeWeapon "ItemToolbox"; cutText ["Your toolbox was used up!", "PLAIN DOWN"];};
		sleep 1.5;
};
};
};

if (_longWait && _failRemove) then {
	_cnt = _longWloop;
	_cnt = _cnt * 10 + 10;
	for "_i" from 0 to _longWloop do
	{
		cutText [format["Attempting to disarm %1  %2 seconds left.  Move from current position to cancel",_text,_cnt], "PLAIN DOWN",1];
		if (player distance _locationPlayer > 0.2) then {cutText [format["Removal canceled for %1, position of player moved",_text], "PLAIN DOWN",1]; remProc = true; breakOut "exit";};
		if (!_canDo || _onLadder || _inVehicle) then {cutText [format["Removal canceled for %1, player is unable to continue",_text], "PLAIN DOWN",1]; remProc = true; breakOut "exit";};
		player playActionNow "Medic";
		sleep 1;
		[player,"repair",0,false] call dayz_zombieSpeak;
		_id = [player,50,true,(getPosATL player)] spawn player_alertZombies;
		sleep _wait;
		_cnt = _cnt - 10;
	};
		if (!isNull _bomb && _randNum2 < _tblProb) then {player removeWeapon "ItemToolbox"; cutText ["Your toolbox was used up!", "PLAIN DOWN"];};
		sleep 1.5;
		cutText [format["You failed to disarm %1!",_text], "PLAIN DOWN",6]; remProc = true; _kaBoom = true;
} else {
if (_medWait && _failRemove) then {
	_cnt = _medWloop;
	_cnt = _cnt * 10 + 10;
	for "_i" from 0 to _medWloop do
	{
		cutText [format["Attempting to disarm %1  %2 seconds left.  Move from current position to cancel",_text,_cnt], "PLAIN DOWN",1];
		if (player distance _locationPlayer > 0.2) then {cutText [format["Removal canceled for %1, position of player moved",_text], "PLAIN DOWN",1]; remProc = true; breakOut "exit";};
		if (!_canDo || _onLadder || _inVehicle) then {cutText [format["Removal canceled for %1, player is unable to continue",_text], "PLAIN DOWN",1]; remProc = true; breakOut "exit";};
		player playActionNow "Medic";
		sleep 1;
		[player,"repair",0,false] call dayz_zombieSpeak;
		_id = [player,50,true,(getPosATL player)] spawn player_alertZombies;
		sleep _wait;
		_cnt = _cnt - 10;
	};
		if (!isNull _bomb && _randNum2 < _tblProb) then {player removeWeapon "ItemToolbox"; cutText ["Your toolbox was used up!", "PLAIN DOWN"];};
		sleep 1.5;
		cutText [format["You failed to disarm %1!",_text], "PLAIN DOWN",6]; remProc = true; _kaBoom = true;
} else {
if (_smallWait && _failRemove) then {
	_cnt = _smallWloop;
	_cnt = _cnt * 10 + 10;
	for "_i" from 0 to _smallWloop do
	{
		cutText [format["Attempting to disarm %1  %2 seconds left.  Move from current position to cancel",_text,_cnt], "PLAIN DOWN",1];
		if (player distance _locationPlayer > 0.2) then {cutText [format["Removal canceled for %1, position of player moved",_text], "PLAIN DOWN",1]; remProc = true; breakOut "exit";};
		if (!_canDo || _onLadder || _inVehicle) then {cutText [format["Removal canceled for %1, player is unable to continue",_text], "PLAIN DOWN",1]; remProc = true; breakOut "exit";};
		player playActionNow "Medic";
		sleep 1;
		[player,"repair",0,false] call dayz_zombieSpeak;
		_id = [player,50,true,(getPosATL player)] spawn player_alertZombies;
		sleep _wait;
		_cnt = _cnt - 10;
	};
		if (!isNull _bomb && _randNum2 < _tblProb) then {player removeWeapon "ItemToolbox"; cutText ["Your toolbox was used up!", "PLAIN DOWN"];};
		sleep 1.5;
		cutText [format["You failed to disarm %1!",_text], "PLAIN DOWN",6]; remProc = true; _kaBoom = true;
};
};
};

if (!isNull _bomb && _kaBoom) then {
[nil,_bomb,rSAY,["trap_bear_0",60]] call RE;
sleep 1;
dayzDeleteObj = [_dir, _pos, _objectID, _objectUID];
publicVariable "dayzDeleteObj";
if (isServer) then {
	dayzDeleteObj call local_deleteObj;
};
_detonate = "grenade" createVehicle _pos;
sleep .1;
deleteVehicle _bomb;
breakOut "exit";
};
//Player removes object successfully
cutText [format["You disarmed the %1 successfully!",_text], "PLAIN DOWN"];
	dayzDeleteObj = [_dir, _pos, _objectID, _objectUID];
publicVariable "dayzDeleteObj";
if (isServer) then {
	dayzDeleteObj call local_deleteObj;
};
sleep .1;
if (!isNull _bomb) then {
deleteVehicle _bomb;
};
remProc = true;