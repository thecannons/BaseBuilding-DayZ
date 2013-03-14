_selected=0;
with uiNamespace do {
    _selected= lbCurSel (Build_Recipe_List_Dialog displayCtrl 2500);
};

currentBuildRecipe=_selected;

closeDialog 0;
_nil=[]ExecVM "buildRecipeBook\build_recipe_dialog.sqf";