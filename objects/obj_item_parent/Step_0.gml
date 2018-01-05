event_inherited();

if !position_meeting(mouse_x,mouse_y,id) && grabFrame < grabFrames {
	grabFrame = 0;
	mightGrab = false;
}

if mightGrab && grabFrame < grabFrames && mouse_check_button(mb_left) {
	grabFrame++;
}

if grabFrame == grabFrames {
	cursor_sprite = itemSprite;
	visible = true;
	x = mouse_x;
	y = mouse_y;
	global.ui.grabbedItem = id;
}

if !global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY {
	visible = false;
	//x = -50;
	//y = -50;
	cursor_sprite = -1;
}