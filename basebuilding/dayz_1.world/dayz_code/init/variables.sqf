//Daimyo Base Building 1.2 Variables
/*
These variables are defined to work globally to ONLY CLIENT scripts and not to the server or other players
They help to communicate to other Client scripts etc.
Example: remProc for example stands for remove process. Meaning if your in the process of removing an object
remProc will == true; This way if you try to begin removing it again, remProc will already be true and exit out
with "Your already trying to remove this";
Not all variables are boolean true or false but hopefully you get the idea
*/
	//Strings
	globalSkin 			= "";
	//Arrays
	allbuildables_class = [];
	allbuildables 		= [];
	allbuild_notowns 	= [];
	allremovables 		= [];
	wallarray 			= [];
	structures			= [];
	CODEINPUT 			= [];
	keyCode 			= [];
	//Booleans
	remProc 			= false;
	hasBuildItem 		= false;
	rem_procPart 		= false;
	repProc 			= false;
	keyValid 			= false;
	procBuild 			= false;
	currentBuildRecipe 	= 0;
	removeObject		= false;
