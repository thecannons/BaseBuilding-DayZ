/*
[_object,_type] spawn server_updateObject;
*/
private ["_rand","_parachuteC","_parachuteWest","_object","_type","_objectID","_uid","_lastUpdate","_needUpdate","_object_position","_object_inventory","_object_damage","_isNotOk"];

_object = 	_this select 0;
_type = 	_this select 1;
_parachuteWest = typeOf _object == "ParachuteWest";
_parachuteC 	= typeOf _object == "ParachuteC";
_isNotOk = false;

_objectID =	_object getVariable ["ObjectID","0"];
_uid = 		_object getVariable ["ObjectUID","0"];

if ((typeName _objectID != "string") || (typeName _uid != "string")) then
{ 
    diag_log(format["Non-string Object: ID %1 UID %2", _objectID, _uid]);
    //force fail
    _objectID = "0";
    _uid = "0";
};
if (!_parachuteWest || !_parachuteC) then {
	if (_objectID == "0" && _uid == "0") then
	{
		_object_position = getPosATL _object;
    		diag_log(format["Deleting object %1 with invalid ID at pos [%2,%3,%4]",
			typeOf _object,
			_object_position select 0,
			_object_position select 1, 
			_object_position select 2]);
			_isNotOk = true;
	};
};

if (_isNotOk) exitWith { deleteVehicle _object; };

_lastUpdate = _object getVariable ["lastUpdate",time];
_needUpdate = _object in needUpdate_objects;

_object_position = {
	private["_position","_worldspace","_fuel","_key"];
	_position = getPosATL _object;
	_worldspace = [
		round(direction _object),
		_position
	];
	_fuel = 0;
	if (_object isKindOf "AllVehicles") then {
		_fuel = fuel _object;
	};
	_key = format["CHILD:305:%1:%2:%3:",_objectID,_worldspace,_fuel];
	diag_log ("HIVE: WRITE: "+ str(_key));
	_key call server_hiveWrite;
};

_object_inventory = {
// ### BASE BUILDING 1.2 ### START 
//This forces object to write to database changing the inventory of the object twice 
// so it updates the object from operate_gates.sqf 

	private["_inventory","_previous","_key"];
	// This writes to database if object is buildable
	if (typeOf(_object) in allbuildables_class) then {
	//First lets make inventory [[[],[]],[[],[]],[[],[]]] so it updates object in DB
			_inventory = [[[],[]],[[],[]],[[],[]]];
		if (_objectID == "0") then {
			_key = format["CHILD:309:%1:%2:",_uid,_inventory];
		} else {
			_key = format["CHILD:303:%1:%2:",_objectID,_inventory];
		};
		diag_log ("HIVE: Buildable: "+ str(_key));
		_key call server_hiveWrite;
	//Since we cant actually read from DB, lets make inventory this [], than write it again, to insure its updated to DB
			_inventory = [];
		if (_objectID == "0") then {
			_key = format["CHILD:309:%1:%2:",_uid,_inventory];
		} else {
			_key = format["CHILD:303:%1:%2:",_objectID,_inventory];
		};
		diag_log ("HIVE: Buildable: "+ str(_key));
		_key call server_hiveWrite;
// DO DEFAULT server_updateObject if not a buildable
	} else {
			_inventory = [
			getWeaponCargo _object,
			getMagazineCargo _object,
			getBackpackCargo _object
		];
	

		_previous = str(_object getVariable["lastInventory",[]]);
		if (str(_inventory) != _previous) then {
			_object setVariable["lastInventory",_inventory];
			if (_objectID == "0") then {
				_key = format["CHILD:309:%1:%2:",_uid,_inventory];
			} else {
				_key = format["CHILD:303:%1:%2:",_objectID,_inventory];
			};
			diag_log ("HIVE: WRITE: "+ str(_key));
			_key call server_hiveWrite;
		};
	};
};
// ### BASE BUILDING 1.2 ### END

_object_damage = {
	private["_hitpoints","_array","_hit","_selection","_key","_damage"];
	_hitpoints = _object call vehicle_getHitpoints;
	_damage = damage _object;
	_array = [];
	{
		_hit = [_object,_x] call object_getHit;
		_selection = getText (configFile >> "CfgVehicles" >> (typeOf _object) >> "HitPoints" >> _x >> "name");
		if (_hit > 0) then {_array set [count _array,[_selection,_hit]]};
	} forEach _hitpoints;
	_key = format["CHILD:306:%1:%2:%3:",_objectID,_array,_damage];
	diag_log ("HIVE: WRITE: "+ str(_key));
	_key call server_hiveWrite;
	_object setVariable ["needUpdate",false,true];
};

_object setVariable ["lastUpdate",time,true];
switch (_type) do {
	case "all": {
		call _object_position;
		call _object_inventory;
		call _object_damage;
	};
	case "position": {
		call _object_position;
	};
	case "gear": {
		call _object_inventory;
	};
	case "damage": {
		if ( (time - _lastUpdate) > 5 && !_needUpdate ) then {
			call _object_damage;
		} else {
			if ( !_needUpdate ) then {
				needUpdate_objects set [count needUpdate_objects, _object];
			};
		};
	};
	case "repair": {
		call _object_damage;
	};
};