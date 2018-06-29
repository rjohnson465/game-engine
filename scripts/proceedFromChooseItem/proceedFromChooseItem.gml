/// proceedFromChooseItem()
/// must be called by instance of obj_fountain_gui_socketeditems
audio_play_sound(snd_ui_click1,1,0);
if selectedItem == noone {
	alert("No item selected",c_red);
	exit;
}

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
} else if global.fountainGui.currentMenu == REPAIRITEM {
	var namePrice = instance_nearest(x,y,obj_fountain_gui_nameprice);
	namePrice.isAcceptingInput = false;
	namePrice.alarm[0] = 1;
	global.fountainGui.currentSubMenu = NAMEPRICE;
}