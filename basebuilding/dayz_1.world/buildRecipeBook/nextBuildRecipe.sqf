if (currentBuildRecipe<(count allBuildables)-1) then {
    currentBuildRecipe = currentBuildRecipe + 1;
} else {
    currentBuildRecipe =0;
};
[] call refresh_build_recipe_dialog;