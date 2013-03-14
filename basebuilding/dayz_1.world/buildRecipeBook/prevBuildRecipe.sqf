if (currentBuildRecipe>0) then {

    currentBuildRecipe = currentBuildRecipe - 1;
} else {
    currentBuildRecipe =(count allBuildables)-1;
};
[] call refresh_build_recipe_dialog;