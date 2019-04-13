prevX = x;
prevY = y;
if room == game_menu {
	exit;
}
var isFading = false;
with obj_fade {
	if instance_count > 0 {
		isFading = true;
	}
}
if isFading || !isAlive {
	speed = 0;
	state = CombatantStates.Idle;
	path_end();
	exit;
}
if isEquippingBeltItem && !global.ui.isShowingMenus {
	isEquippingBeltItem = false;
}
if lockOnTarget == noone {
	isLockedOn = false;
}

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

var currentItemDrop = noone;
with obj_item_drop {
	if isBeingLooted currentItemDrop = id;
}

isMouseInMenu = 
	// main player menus
	(global.ui.isShowingMenus &&
	mouse_x > vx + MENUS_TOPLEFT_X && mouse_x < vx + MENUS_BOTTOMRIGHT_X &&
	mouse_y > vy + MENUS_TOPLEFT_Y && mouse_y < vy + MENUS_BOTTOMRIGHT_Y)
	||
	// current loot menu
	(currentItemDrop != noone && 
	mouse_x > vx + currentItemDrop.topLeftX && mouse_x < vx + currentItemDrop.bottomRightX &&
	mouse_y > vy + currentItemDrop.topLeftY && mouse_y < vy + currentItemDrop.bottomRightY)
	;
	
if gamepad_is_connected(gamePadIndex) && state != CombatantStates.Healing {
	
	// sprint counter -- when this is less than 0, isHoldingSprintButton is true and we will sprint
	if gamepad_button_check(gamePadIndex, gp_face2) && !global.ui.isShowingMenus && sprintCounter > 0 {
		sprintCounter--;
		if sprintCounter <= 0 {
			isHoldingSprintButton = true;
		}
	}
	
	
	if gamepad_button_check_pressed(gamePadIndex,gp_shoulderl) && !global.ui.isShowingMenus {
		performLeftHandReleaseAction();
	}
	if gamepad_button_check_pressed(gamePadIndex,gp_shoulderr) && !global.ui.isShowingMenus {
		performRightHandReleaseAction();
	}
	
	if gamepad_button_check_released(gamePadIndex,gp_shoulderr) {
		if object_is_ancestor(rightHandItem.object_index, obj_shield_parent)
		|| (leftHandItem.isRanged && leftHandItem.isTwoHanded)
		{
			performRightHandReleaseAction();
		}
	}
	
	if gamepad_button_check_pressed(gamePadIndex,gp_shoulderl) {
		performLeftHandDownAction();
	}
	if gamepad_button_check_pressed(gamePadIndex,gp_shoulderr) {
		performRightHandDownAction();
	}
	if gamepad_button_check(gamePadIndex, gp_shoulderr) && object_is_ancestor(rightHandItem.object_index, obj_shield_parent) {
		performRightHandDownAction();
	}
	if leftHandItem.isTwoHanded && leftHandItem.isRanged && gamepad_button_check(gamePadIndex, gp_shoulderr) {
		performRightHandDownAction();
	}
	if gamepad_button_check_released(gamePadIndex,gp_face2) && !global.ui.isShowingMenus && !global.ui.justClosedMenus && !global.isLooting && (!isHoldingSprintButton || !isMoving) {
		performDodge();
	}
	
	// use belt item
	if state != CombatantStates.Dodging && state != CombatantStates.Staggering && state != CombatantStates.Attacking && !global.ui.isShowingMenus {
		if gamepad_button_check_pressed(gamePadIndex, gp_face3) {
			performUseBeltItem();
		}
	}
	
	// spell casting
	if gamepad_button_check(gamePadIndex,gp_shoulderlb) && !global.ui.isShowingMenus && !justCastSpell {
		performChargeSpell();
	}
	if justCastSpell && gamepad_button_check_released(gamePadIndex, gp_shoulderlb) {
		justCastSpell = false;
	}
	
	if gamepad_button_check_pressed(gamePadIndex,gp_padu) && !global.ui.isShowingMenus && !global.isLooting && !global.isWishing & !isHoldingAttunemntSwapMode {
		performCycleThroughSpells("up");
	}
	if gamepad_button_check_pressed(gamePadIndex,gp_padd) && !global.ui.isShowingMenus && !global.isLooting && !global.isWishing && !isHoldingAttunemntSwapMode {
		performCycleThroughSpells("down");
	}
	
	
	if !gamepad_button_check(gamePadIndex, gp_shoulderrb) {
		isHoldingAttunemntSwapMode = false;
		if gamepad_button_check_pressed(gamePadIndex,gp_padr) && !global.ui.isShowingMenus && !global.isLooting && !global.isWishing && !global.isInteractingWithNpc {
			performSwapRightHand();
		}
		if gamepad_button_check_pressed(gamePadIndex,gp_padl) && !global.ui.isShowingMenus && !global.isLooting && !global.isWishing && !global.isInteractingWithNpc {
			performSwapLeftHand();
		}
	}
	// d pad swaps attunements when RT is held down
	else if !global.ui.isShowingMenus && !global.isTrading && !global.isWishing && !global.isInteractingWithNpc {
		isHoldingAttunemntSwapMode = true;
		if gamepad_button_check_pressed(gamePadIndex,gp_padr) && !global.ui.isShowingMenus && !global.isLooting && !global.isWishing && !global.isInteractingWithNpc {
			if currentSpellPrepSound != noone {
				audio_stop_sound(currentSpellPrepSound);
			}
			audio_play_sound(snd_ui_option_change,1,0);
			switch currentSpellAttunement {
				case MAGIC: {
					currentSpellAttunement = FIRE;
					break;
				}
				case FIRE: {
					currentSpellAttunement = ICE;
					break;
				}
				case ICE: {
					currentSpellAttunement = POISON;
					break;
				}
				case POISON: {
					currentSpellAttunement = LIGHTNING;
					break;
				}
				case LIGHTNING: {
					currentSpellAttunement = MAGIC;
					break;
				}
			}
		}
		if gamepad_button_check_pressed(gamePadIndex,gp_padl) && !global.ui.isShowingMenus && !global.isLooting && !global.isWishing && !global.isInteractingWithNpc {
			if currentSpellPrepSound != noone {
				audio_stop_sound(currentSpellPrepSound);
			}
			audio_play_sound(snd_ui_option_change,1,0);
			switch currentSpellAttunement {
				case MAGIC: {
					currentSpellAttunement = LIGHTNING;
					break;
				}
				case FIRE: {
					currentSpellAttunement = MAGIC;
					break;
				}
				case ICE: {
					currentSpellAttunement = FIRE;
					break;
				}
				case POISON: {
					currentSpellAttunement = ICE;
					break;
				}
				case LIGHTNING: {
					currentSpellAttunement = POISON;
					break;
				}
			}
		}
		
		// belt item swap
		if gamepad_button_check_pressed(gamePadIndex,gp_padu) && !global.ui.isShowingMenus && !global.isLooting && !global.isWishing && !global.isInteractingWithNpc {
			var newBeltItemIndex = currentBeltItemIndex - 1;
			if newBeltItemIndex < 0 {
				newBeltItemIndex = 4;
			}
			currentBeltItemIndex = newBeltItemIndex;
			audio_play_sound(snd_ui_option_change,1,0);
		}
		
		if gamepad_button_check_pressed(gamePadIndex,gp_padd) && !global.ui.isShowingMenus && !global.isLooting && !global.isWishing && !global.isInteractingWithNpc {
			var newBeltItemIndex = currentBeltItemIndex + 1;
			if newBeltItemIndex > 4 {
				newBeltItemIndex = 0;
			}
			currentBeltItemIndex = newBeltItemIndex;
			audio_play_sound(snd_ui_option_change,1,0);
		}
		
	}
}
