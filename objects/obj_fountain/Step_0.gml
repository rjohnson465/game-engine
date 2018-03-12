// fountain interaction
var interactInputReceived = keyboard_check_released(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_released(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}
if distance_to_object(obj_player) < 20 && interactInputReceived {
	wishAtFountain();
}


var lDepth = layer_get_depth(origLayer);
lDepth += 2;
depth = lDepth;


