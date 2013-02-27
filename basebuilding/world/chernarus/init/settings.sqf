// This file is for server specific settings. Refer to the documentation at
// development.dayztaviana.com site for further details.

diag_log "Started executing user settings file.";						// Log start

if (!isDedicated) then {
	//--- BASE BUILDING 1.2 ADD IN ClientSide ---
	_null = [] execVM "dy_work\player_bomb.sqf";		// Booby trap bombs (now should only detect buildable grave, not all graves)
	_null = [] execVM "dy_work\initWall.sqf";		// Doesnt allow players to get out of vehicle through specified walls in build_list.sqf
	_null = [] execVM "dy_work\build_list.sqf";		// build_list for building buildable arrays and parameters on init.
};

diag_log "Finished executing user settings file.";						// Log finish