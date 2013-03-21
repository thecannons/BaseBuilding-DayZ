private["_vehiclePlayer","_inVehicle","_hasBlown","_timeLeft","_dogsFly","_bombList","_bomb","_timer","_cnt","_arrayTotal","_dir","_pos","_objectID","_objectUID","_detonate"];
_cnt = 0;
_timeLeft = 3;
_dogsFly = true;
while {_dogsFly} do {
_hasBlown = false;
_inVehicle = (vehicle player != player);
_vehiclePlayer = (vehicle player);
if (_inVehicle) then {
_bombList = nearestObjects [_vehiclePlayer, ["Grave"],18];
} else {_bombList = nearestObjects [player, ["Grave"],18];};
_bomb = _bombList select _cnt;
if ((!procBuild && (typeOf(_bomb) == "Grave")) && !((typeOf(_bomb) == "Body") || (typeOf(_bomb) ==  "GraveCross1") || (typeOf(_bomb) ==  "GraveCross2") || (typeOf(_bomb) ==  "GraveCrossHelmet") || (typeOf(_bomb) ==  "Land_Church_tomb_1") || (typeOf(_bomb) ==  "Land_Church_tomb_2") || (typeOf(_bomb) ==  "Land_Church_tomb_3") || (typeOf(_bomb) ==  "Mass_grave"))) then {
_dir = direction _bomb;
_pos = [(getposATL _bomb select 0),(getposATL _bomb select 1), (getposATL _bomb select 2) + 0.5];
_objectID = _bomb getVariable["ObjectID","0"];
_objectUID = _bomb getVariable["ObjectUID","0"];
//hint format ["%1",speed _vehiclePlayer];
if (!isNull _bomb && ((player distance _bomb < 12 && (speed player > 4 || speed player < -3)) || (_vehiclePlayer distance _bomb < 12 && (_inVehicle && speed _vehiclePlayer > 0 || _inVehicle && speed _vehiclePlayer < -0)))) then {
[nil,_bomb,rSAY,["trap_bear_0",60]] call RE;
sleep .8;
if ((player distance _bomb < 5 && (speed player > 4 || speed player < -3)) || (_vehiclePlayer distance _bomb < 5 && (_inVehicle && speed _vehiclePlayer > 0 || _inVehicle && speed _vehiclePlayer < -0))) then {
//[_bomb,"trap_bear_0",0,false] call dayz_zombieSpeak;
_detonate = "grenade" createVehicle _pos;
_hasBlown = true;
};
if (!isNull _bomb && !_hasBlown) then {
sleep .8;
//[_bomb,"trap_bear_0",0,false] call dayz_zombieSpeak;
_detonate = "grenade" createVehicle _pos;

};

dayzDeleteObj = [_objectID,_objectUID];
publicVariableServer "dayzDeleteObj";
if (isServer) then {
	dayzDeleteObj call local_deleteObj;
};
sleep .1;
if (!isNull _bomb) then {
deleteVehicle _bomb;
};
_bombList = _bombList - [_bomb];
} else {_bombList = _bombList - [_bomb];};
};
_cnt = _cnt + 1;
_arrayTotal = count _bombList;
if (_cnt > _arrayTotal) then {_cnt = 0;};
sleep .1;
};