prepareLayerShader();
// draw stagger sprite if staggering
if state == CombatantStates.Staggering {
	draw_sprite_ext(asset_get_index("spr_"+spriteString+"_stagger"),1,x,y,1,1,facingDirection,c_white,1);
	// slowed
	if isSlowed || isFrozen {
		var percentFrozen = ds_map_find_value(conditionPercentages,ICE);
		var colorAlpha = (3/320)*percentFrozen;
		draw_sprite_ext(asset_get_index("spr_"+spriteString+"_stagger"), 1, x, y, 1, 1, facingDirection, c_aqua, colorAlpha*alpha);
	} else if isPoisoned {
		var percentPoisoned = ds_map_find_value(conditionPercentages,POISON);
		var colorAlpha = (3/320)*percentPoisoned;
		draw_sprite_ext(asset_get_index("spr_"+spriteString+"_stagger"), 1, x, y, 1, 1, facingDirection, c_green, colorAlpha*alpha);
	}
}

// draw dodge sprite if dodging
if state == CombatantStates.Dodging {
	var a = alpha;
	if isFairy a = alpha*.5;
	draw_sprite_ext(asset_get_index("spr_"+spriteString+"_dodge"),dodgeFrame,x,y,1,1,dodgeDirection,c_white,a);
	// slowed
	if isSlowed {
		var percentFrozen = ds_map_find_value(conditionPercentages,ICE);
		var colorAlpha = (3/320)*percentFrozen;
		draw_sprite_ext(asset_get_index("spr_"+spriteString+"_dodge"), dodgeFrame, x, y, 1, 1, dodgeDirection, c_aqua, colorAlpha*a);
	} else if isPoisoned {
		var percentPoisoned = ds_map_find_value(conditionPercentages,POISON);
		var colorAlpha = (3/320)*percentPoisoned;
		draw_sprite_ext(asset_get_index("spr_"+spriteString+"_dodge"), dodgeFrame, x, y, 1, 1, dodgeDirection, c_green, colorAlpha*a);
	}
	
} 

if state == CombatantStates.Attacking {
	

}

if state != CombatantStates.Dodging && state != CombatantStates.Staggering {
	
	var sprString = "spr_"+spriteString;
	if asset_get_index(sprString+"_move") && state == CombatantStates.Moving {
		sprString = sprString+"_move";
	}

	if asset_get_index(sprString+"_move") && type == CombatantTypes.Player {
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
	
	// moving backwards makes move animation go backwards and slow
	if abs(angle_difference(facingDirection,direction)) > 90 {
		image_speed = -.5;
	}
	
	sprite_index = asset_get_index(sprString);
	
	// normally draw base sprite -- on top of hands
	alpha = 1;
	scale = 1;
	var scaleFactor = 1;
	
	// fairies float
	if isFairy || isFloating {
		scale = .1*cos((pi*floatingFrame)/30)+.9; // normal floating
	} 
	
	// jumping
	if jumpFrame < jumpTotalFrames {
		var percentDone = jumpFrame / jumpTotalFrames;
		scaleFactor = (-.5*abs((2*percentDone)-1))+1.5;
		scale = scale * scaleFactor;
	}
	// falling
	if fallFrame < fallTotalFrames {
		var percentDone = fallFrame / fallTotalFrames;
		// this factor is used by all limbs
		fallScaleFactor = (.5*abs((2*percentDone)-1))+.5;
		scale = scale * fallScaleFactor;
	}
	if isDying {
		alpha = (-dyingFrame/dyingTotalFrames)+1;
	}
	
	//draw_sprite_ext(asset_get_index("spr_"+spriteString), idleFrame, x, y, scale, scale, facingDirection, c_white, alpha);
	draw_sprite_ext(asset_get_index(sprString), image_index, x, y, scale, scale, facingDirection, c_white, alpha);
	
	if isSlowed {
		var percentFrozen = ds_map_find_value(conditionPercentages,ICE);
		var colorAlpha = (3/320)*percentFrozen;
		draw_sprite_ext(asset_get_index("spr_"+spriteString), idleFrame, x, y, scale, scale, facingDirection, c_aqua, colorAlpha*alpha);
	} 
	else if isFrozen {
		draw_sprite_ext(asset_get_index("spr_"+spriteString), idleFrame, x, y, scale, scale, facingDirection, c_aqua, .75*alpha);
	} 
	else if isPoisoned {
		var percentPoisoned = ds_map_find_value(conditionPercentages,POISON);
		var colorAlpha = (3/320)*percentPoisoned;
		draw_sprite_ext(asset_get_index("spr_"+spriteString), idleFrame, x, y, scale, scale, facingDirection, c_aqua, colorAlpha*alpha);
	}
	
	var totalIdleFrames = sprite_get_number(asset_get_index("spr_"+spriteString));
	
	idleFrame += 1;
	idleFrame = idleFrame % totalIdleFrames;
	//image_speed = oldImageSpeed;
}

if isFairy {
	floatingFrame += 1;
	floatingFrame = floatingFrame % 60;
}

shader_reset();
