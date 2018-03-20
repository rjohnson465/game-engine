// fountain interaction
var interactInputReceived = keyboard_check_released(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_released(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}


// to draw under hands
var lDepth = layer_get_depth(origLayer);
lDepth += 2;
depth = lDepth;

var fade = noone;
with obj_fade {
	if owner == other.id {
		fade = id;
	}
}

if distance_to_object(obj_player) < 20 && interactInputReceived && fade == noone && global.player.isAlive {
	if !isRunning {
		wishAtFountain(); // turn fountain on ;)
	} else {
		global.fadeDuration = 30;
		global.owner = id;
		instance_create_depth(x,y,-100000,obj_fade);
	}
} 
else if fade != noone {
	if fade.frame == .5*fade.fadeDuration && isDoneFilling {
		wishAtFountain(); // reposition enemies when screen is all fucked up
	} 
}

