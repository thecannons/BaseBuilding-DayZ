private["_inVehicle","_isVehicle"];
while {true} do {
_inVehicle = (vehicle player != player);
_isVehicle = (vehicle player);
if (_inVehicle) then {
	player call anti_discWall;
	};
sleep .3;
};
