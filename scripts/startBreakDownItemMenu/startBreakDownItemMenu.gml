/// startBreakDownItemMenu()
/// must be called by instance of obj_fountain_gui

isAcceptingInput = false;
currentMenu = BREAKDOWNITEM; 
currentSubMenu = CHOOSEITEM; 
instance_create_depth(x,y,1,obj_fountain_gui_gemmeditems);
instance_create_depth(x,y,1,obj_fountain_gui_nameprice);