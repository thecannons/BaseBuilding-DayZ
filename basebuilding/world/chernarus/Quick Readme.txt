This is a default mission layout
init.sqf initializes the init folder files with these 3 lines:

call compile preprocessFileLineNumbers "init\variables.sqf"; //Initializes custom variables
call compile preprocessFileLineNumbers "init\compiles.sqf"; //Compile custom compiles
call compile preprocessFileLineNumbers "init\settings.sqf"; //Initialize custom clientside settings

You may change folder directories around, HOWEVER, you will need to change the paths

example:
"actions\player_remove.sqf" is changed to "tweaks\actions\player_remove.sqf"

In fn_selfactions.sqf, you must change:

s_player_deleteBuild = player addAction [format[localize "str_actions_delete",_text], "actions\player_remove.sqf",cursorTarget, 1, true, true, "", ""];
to
s_player_deleteBuild = player addAction [format[localize "str_actions_delete",_text], "tweaks\actions\player_remove.sqf",cursorTarget, 1, true, true, "", ""];


This is one example.  If you dont know what the hell your doing, then best just leave things default and follow
guide included