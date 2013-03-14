_recipe = allBuildables select currentBuildRecipe;

_requeriments = [];
_classname = "";

_requeriments  = _recipe select 0;
_classname = _recipe select 1;

//Select the requeriments of materials
_recipeQtyT= _requeriments select 0;
_recipeQtyS= _requeriments select 1;
_recipeQtyW= _requeriments select 2;
_recipeQtyL= _requeriments select 3;
_recipeQtyM= _requeriments select 4;
_recipeQtyG= _requeriments select 5;

// Count mags in player inventory and add to an array
_mags = magazines player;
_qtyT=0;
_qtyS=0;
_qtyW=0;
_qtyL=0;
_qtyM=0;
_qtyG=0;

_buildables = [];
_mags = magazines player;
if ("ItemTankTrap" in _mags) then {
    _qtyT = {_x == "ItemTankTrap"} count magazines player;
    _buildables set [count _buildables, _qtyT];
    _itemT = "ItemTankTrap";
} else { _qtyT = 0; _buildables set [count _buildables, _qtyT]; };
    
if ("ItemSandbag" in _mags) then {
    _qtyS = {_x == "ItemSandbag"} count magazines player;
    _buildables set [count _buildables, _qtyS]; 
    _itemS = "ItemSandbag";
} else { _qtyS = 0; _buildables set [count _buildables, _qtyS]; };

if ("ItemWire" in _mags) then {
    _qtyW = {_x == "ItemWire"} count magazines player;
    _buildables set [count _buildables, _qtyW]; 
    _itemW = "ItemWire";
    } else { _qtyW = 0; _buildables set [count _buildables, _qtyW]; };
    if ("PartWoodPile" in _mags) then {
    _qtyL = {_x == "PartWoodPile"} count magazines player;
    _buildables set [count _buildables, _qtyL]; 
    _itemL = "PartWoodPile";
} else { _qtyL = 0; _buildables set [count _buildables, _qtyL]; };

if ("PartGeneric" in _mags) then {
    _qtyM = {_x == "PartGeneric"} count magazines player;
    _buildables set [count _buildables, _qtyM]; 
    _itemM = "PartGeneric";
} else { _qtyM = 0; _buildables set [count _buildables, _qtyM]; };

if ("HandGrenade_West" in _mags) then {
    _qtyG = {_x == "HandGrenade_West"} count magazines player;
    _buildables set [count _buildables, _qtyG]; 
    _itemG = "HandGrenade_West";
} else { _qtyG = 0; _buildables set [count _buildables, _qtyG]; };

_result = false;

_result = [_requeriments,_buildables] call BIS_fnc_areEqual;

//RESTRICTIONS ------------------------------
_restrictions=[];
_restrictions = _recipe select 2;

_toolbox=false;
_toolbox= _restrictions select 3;

_etool=false;
_etool= _restrictions select 4;

_medWait=false;
_longWait=false;
_medWait=_restrictions select 5;
_longWait=_restrictions select 6;


_removable=false;
_removable=_restrictions select 10;

_chance ="";
if (_removable) then {
    _chance="Rem:30% Fail"
};
_timer="10 s";
if(_medWait) then {
    _timer="20 s";
    if (_removable) then {
        _chance="Rem:70% Fail"
    };
 
};
if(_longWait) then {
    _timer="30 s";
    if (_removable) then {
        _chance="Rem:95% Fail"
    };
} ;

_inBuilding=false;
_inBuilding=_restrictions select 7;

_road=false;
_road=_restrictions select 8;

_inTown=false;
_inTown=_restrictions select 9;


//--------------------------------------------



with uiNamespace do {

if (!_result) then { 
    (Build_Recipe_Dialog displayCtrl 1600) ctrlEnable false;
//UnShow the Build Button
} else {
    //Show it
    (Build_Recipe_Dialog displayCtrl 1600) ctrlEnable true;
};

//[TankTrap, SandBags, Wires, Logs, Scrap Metal, Grenades]



    //Set ClassName
    (Build_Recipe_Dialog displayCtrl 1006) ctrlSetText format["%1",_classname];
    //Set Materials
    (Build_Recipe_Dialog displayCtrl 1000) ctrlSetText format["x%1  (%2)",_recipeQtyT,_qtyT];
    (Build_Recipe_Dialog displayCtrl 1001) ctrlSetText format["x%1  (%2)",_recipeQtyS,_qtyS];
    (Build_Recipe_Dialog displayCtrl 1002) ctrlSetText format["x%1  (%2)",_recipeQtyW,_qtyW];
    (Build_Recipe_Dialog displayCtrl 1003) ctrlSetText format["x%1  (%2)",_recipeQtyL,_qtyL];
    (Build_Recipe_Dialog displayCtrl 1004) ctrlSetText format["x%1  (%2)",_recipeQtyM,_qtyM];
    (Build_Recipe_Dialog displayCtrl 1005) ctrlSetText format["x%1  (%2)",_recipeQtyG,_qtyG];
    
    //Set Image
    (Build_Recipe_Dialog displayCtrl 1200) ctrlSetText format["buildRecipeBook\images\buildable\%1.jpg",_classname];
    
    //Set Restrictions
    (Build_Recipe_Dialog displayCtrl 1017) ctrlSetText format["%1",_toolbox];
    (Build_Recipe_Dialog displayCtrl 1016) ctrlSetText format["%1",_etool];
    (Build_Recipe_Dialog displayCtrl 1015) ctrlSetText format["%1",_timer];
    (Build_Recipe_Dialog displayCtrl 1013) ctrlSetText format["%1",_removable];
    (Build_Recipe_Dialog displayCtrl 1012) ctrlSetText format["%1",_inTown];
    (Build_Recipe_Dialog displayCtrl 1011) ctrlSetText format["%1",_road];
    (Build_Recipe_Dialog displayCtrl 1014) ctrlSetText format["%1",_inBuilding];
    (Build_Recipe_Dialog displayCtrl 1018) ctrlSetText format["%1",_chance];
};









//1017 - toolbox
//1016 -etool
//1015 - time
//1013 - removable
//1012 - town
//1011 - road
//1014 - building
























