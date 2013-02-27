private ["_id","_pos","_z","_nearestGates","_inMotion","_lever","_text"];

_id = _this select 2;
_lever = _this select 3;
_inMotion = _lever getVariable ["inMotion",0];
_lever removeAction _id;
_nearestGates = nearestObjects [_lever, ["Hhedgehog_concrete","Concrete_Wall_EP1"], 35];

if (_inMotion == 0) then {

	_lever setVariable ["inMotion", 1, true];
	
	{
		_pos = getPos _x;
		_z = _pos select 2;
		
		if (_z <= -2) then {
		
			_text = getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName");
			cutText [format["Raising the %1",_text], "PLAIN DOWN"];
			_pos set [2,0];
			_x setPos _pos;
			
		} else {
		
			_text = getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName");
			cutText [format["Lowering the %1",_text], "PLAIN DOWN"];
			_pos set [2,-3.6];
			_x setPos _pos;
			
		};
		
		sleep 1;
		
	} foreach _nearestGates;
	
	_lever setVariable ["inMotion", 0, true];
};

{dayz_myCursorTarget removeAction _x} forEach s_player_gateActions;s_player_gateActions = [];
dayz_myCursorTarget = objNull;