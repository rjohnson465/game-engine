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

if isCurrentInteractableObject && !isOpen && distance_to_object(obj_player) < 20 && layer == p.layer && interactInputReceived && p.isAlive && !global.isLooting && !isInConvo {
	
	var canOpenFromThisSide = false;
	// check if the player is on the proper side of the door
	if isOneSided {
		if p.x < x && opensFrom == "l" canOpenFromThisSide = true;
		else if p.x > x && opensFrom == "r" canOpenFromThisSide = true;
		else if p.y > y && opensFrom == "b" canOpenFromThisSide = true;
		else if p.y < y && opensFrom == "a" canOpenFromThisSide = true;
	} else canOpenFromThisSide = true;
	
	if !canOpenFromThisSide {
		alert("Door does not open from this side", c_red); exit;
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
		alert(keyRequired + " required to open this door", c_red); exit;
	}
	
	var canOpen = canOpenFromThisSide && hasKey;
	
	if canOpen {
		isOpen = true;
		updatePersistentElementProperty(id,"isOpen",true);
		sprite_index = noone;
		alarm[0] = 30;
		audio_play_sound_at(openingSound,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
	} 
} 