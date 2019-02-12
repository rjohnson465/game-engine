var sprString = "spr_"+spriteString;
if asset_get_index(sprString+"_move") && ((state == CombatantStates.Moving || state == CombatantStates.Wary) && isMoving) {
	if type != CombatantTypes.Player || (!global.ui.isShowingMenus && !global.isWishing) {
		sprString = sprString+"_move";
	}
	if object_is_ancestor(object_index, obj_combatant_parent) && isShielding {
		var sprString2 = sprString + "_shielding";
		if asset_get_index(sprString2) >= 0 {
			sprString = sprString2;
		}
	}
}

if asset_get_index(sprString+"_move") && type == CombatantTypes.Player && !global.ui.isShowingMenus {
	// if 2h ranged preparing
	var lhItem = ds_map_find_value(equippedLimbItems,"l");
	var ir = lhItem.subType == HandItemTypes.Ranged;
	var th = lhItem.isTwoHanded;
	var ms = ds_map_size(preparingLimbs) != 0;
	if (lhItem.subType == HandItemTypes.Ranged && lhItem.isTwoHanded && ds_map_size(preparingLimbs) != 0) 
		|| currentUsingSpell != noone
		{
		// iff movement input given
		var UP = keyboard_check(ord("W"));
		var DOWN = keyboard_check(ord("S"));
		var LEFT = keyboard_check(ord("A"));
		var RIGHT = keyboard_check(ord("D"));
		var gamePadInputReceived = false;
		if gamepad_is_connected(gamePadIndex) {
			var h_point = gamepad_axis_value(gamePadIndex, gp_axislh);
			var v_point = gamepad_axis_value(gamePadIndex, gp_axislv);
			if h_point != 0 || v_point != 0 {
				gamePadInputReceived = true;
				direction = (point_direction(0,0,h_point,v_point))%360;
			}
		}
		if UP || DOWN || LEFT || RIGHT || gamePadInputReceived {
			sprString = sprString+"_move";
			image_speed = .5;
		} else image_speed = 1;
	} else image_speed = 1;
} else image_speed = 1;
	
// image speed is faster if sprinting (player only?)
var SHIFT = keyboard_check(vk_shift);
if gamepad_is_connected(global.player.gamePadIndex) {
	SHIFT = keyboard_check(vk_shift) || 
		gamepad_button_check(global.player.gamePadIndex,gp_face4) || gamepad_button_check(global.player.gamePadIndex,gp_stickl);
}
if type == CombatantTypes.Player && SHIFT && state == CombatantStates.Moving {
	image_speed = 1.5;
}
	
// moving backwards makes move animation go backwards and slow
if abs(angle_difference(facingDirection,direction)) > 90 {
	image_speed = -.5;
}
if isSlowed {
	var is = image_speed;
	is = is*.5;
	image_speed = is
}

// maybe use a special base sprite for shielding
if object_is_ancestor(object_index, obj_combatant_parent) && isShielding {
	var sprString2 = sprString + "_shielding";
	if asset_get_index(sprString2) >= 0 {
		sprString = sprString2;
	}
}

sprite_index = asset_get_index(sprString);