private["_inVehicle","_noDriver","_wallTypes","_cnt","_wall","_isVehicle"];
_inVehicle = (vehicle player != player);
_isVehicle = (vehicle player);
//_isDriver = driver (vehicle player);

_wallTypes = nearestObjects [player, ["Fence_Ind","Fort_RazorWire","Fence_Ind_long","Fence_corrugated_plate","Land_fort_rampart_EP1","Land_Fort_Watchtower","Concrete_Wall_EP1","Base_WarfareBBarrier10xTall","Land_HBarrier_large","Land_Misc_Cargo2E","Misc_Cargo1Bo_military","Ins_WarfareBContructionSite","Misc_cargo_cont_small_EP1"], 16];
if (count _wallTypes > 0) then {
		_wall = [_wallTypes, player] call BIS_fnc_nearestPosition;
		_noDriver = (vehicle player) emptyPositions "driver";
		if ((vehicle player) distance _wall < 10) then {
			if (_noDriver == 1 && (speed (vehicle player) > 0 || speed (vehicle player) < 0)) then {
				//createGearDialog [player, "RscDisplayGear"];
				player allowdamage false;
				titletext format ["Ejected to prevent disconnect exploit", "PLAIN DOWN"];
				titleFadeOut 2;
				player action ["eject", _isVehicle];
				sleep 1;
				player allowdamage true;
			};
		};
	};
