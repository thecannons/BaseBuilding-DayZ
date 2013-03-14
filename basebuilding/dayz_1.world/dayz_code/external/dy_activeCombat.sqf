//ActiveCombat 1.1 by Daimyo (modified by Knobbin)

private["_dialog","_zombieNear","_dangerClosest","_cnt","_isInCombat","_playerCombat","_inVehicle"];
disableSerialization;
_cnt = 0;

while {true} do {
	_playerCombat = player;
	_isInCombat = _playerCombat getVariable["startcombattimer",0];
	_inVehicle = (vehicle player != player);
	_zombieNear = (getPosATL player) nearEntities [["zZombie_Base","CAManBase"],15];
	_dialog = findDisplay 106;
	
if ((_inVehicle || speed player != 0) && alive player) then {
	if ((isPlayer _playerCombat) && _isInCombat == 0 && !procBuild) then {
		_playerCombat setVariable["startcombattimer", 1, true];
		//diag_log("Now in Combat (Player): " + name _playerCombat);
	};
};

if ( !(isNull _dialog) ) then {
_playerCombat setVariable["startcombattimer", 1, true];
}; 
if (player in _zombieNear) then {
_zombieNear = _zombieNear - [player];
};
// Any zombies within 15 meters?
if (count _zombieNear > 0) then {
	{
	_dangerClosest = _zombieNear select _cnt;
	if (_dangerClosest distance player < 15 && _isInCombat == 0) then {_playerCombat setVariable["startcombattimer", 1, true];};
	_cnt = _cnt + 1;
	if (_cnt >= (count _zombieNear)) then {_cnt = 0};
	sleep 0.01;
	} foreach _zombieNear;
};
sleep 1;
};