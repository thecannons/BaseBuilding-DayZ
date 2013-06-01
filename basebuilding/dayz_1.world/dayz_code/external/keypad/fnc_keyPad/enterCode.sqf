//addaction sends [target, caller, ID, (arguments)]
private ["_displayok","_lever"];
//_id = _this select 2;
//_lever removeAction _id;
_lever = cursortarget;


//Determine camoNet since camoNets cannot be targeted with Crosshair
switch (true) do
{
	case(camoNetB_East distance player < 10 && isNull _lever):
	{
		_lever = camoNetB_East;
	};
	case(camoNetVar_East distance player < 10 && isNull _lever):
	{
		_lever = camoNetVar_East;
	};
	case(camoNet_East distance player < 10 && isNull _lever):
	{
		_lever = camoNet_East;
	};
	case(camoNetB_Nato distance player < 10 && isNull _lever):
	{
		_lever = camoNetB_Nato;
	};
	case(camoNetVar_Nato distance player < 10 && isNull _lever):
	{
		_lever = camoNetVar_Nato;
	};
	case(camoNet_Nato distance player < 10 && isNull _lever):
	{
		_lever = camoNet_Nato;
	};
};
//_dir = direction _lever;
//_pos = getPosATL _lever;
	//_uid 	= [_dir,_pos] call dayz_objectUID2;
keyCode = _lever getVariable ["ObjectUID","0"];
_displayok = createdialog "KeypadGate";
