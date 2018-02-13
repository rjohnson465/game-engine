event_inherited();
if !global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY exit;

if !position_meeting(mouse_x,mouse_y,id) && grabFrame < grabFrames {
	grabFrame = 0;
	mightGrab = false;
}

if mightGrab && grabFrame < grabFrames && mouse_check_button(mb_left) {
	grabFrame++;
}

visible = false;
if grabFrame == grabFrames {
	cursor_sprite = itemSprite;
	visible = true;
	x = mouse_x;
	y = mouse_y;
	global.ui.grabbedItem = id;
} 

var a = global.ui.isShowingMenus;
var b = global.ui.currentMenu == INVENTORY;
if !global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY {
	visible = false;
}
