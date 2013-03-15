/*
Anti Wall by Daimyo
This script prevents players from exiting vehicles into a wall and glitching
through the wall in order to get into a player made base.
*/

private["_wallRange","_wallType","_inVehicle","_walltypes","_wall","_vehPos","_nearestVeh","_nearestVehs","_isVehicle"];
if (animationstate player == "acrgpknlmstpsnonwnondnon_amovpercmstpsnonwnondnon_getoutlow" || animationstate player == "acrgpknlmstpsnonwnondnon_amovpercmstpsraswrfldnon_getoutlow" || animationstate player == "acrgpknlmstpsnonwnondnon_amovpercmstpsraswpstdnon_getoutlow") then {
_inVehicle = (vehicle player != player);
_isVehicle = (vehicle player);
_wallRange = 10;
//_nearBool = true;
		//Check objects from global wallarray via build_list.sqf
		_walltypes = nearestObjects [player, wallarray, 20];
		if (count _walltypes > 0) then {
				_wall = _walltypes select 0;//[_walltypes, player] call BIS_fnc_nearestPosition;
				if (_wall in structures) then {_wallRange = 18};
				if (player distance _wall < _wallRange) then {
						_nearestVehs = nearestObjects [player, ["LandVehicle"], 10];
						sleep .01;
						_nearestVeh = _nearestVehs select 0;//[_nearestVehs, player] call BIS_fnc_nearestPosition;
						sleep .01;
						_vehPos = getPosATL _nearestVeh;
						sleep .01;
						player allowdamage false;
						player setpos _vehPos;
						//player action ["eject", _isVehicle];//player moveInDriver (vehicle player);
						sleep 2;
						player allowdamage true;
						};			
		};
	};