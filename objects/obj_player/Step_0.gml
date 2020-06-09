if room == game_menu {
	exit;
}

audio_listener_position(x, y, depth);

var isFading = false;
with obj_fade {
	if instance_count > 0 {
		isFading = true;
	}
}
if isFading || isDying || !isAlive {
	speed = 0;
	state = CombatantStates.Idle;
	path_end();
	exit;
}

if fallFrame < fallTotalFrames {
	fall(mightFallOffRidge);
	exit;
}
event_inherited();

leftHandItem = ds_map_find_value(equippedLimbItems,"l");
rightHandItem = ds_map_find_value(equippedLimbItems,"r");

// drain temporary defenses
drainTemporaryDefenses();

// lock on logic
updateLockOnTarget();

// move state triggers
updateMovementState();

// face mouse OR stick direction OR lockOnTarget (by default)
updateFacingDirection();

if state != CombatantStates.Attacking && ds_map_size(recoveringLimbs) != 0 {
	ds_map_clear(recoveringLimbs);
}

// reset healingFrame if not in healing
if healingFrame != 0 && state != CombatantStates.Healing {
	healingFrame = 0;
}

// state machine overrides
switch(state) {
	case CombatantStates.Idle: {
		if isFlinching exit;
		speed = 0;
		break;
	}
	case CombatantStates.Healing: {
		
		// actual heal on 20th frame of healing animation
		if healingFrame == 20 {
			var flask = instance_nearest(x,y,obj_item_health_flask);
			audio_play_sound(snd_iu_choirheal,1, 0);
			instance_create_depth(x,y,1,obj_healthflask_particles);
			useItem(flask);
		}
		
		if healingFrame >= healingTotalFrames {
			healingFrame = 0;
			state = CombatantStates.Idle;
			break;
		}
		
		healingFrame++;
		
		break;
	}
	case CombatantStates.Moving: {
		playerMove();
		break;
	}
	case CombatantStates.Attacking: {
		
		var lhItem = ds_map_find_value(equippedLimbItems,"l");
		// movement in attack state is slightly different
		playerAttackingMove();
		
		// check if spell attack
		// spells are all 2h and thus use the "l" side (might change this later idk)
		if currentUsingSpell != noone {
			playerAttackingSpell();
			break;
		}
		
		// melee / ranged
		var LEFTRELEASED = mouse_check_button_pressed(mb_left);
		if gamepad_is_connected(gamePadIndex) {
			LEFTRELEASED = mouse_check_button_pressed(mb_left) 
			|| gamepad_button_check_pressed(gamePadIndex,gp_shoulderl);
		}
		var RIGHTRELEASED = mouse_check_button_pressed(mb_right);
		if gamepad_is_connected(gamePadIndex) {
			RIGHTRELEASED = mouse_check_button_pressed(mb_left) 
			|| gamepad_button_check_released(gamePadIndex,gp_shoulderr);
		}
		
		// iterate over preparing hands 
		// if they just started preparing, need to assign prepare frames / total frames
		// if they are finishing preparing, need to create attack objects
		playerIterateOverPreparingHands();
		
		// move forward while attacking with a melee attack (if not simultaenously preparing another attack)
		playerMaybeMoveDuringAttack();
		
		// update attackFrames values
		playerUpdateAttackFrames();
		
		// iterate over recovering hands
		// if they just started recovering, need to assign recover frames / total frames
		// if they just finished recovering, need to check if we need to leave attack state or if we need to attack with that hand again
		playerIterateOverRecoveringHands();
		
		// handle 2h ranged weapon attacks
		// this is a 2h ranged weapon, so limb must be "l"
		playerAttackingRanged2H();
		break;
	}
}


// walking up / down stairs change layers, set solids for enemies on this layer (done in updateRoomLayers)
var nearestStairs = instance_nearest(x,y,obj_stairs);
if distance_to_object(nearestStairs) < 200 {
	if !place_meeting_layer(x,y,obj_stairs) && climbingDir != noone {
		
		var oldLayer = layer;
		layer = layerToChangeTo;
		global.isUpdatingRoomLayers = true;
		climbingDir = noone;
		
		updateLightLayer(playerLightRadius,oldLayer,layer);

	}
} 

maybeLevelUp();

if isSprinting {
	if !audio_is_playing(snd_move_sprint) {
		audio_play_sound(snd_move_sprint,1,1);
	}
} else {
	if audio_is_playing(snd_move_sprint) {
		audio_stop_sound(snd_move_sprint);
	}
}

if interactableResetFrame > 0 {
	interactableResetFrame--;
}

if dodgeRestFrame > 0 {
	dodgeRestFrame--;
	if dodgeRestFrame == 0 && dodgeAgain {
		dodgeAgain = false;
		if state != CombatantStates.Attacking && state != CombatantStates.Staggering {
			performDodge();
		}
	}
}