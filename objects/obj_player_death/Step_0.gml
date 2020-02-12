// if mouse enters a button, highlight it
var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

// fountain revive
mouseOverFountainRevive = acceptingInput && mouse_x > vx + reviveAtFountainButtonCoordinates[0] && mouse_y > vy + reviveAtFountainButtonCoordinates[1]
	&& mouse_x < vx +reviveAtFountainButtonCoordinates[2] && mouse_y < vy + reviveAtFountainButtonCoordinates[3];
if mouseOverFountainRevive && selectedOption != ReviveOptions.Fountain {
	audio_play_sound(snd_ui_option_change,1,0);
	selectedOption = ReviveOptions.Fountain;
}

mouseOverOrbRevive = acceptingInput && reviveOrbs != noone && mouse_x > vx + reviveWithOrbButtonCoordinates[0] && mouse_y > vy + reviveWithOrbButtonCoordinates[1]
	&& mouse_x < vx + reviveWithOrbButtonCoordinates[2] && mouse_y < vy + reviveWithOrbButtonCoordinates[3];
if mouseOverOrbRevive && selectedOption != ReviveOptions.Orb {
	audio_play_sound(snd_ui_option_change,1,0);
	selectedOption = ReviveOptions.Orb;
}


if var_greyscale_fade < 1 var_greyscale_fade+= .1;

if var_greyscale_fade == 1 {
	if textFadeFrame < textFadeTotalFrames {
		textFadeFrame++;
	}
} 

if textFadeFrame >= textFadeTotalFrames && !instance_exists(fade) {
	acceptingInput = true;
}

var p = global.player;

var UP = keyboard_check_pressed(vk_up);
if gamepad_is_connected(p.gamePadIndex) {
	UP = keyboard_check_pressed(vk_up) || gamepad_button_check_pressed(p.gamePadIndex,gp_padu);
}

var DOWN = keyboard_check_pressed(vk_down);
if gamepad_is_connected(p.gamePadIndex) {
	DOWN = keyboard_check_pressed(vk_down) || gamepad_button_check_pressed(p.gamePadIndex,gp_padd);
}

if UP || DOWN && fade == noone && acceptingInput {
	audio_play_sound(snd_ui_option_change,1,0);
	selectedOption = selectedOption == ReviveOptions.Fountain ? ReviveOptions.Orb : ReviveOptions.Fountain;
	if reviveOrbs == noone {
		selectedOption = ReviveOptions.Fountain;
	}
} 

var ENTER = keyboard_check_pressed(vk_enter);
if gamepad_is_connected(p.gamePadIndex) {
	ENTER = keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(p.gamePadIndex,gp_face1);
}

if (ENTER || ((mouseOverFountainRevive || mouseOverOrbRevive) && mouse_check_button_released(mb_left))) && acceptingInput {
	global.fadeDuration = 30;
	global.owner = id;
	fade = instance_create_depth(x,y,-100000,obj_fade);
	acceptingInput = false;
}

if instance_exists(fade) {
	if fade.frame == .5*fade.fadeDuration {
		with p {
			
			hp = maxHp;
			stamina = maxStamina;
			isDying = false;
			isAlive = true;
			visible = true;
			alpha = 1;
			room_speed = 30;
			application_surface_draw_enable(true);
			
			// iff reviving at fountain
			if other.selectedOption == ReviveOptions.Fountain {
				/*var nearestFountain = instance_nearest(x,y,obj_fountain);
				if lastFountainRoom == noone {
				
					//lastFountain = nearestFountain;
					lastFountainRoom = room_get_name(asset_get_index(nearestFountain.nativeRoom));
					lastFountainX = nearestFountain.spawnX;
					lastFountainY = nearestFountain.spawnY;
					lastFountainZ = nearestFountain.layerName;
				
				}
				var rm = asset_get_index(lastFountainRoom);
				//room = lastFountainRoom;
				room_goto(rm);
				x = lastFountainX;
				y = lastFountainY;
				// xpTemp = 0;
				
				layerToMoveTo = lastFountainZ;
				justRevivedAtFountain = true; */
				returnToLastFountain();
				
				xpTemp = 0;
				fillHealthFlask();
			} 
			// or used revive orb
			else {
				other.reviveOrbs.count--;
				var p = global.player;
				if other.reviveOrbs.count <= 0 {
					with other.reviveOrbs {
						// clear this spot in the belt, if it was a beltItem
						if beltItemIndex != noone {
							p.beltItems[beltItemIndex] = noone;
							// set the current belt item index to something else, if possible
							var beltSize = array_length_1d(p.beltItems);
							for (var i = 0; i < beltSize; i++) {
								var index = i mod beltSize;
								var bi = p.beltItems[i];
								if bi != noone && bi != undefined && instance_exists(bi) {
									p.currentBeltItemIndex = index;
								}
							}
						}
					}
				}
				jumpToNearestFreePoint(0,1); // don't let player revive in a fallzone
				// populateGrids();
				global.isPopulatingGrids = true;
				global.respawnEnemiesAfterGridsPopulate = true;
				// special -- reset boss healths
				with obj_enemy_parent {
					if isBoss {
						hp = maxHp;
						cureAllConditions();
					}
				}
				
			}
			
			with obj_combatant_parent {
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
				state = CombatantStates.Idle;
				isStrafing = false;
				currentUsingSpell = noone;
				attackNumberInChain = noone;
				isShielding = false;
				fallScaleFactor = 1;
				fallFrame = fallTotalFrames;
			}
			other.fade.frame++;
		}
		
		
	} 
	if fade.frame == (.5*fade.fadeDuration + 5) {
		if p.justRevivedAtFountain {
			with p {
				if !instance_exists(lastFountain) {
					lastFountain = findPersistentRoomElement(obj_fountain, lastFountainX, lastFountainY);
				}
				
				if lastFountain == noone {
					lastFountain = instance_nearest(x, y, obj_fountain);
				}
				
				with lastFountain {
					wishAtFountain(false);
				}
				
				
			}
		}
		
		instance_destroy(id,true);
	}
}
