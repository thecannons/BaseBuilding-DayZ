//addaction sends [target, caller, ID, (arguments)]
private ["_displayok","_lever"];
//_id = _this select 2;
//_lever removeAction _id;
_lever = cursortarget;
//_dir = direction _lever;
//_pos = getPosATL _lever;
	//_uid 	= [_dir,_pos] call dayz_objectUID2;
keyCode = _lever getVariable ["ObjectUID","0"];
_displayok = createdialog "KeypadGate";
