
audio_listener_position(x, y, depth);
if room == game_menu {
	exit;
}
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
	fall();
	exit;
}
event_inherited();

leftHandItem = ds_map_find_value(equippedLimbItems,"l");
rightHandItem = ds_map_find_value(equippedLimbItems,"r");

// lock on logic
updateLockOnTarget();

// move state triggers
updateMovementState();

// face mouse OR stick direction OR lockOnTarget (by default)
updateFacingDirection();

// state machine overrides
switch(state) {
	case CombatantStates.Idle: {
		if isFlinching exit;
		speed = 0;
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
			|| gamepad_button_check_pressed(gamePadIndex,gp_shoulderlb);
		}
		var RIGHTRELEASED = mouse_check_button_pressed(mb_right);
		if gamepad_is_connected(gamePadIndex) {
			RIGHTRELEASED = mouse_check_button_pressed(mb_left) 
			|| gamepad_button_check_released(gamePadIndex,gp_shoulderrb);
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
if distance_to_object(nearestStairs) < 200 /*&& nearestStairs.layer == layer*/ {
	if !place_meeting_layer(x,y,obj_stairs) && climbingDir != noone {
		
		//show_debug_message("up dir min: " + string(nearestStairs.upDirectionMin) + " | up dir max: " + string(nearestStairs.upDirectionMax) + " | curdir: " + string(direction));
		//show_debug_message(string(layerToChangeTo));
		//show_debug_message(string(layer_get_name(layerToChangeTo)));
		
		var oldLayer = layer;
		layer = layerToChangeTo;
		//depth = layer_get_depth(layer)-1;
		//updateRoomLayers();
		//climbingDir = noone;
		
		// reset grids for enemies on the old layer
		with obj_enemy_parent {
			if layer == oldLayer {
				populatePersonalGrid();
			}
		}
	}
}

// level up?
if (xp + xpTemp) >= xpToNextLevel {
	var remainingXp = (xp+xpTemp)-xpToNextLevel;
	xp = 0; xpTemp = remainingXp;
	level += 1;
	xpToNextLevel = round(1000*(power(level,1.1)));
	skillPoints++;
	alert("Level " + string(level) + " reached!",c_lime,90);
	audio_play_sound(snd_levelup,1,0);
	
	global.damageType = "LevelUp"; global.x1 = x; global.y1 = y; global.particleDirection = noone;
	global.hitParticlesLayer = layer;
	instance_create_depth(x,y,1,obj_hit_particles);
	room_speed = 15;
	alarm[0] = 15;
}

