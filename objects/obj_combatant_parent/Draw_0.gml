
// draw stagger sprite if staggering
if state == CombatantStates.Staggering {
	draw_sprite_ext(asset_get_index("spr_"+spriteString+"_stagger"),1,x,y,1,1,facingDirection,c_white,1);
	// slowed
	if isSlowed || isFrozen {
		var percentFrozen = ds_map_find_value(conditionPercentages,ICE);
		var colorAlpha = (3/320)*percentFrozen;
		draw_sprite_ext(asset_get_index("spr_"+spriteString+"_stagger"), 1, x, y, 1, 1, facingDirection, c_aqua, colorAlpha*alpha);
	} else if isPoisoned {
		draw_sprite_ext(asset_get_index("spr_"+spriteString+"_stagger"), 1, x, y, 1, 1, facingDirection, c_green, .5);
	}
}

// draw dodge sprite if dodging
if state == CombatantStates.Dodging {
	draw_sprite_ext(asset_get_index("spr_"+spriteString+"_dodge"),dodgeFrame,x,y,1,1,dodgeDirection,c_white,1);
	// slowed
	if isSlowed {
		var percentFrozen = ds_map_find_value(conditionPercentages,ICE);
		var colorAlpha = (3/320)*percentFrozen;
		draw_sprite_ext(asset_get_index("spr_"+spriteString+"_dodge"), dodgeFrame, x, y, 1, 1, dodgeDirection, c_aqua, colorAlpha*alpha);
	} else if isPoisoned {
		draw_sprite_ext(asset_get_index("spr_"+spriteString+"_dodge"), dodgeFrame, x, y, 1, 1, dodgeDirection, c_green, .5);
	}
	
} 

if state != CombatantStates.Dodging && state != CombatantStates.Staggering {
	// normally draw base sprite -- on top of hands
	alpha = 1;
	var scale = 1;
	var scaleFactor = 1;
	
	// fairies float
	if isFairy {
		scale = .1*cos((pi*floatingFrame)/30)+.9; // normal floating
	} 
	
	// jumping
	if jumpFrame < jumpTotalFrames {
		var percentDone = jumpFrame / jumpTotalFrames;
		scaleFactor = (-.5*abs((2*percentDone)-1))+1.5;
		scale = scale * scaleFactor;
	}
	if isDying {
		alpha = (-dyingFrame/dyingTotalFrames)+1;
	}
	
	draw_sprite_ext(asset_get_index("spr_"+spriteString), idleFrame, x, y, scale, scale, facingDirection, c_white, alpha);
	
	if isSlowed {
		var percentFrozen = ds_map_find_value(conditionPercentages,ICE);
		var colorAlpha = (3/320)*percentFrozen;
		draw_sprite_ext(asset_get_index("spr_"+spriteString), idleFrame, x, y, scale, scale, facingDirection, c_aqua, colorAlpha*alpha);
	} 
	else if isFrozen {
		draw_sprite_ext(asset_get_index("spr_"+spriteString), idleFrame, x, y, scale, scale, facingDirection, c_aqua, .75*alpha);
	} 
	
	var totalIdleFrames = sprite_get_number(asset_get_index("spr_"+spriteString));
	
	idleFrame += 1;
	idleFrame = idleFrame % totalIdleFrames;
}

if isFairy {
	floatingFrame += 1;
	floatingFrame = floatingFrame % 60;
}


