event_inherited();
var interactInputReceived = keyboard_check_released(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_released(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}

var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}
if global.isReadingTutorial exit;
var p = global.player;

if !isActive {
	maybeAddOrRemoveFromInteractablesList(20);
}

if	
	global.player.currentInteractableObject == id &&
	inventoryContainsItem(obj_item_clayheart) &&
	!isActive  && layer == p.layer && interactInputReceived && p.isAlive && !global.isLooting && !isInConvo {
	
		isAwakening = true;
		isActive = true;
		sprite_index = spr_hershel_rise;
		removeFromInteractablesList();
		audio_play_sound_at(snd_enemy_golem_roar_2,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
		
		scr_event_start(obj_event_saving_hershel);
	
} 