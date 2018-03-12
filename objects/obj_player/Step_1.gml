var isFading = false;
with obj_fade {
	if instance_count > 0 {
		isFading = true;
	}
}
if isFading {
	speed = 0;
	state = CombatantStates.Idle;
	path_end();
	exit;
}
if lockOnTarget == noone {
	isLockedOn = false;
}

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

isMouseInMenu = global.ui.isShowingMenus &&
	mouse_x > vx + MENUS_TOPLEFT_X && mouse_x < vx + MENUS_BOTTOMRIGHT_X &&
	mouse_y > vy + MENUS_TOPLEFT_Y && mouse_y < vy + MENUS_BOTTOMRIGHT_Y;
	
if gamepad_is_connected(gamePadIndex) {
	if gamepad_button_check_released(gamePadIndex,gp_shoulderl) && !global.ui.isShowingMenus {
		performLeftHandReleaseAction();
	}
	if gamepad_button_check_released(gamePadIndex,gp_shoulderr) && !global.ui.isShowingMenus {
		performRightHandReleaseAction();
	}
	if gamepad_button_check(gamePadIndex,gp_shoulderl) {
		performLeftHandDownAction();
	}
	if gamepad_button_check(gamePadIndex,gp_shoulderr) {
		performRightHandDownAction();
	}
	if gamepad_button_check_pressed(gamePadIndex,gp_shoulderrb) && !global.ui.isShowingMenus {
		performDodge();
	}
	if gamepad_button_check_pressed(gamePadIndex,gp_face2) && !global.ui.isShowingMenus {
		performSwapWeaponSet();
	}
	if gamepad_button_check(gamePadIndex,gp_shoulderlb) && !global.ui.isShowingMenus {
		performChargeSpell();
	}
	if gamepad_button_check_pressed(gamePadIndex,gp_padu) && !global.ui.isShowingMenus {
		performCycleThroughSpells("up");
	}
	if gamepad_button_check_pressed(gamePadIndex,gp_padd) && !global.ui.isShowingMenus {
		performCycleThroughSpells("down");
	}
	if gamepad_button_check_pressed(gamePadIndex,gp_padr) && !global.ui.isShowingMenus {
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
	if gamepad_button_check_pressed(gamePadIndex,gp_padl) && !global.ui.isShowingMenus {
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
}
