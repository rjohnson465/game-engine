/// proceedFromChooseItem()
/// must be called by instance of obj_fountain_gui_socketeditems

if global.fountainGui.currentMenu == INSERTGEM {
	var gemGui = instance_nearest(x,y,obj_fountain_gui_gems);
	gemGui.isAcceptingInput = false;
	gemGui.alarm[0] = 1;
	global.fountainGui.currentSubMenu = CHOOSEGEM; 
} else if global.fountainGui.currentMenu == BREAKDOWNITEM {
	var namePrice = instance_nearest(x,y,obj_fountain_gui_nameprice);
	namePrice.isAcceptingInput = false;
	namePrice.alarm[0] = 1;
	global.fountainGui.currentSubMenu = NAMEPRICE;
}