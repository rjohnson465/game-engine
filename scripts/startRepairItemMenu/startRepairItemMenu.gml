/// startRepairItemMenu()
/// must be called by instance of obj_fountain_gui

isAcceptingInput = false;
currentMenu = REPAIRITEM; 
currentSubMenu = CHOOSEITEM; 
instance_create_depth(x,y,1,obj_fountain_gui_brokenitems);
instance_create_depth(x,y,1,obj_fountain_gui_nameprice);