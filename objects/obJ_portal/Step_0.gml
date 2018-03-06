var interactInputReceived = keyboard_check_released(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_released(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}

var fade = noone;
var idd = id;
with obj_fade {
	if owner == idd {
		fade = id;
	}
}

if interactInputReceived && place_meeting(x,y,obj_player) && fade == noone {
	global.fadeDuration = 60;
	global.owner = id;
	instance_create_depth(x,y,-100000,obj_fade);
} 
else if fade != noone {
	if fade.frame == .5*fade.fadeDuration {
		var p = global.player;
		p.x = nextRoomX;
		p.y = nextRoomY;
		p.layerToMoveTo = nextRoomLayer;
		room = nextRoom;
	}
}