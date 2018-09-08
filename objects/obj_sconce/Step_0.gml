event_inherited();
var p = global.player;
if p.rightHandItem.object_index != obj_hand_item_torch {
	maybeRemoveObjectFromInteractionList(id);
	exit;
}
var interactInputReceived = keyboard_check_released(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_released(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}

var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

if !isLit && distance_to_object(obj_player) < 20 && layer == p.layer && interactInputReceived && p.isAlive && !global.isLooting && !isInConvo {
	isLit = true;
	ds_map_replace(data.properties, "isLit", true);
	audio_play_sound_at(snd_magic_fire_shoot,x,y,depth,100,300,1,0,1);
	global.owner = id;
	global.makeLightOnCreate = true;
	lightRadius = instance_create_depth(x,y,depth,obj_light_radius);
	with lightRadius {
		light_set_alpha(calculateLightRadiusAlpha());
	}
} 