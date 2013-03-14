/* Modified server_updateNearbyObjects.sqf by Daimyo for
Base Building 1.2
This simply updates all buildables from the allbuildables_class
around 300 meters when operate_gates.sqf is used
*/

private["_pos","_isBuildable"];
_pos = _this select 0;
_isBuildable = _this select 1;
{
	[_x, "gear"] call server_updateObject;
} forEach nearestObjects [_pos, ["Car", "Helicopter", "Motorcycle", "Ship", "TentStorage"], 10];

if (_isBuildable) then {
	diag_log("_isBuildable was called!");
{
	[_x, "gear"] call server_updateObject;
	diag_log("BUILDABLES: updating " + _x + " object!");
} forEach nearestObjects [_pos, [allbuildables_class], 300];

};