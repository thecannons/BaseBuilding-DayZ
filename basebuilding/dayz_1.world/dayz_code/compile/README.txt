###SECTION 1
player_build - with ActiveCombat 1.1 compatibility:
This version assume player is already in combat and places him out
after 3 seconds. Than builder script begins
The player can then be placed back into combat there after during building mode

player_build normal
This version does not check if player is already in combat, but will cancel build if player 
is set into combat

###SECTION 2
fn_selfActions.sqf This handles all DayZ actions, ie removal actions, cooking actions, etc.

Added Code is marked with Base Building 1.2 titles along with // ### START ### and // ### END ### to mark code blocks added in

###SECTION 3
This line is very important:
Anything above it means that players crosshair is not targeting anything

if (!isNull cursorTarget and !_inVehicle and (player distance cursorTarget < 4)) then {

Anything Below it means that players crosshair has a target of some sort (within 4 meters)

###SECTION 4:
Youll notice this in the fn_selfActions.sqf  This is the default DayZ removal.  Remove this block of code in your fn_selfActions.sqf
Make sure your not removing the custom Base Building 1.2 one added in by yourself as they use the same action variable s_player_deleteBuild
// THIS NEEDS TO BE REMOVED \/ \/ \/ For BASE BUILDING REMOVAL TO WORK
	//Allow player to delete objects
/*	if(_isDestructable and _hasToolbox and _canDo) then {
		if (s_player_deleteBuild < 0) then {
			s_player_deleteBuild = player addAction [format[localize "str_actions_delete",_text], "\z\addons\dayz_code\actions\remove.sqf",cursorTarget, 1, true, true, "", ""];
		};
	} else {
		player removeAction s_player_deleteBuild;
		s_player_deleteBuild = -1;
	};
*/	
// THIS NEEDS TO BE REMOVED /\ /\ /\ For BASE BUILDING REMOVAL TO WORK



###SECTION 5:

At the very bottom of fn_selfActions.sqf add these in as shown in example fn_selfActions.sqf


// ### BASE BUILDING 1.2 ### Add in these: 
// ### START ###
	player removeAction s_player_disarmBomb;
	s_player_disarmBomb = -1;
	player removeAction s_player_enterCode;
	s_player_enterCode = -1;
	player removeAction s_player_smeltRecipes;
	s_player_smeltRecipes = -1;
	player removeAction s_player_smeltItems;
	s_player_smeltItems = -1;
// ### BASE BUILDING 1.2 ### Add in these:
// ### END ###
