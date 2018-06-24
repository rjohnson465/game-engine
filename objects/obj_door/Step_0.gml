var interactInputReceived = keyboard_check_released(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_released(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}

var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

if !isOpen && distance_to_object(obj_player) < 20 && layer == global.player.layer && interactInputReceived && global.player.isAlive && !global.isLooting && !isInConvo {
	isOpen = true;
	ds_map_replace(data.properties, "isOpen", true);
	sprite_index = noone;
	alarm[0] = 30;
	audio_play_sound_at(openingSound,x,y,depth,100,300,1,0,1);
} 