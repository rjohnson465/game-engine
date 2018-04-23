var interactInputReceived = keyboard_check_released(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_released(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}

var fade = noone;
with obj_fade {
	if owner == other.id {
		fade = id;
	}
}

if interactInputReceived && place_meeting(x,y,obj_player) && fade == noone && global.player.isAlive && !global.canLoot {

	with obj_player {
		// stop preparing attacks
		if ds_map_size(preparingLimbs) != 0 {
			var hand = ds_map_find_first(preparingLimbs);
			for (var i = 0; i < ds_map_size(preparingLimbs); i++) {
				ds_map_replace(prepFrames,hand,-1);
				ds_map_replace(prepFrameTotals,hand,0);
				ds_map_delete(preparingLimbs,hand);
				hand = ds_map_find_next(preparingLimbs,hand);
			}
		}
		// stop attacking
		if ds_map_size(attackingLimbs) != 0 {
			var hand = ds_map_find_first(attackingLimbs);
			for (var i = 0; i < ds_map_size(attackingLimbs); i++) {
				ds_map_delete(attackingLimbs,hand);
				hand = ds_map_find_next(attackingLimbs,hand);
			}
		}
		// stop recovering attacks
		if ds_map_size(recoveringLimbs) != 0 {
			var hand = ds_map_find_first(recoveringLimbs);
			for (var i = 0; i < ds_map_size(recoveringLimbs); i++) {
				ds_map_replace(recoveringLimbs,hand,-1);
				ds_map_replace(recoveringLimbs,hand,0);
				ds_map_delete(recoveringLimbs,hand);
				hand = ds_map_find_next(recoveringLimbs,hand);
			}
		}
		isStrafing = false;
		currentUsingSpell = noone;
		attackNumberInChain = noone;
		isShielding = false;
		dodgeFrame = 0;
	}
	
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