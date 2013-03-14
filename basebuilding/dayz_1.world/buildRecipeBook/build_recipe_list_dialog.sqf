 _ok = createDialog "Build_Recipe_List_Dialog";
 [] call refresh_build_recipe_list_dialog;
 waitUntil { !dialog }; // hit ESC to close it
