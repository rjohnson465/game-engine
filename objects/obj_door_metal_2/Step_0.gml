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

/*
if !isOpen {
	maybeAddOrRemoveFromInteractablesList(20);
}*/

if	// isCurrentInteractableObject && 
	global.player.currentInteractableObject == id &&
	!isOpen  && layer == p.layer && interactInputReceived && p.isAlive && !global.isLooting && !isInConvo {
	
	var canOpenFromThisSide = false;
	// check if the player is on the proper side of the door
	if isOneSided {
		if p.x < x && opensFrom == "l" canOpenFromThisSide = true;
		else if p.x > x && opensFrom == "r" canOpenFromThisSide = true;
		else if p.y > y && opensFrom == "b" canOpenFromThisSide = true;
		else if p.y < y && opensFrom == "a" canOpenFromThisSide = true;
	} else canOpenFromThisSide = true;
	
	if !canOpenFromThisSide {
		var s = oneSidedDoorText == noone ? "Door does not open from this side" : oneSidedDoorText;
		alert(s, c_red); exit;
	}
	
	var hasKey = false;
	// check if this door is locked
	if keyRequired != noone {
		with obj_item_key {
			if owner == p && name == other.keyRequired {
				alert(name + " used!", c_lime);
				hasKey = true;
			}
		}
	} else hasKey = true;
	
	if !hasKey {
		var s = keyRequiredText != noone ? keyRequiredText : string(keyRequired) + " required to open this door";
		alert(s, c_red); exit;
	}
	
	var canOpen = canOpenFromThisSide && hasKey;
	
	if canOpen {
		isOpen = true;
		removeFromInteractablesList();
		updatePersistentElementProperty(id,"isOpen",true);
		
		// clear grid cells this object used to occupy
		var grid = ds_map_find_value(global.grids, getLayerFloorNumber(layer));
		mp_grid_clear_rectangle(grid, bbox_left, bbox_top, bbox_right, bbox_bottom);
		
		sprite_index = noone;
		alarm[0] = 30;
		audio_play_sound_at(openingSound,x,y,depth,500,AUDIO_MAX_FALLOFF_DIST,1,0,1);
		light_destroy_caster_layer(getLayerFloorNumber(layer));
		
		
	} 
} 