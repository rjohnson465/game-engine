var interactInputReceived = keyboard_check_released(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_released(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}

if interactInputReceived && place_meeting(x,y,obj_player) {
	var p = global.player;
	p.x = nextRoomX;
	p.y = nextRoomY;
	p.layerToMoveTo = nextRoomLayer;
	room = nextRoom;
}