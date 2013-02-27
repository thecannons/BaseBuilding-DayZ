private["_pos","_isBuildable"];
_pos = _this select 0;
_isBuildable = _this select 1;
{
	[_x, "gear"] call server_updateObject;
} forEach nearestObjects [_pos, ["Car", "Helicopter", "Motorcycle", "Ship", "TentStorage"], 10];

// Base Building 1.2 (update base) This is if you want players bases to update whenever they use a gate panel or anything u specify when calling this script
// So far this is only tied into "operate gate actions"

if (_isBuildable) then {
{
	[_x, "gear"] call server_updateObject;
} forEach nearestObjects [_pos, allbuildables_class, 500];
};