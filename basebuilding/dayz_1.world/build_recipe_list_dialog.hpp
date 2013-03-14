//$[1.03,[[0,0,1,1],0.03125,0.05],[1800,"BuildRecipeListFrame",[1,"Build Recipe List",["0.29375 * safezoneW + safezoneX","0.224947 * safezoneH + safezoneY","0.4125 * safezoneW","0.550106 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],""],[]],[1500,"RecipeBuildList",[1,"",["0.351758 * safezoneW + safezoneX","0.29371 * safezoneH + safezoneY","0.296484 * safezoneW","0.385074 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],""],[]],[1600,"BackButton",[1,"Back",["0.351758 * safezoneW + safezoneX","0.692537 * safezoneH + safezoneY","0.128906 * safezoneW","0.0550106 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],""],[]],[1601,"ViewButton",[1,"View selected",["0.519336 * safezoneW + safezoneX","0.692537 * safezoneH + safezoneY","0.128906 * safezoneW","0.0550106 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],""],[]]]

class Build_Recipe_List_Dialog
{
    idd = -1;
    onLoad="uiNamespace setVariable ['Build_Recipe_List_Dialog', _this select 0]";
    movingenable = true;
    onUnLoad="uiNamespace setVariable ['Build_Recipe_List_Dialog', nil]";
    class Controls
    {    
        
         class ListBox: BOX
         {
	      idc = -1;
	      text = "";
            x = 0.29375 * safezoneW + safezoneX;
            y = 0.224947 * safezoneH + safezoneY;
            w = 0.411042 * safezoneW;
            h = 0.547125 * safezoneH;
         };
        
        class BuildRecipeListFrame: RscFrame
        {
            idc = 1800;
            text = "Build Recipe List";
            x = 0.29375 * safezoneW + safezoneX;
            y = 0.224947 * safezoneH + safezoneY;
            w = 0.4125 * safezoneW;
            h = 0.550106 * safezoneH;
        };
        class RecipeBuildList: RscListbox
        {
            idc = 2500;
            x = 0.351758 * safezoneW + safezoneX;
            y = 0.29371 * safezoneH + safezoneY;
            w = 0.296484 * safezoneW;
            h = 0.385074 * safezoneH;
        };
        class BackButton: RscButton
        {
            idc = 1600;
            text = "Back";
            x = 0.351758 * safezoneW + safezoneX;
            y = 0.692537 * safezoneH + safezoneY;
            w = 0.128906 * safezoneW;
            h = 0.0550106 * safezoneH;
            action = "closeDialog 0;_nil=[]ExecVM 'buildRecipeBook\build_recipe_dialog.sqf'";
        };
        class ViewButton: RscButton
        {
            idc = 1601;
            text = "View selected";
            x = 0.519336 * safezoneW + safezoneX;
            y = 0.692537 * safezoneH + safezoneY;
            w = 0.128906 * safezoneW;
            h = 0.0550106 * safezoneH;
            action = "_nil=[]ExecVM 'buildRecipeBook\build_recipe_list_select.sqf'";

            
        };
    };
};