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

if !isOpen {
	maybeAddOrRemoveFromInteractablesList(20);
}

if	// isCurrentInteractableObject && 
	global.player.currentInteractableObject == id &&
	!isOpen  && layer == p.layer && interactInputReceived && p.isAlive && !global.isLooting && !isInConvo {
	
	var hasKey = inventoryContainsItem(obj_item_randolphs_nose);
	
	if !hasKey {
		alert(keyRequired + " required to melt ice", c_red); exit;
	}
	
	var canOpen = hasKey;
	
	if canOpen {
		
		isOpen = true;
		removeFromInteractablesList();
		updatePersistentElementProperty(id,"isOpen",true);
		sprite_index = noone;
		alarm[0] = MELT_FRAMES_TOTAL;
		audio_play_sound_at(snd_melt,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
		light_destroy_caster_layer(getLayerFloorNumber(layer));
		
		// global.isPopulatingGrids = true;
		// clear grid cells this object used to occupy
		var grid = ds_map_find_value(global.grids, getLayerFloorNumber(layer));
		mp_grid_clear_rectangle(grid, bbox_left, bbox_top, bbox_right, bbox_bottom);

	} 
} 