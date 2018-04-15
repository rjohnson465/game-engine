/// startInsertGemMenu()	
/// must be called by instance of obj_fountain_gui

currentMenu = INSERTGEM; 
currentSubMenu = CHOOSEITEM; 
instance_create_depth(x,y,1,obj_fountain_gui_socketeditems);
instance_create_depth(x,y,1,obj_fountain_gui_gems);
instance_create_depth(x,y,1,obj_fountain_gui_nameprice);