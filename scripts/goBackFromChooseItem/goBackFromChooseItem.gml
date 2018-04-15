/// goBackFromChooseItem() 
/// must be called by obj_fountain_gui_socketeditems

global.fountainGui.currentMenu = FOUNTAIN;
global.fountainGui.alarm[1] = 2;
instance_destroy(obj_fountain_gui_gems,1);
instance_destroy(obj_fountain_gui_nameprice,1);
instance_destroy(id,1);
