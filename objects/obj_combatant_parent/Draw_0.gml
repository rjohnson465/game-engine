updateIsMoving();
if !isBeingHit {
	prepareLayerShader();
} else {
	
	shader_set(sh_red);
	var uPOSITION = shader_get_uniform(sh_red, "Position");
	var amt = alarm[5]/5;
	shader_set_uniform_f(uPOSITION,amt);
}
var isAttackingWithCore = type != CombatantTypes.Player && state == CombatantStates.Attacking && attackData != noone && attackData.limbKey == noone;
// draw stagger sprite if staggering
if state == CombatantStates.Staggering {
	if isDying {
		isSlowed = false; isFrozen = false;
		alpha = (-dyingFrame/dyingTotalFrames)+1;
	}
	draw_sprite_ext(asset_get_index("spr_"+spriteString+"_stagger"),1,x,y,scale,scale,facingDirection,c_white,alpha);
	// slowed
	if isSlowed || isFrozen {
		var percentFrozen = ds_map_find_value(conditionPercentages,ICE);
		var colorAlpha = (3/320)*percentFrozen;
		draw_sprite_ext(asset_get_index("spr_"+spriteString+"_stagger"), 1, x, y, scale, scale, facingDirection, c_aqua, .5*alpha);
	} else if isPoisoned {
		var percentPoisoned = ds_map_find_value(conditionPercentages,POISON);
		var colorAlpha = (3/320)*percentPoisoned;
		draw_sprite_ext(asset_get_index("spr_"+spriteString+"_stagger"), 1, x, y, scale, scale, facingDirection, c_green, .5*alpha);
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
		draw_sprite_ext(asset_get_index("spr_"+spriteString+"_dodge"), dodgeFrame, x, y, 1, 1, dodgeDirection, c_aqua, .5*a);
	} else if isPoisoned {
		var percentPoisoned = ds_map_find_value(conditionPercentages,POISON);
		var colorAlpha = (3/320)*percentPoisoned;
		draw_sprite_ext(asset_get_index("spr_"+spriteString+"_dodge"), dodgeFrame, x, y, 1, 1, dodgeDirection, c_green, .5*a);
	}
	
} 

// attacks that come from the core body are drawn here 
if isAttackingWithCore {
	var attackSpriteName = attackData.spriteName;
	var attackNumber = attackData.spriteAttackNumber; var attackNumberInChain = attackData.spriteAttackNumberInChain;
	var spr = noone;
	var frame = -4;
	if ds_map_size(preparingLimbs) > 0 {
		var frame = ds_map_find_value(prepFrames,noone);
		spr = asset_get_index(attackSpriteName+"_prep_"+string(attackNumber)+"_"+string(attackNumberInChain));
	}
	else if ds_map_size(attackingLimbs) > 0 {
		var frame = ds_map_find_value(attackFrames,noone);
		spr = asset_get_index(attackSpriteName+"_attack_"+string(attackNumber)+"_"+string(attackNumberInChain));
	}
	else if ds_map_size(recoveringLimbs) > 0 {
		var frame = ds_map_find_value(recoverFrames,noone);
		spr = asset_get_index(attackSpriteName+"_recover_"+string(attackNumber)+"_"+string(attackNumberInChain));
	}
	if spr == noone {
		spr = asset_get_index(attackSpriteName+"_prep_"+string(attackNumber)+"_"+string(attackNumberInChain));
		frame = 0;
	}
	if spr != noone && frame >= 0 {
		draw_sprite_ext(spr,frame,x,y,1,1,facingDirection,c_white,1);
	}
}

if state != CombatantStates.Dodging && state != CombatantStates.Staggering && !isAttackingWithCore {
	
	updateMoveSpriteAndImageSpeed();
	
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
	
	draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, facingDirection, c_white, alpha);
	
	if isSlowed {
		var percentFrozen = ds_map_find_value(conditionPercentages,ICE);
		var colorAlpha = (3/320)*percentFrozen;
		draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, facingDirection, c_aqua, .5*alpha);
	} 
	else if isFrozen {
		draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, facingDirection, c_aqua, .75*alpha);
	} 
	else if isPoisoned {
		var percentPoisoned = ds_map_find_value(conditionPercentages,POISON);
		var colorAlpha = (3/320)*percentPoisoned;
		draw_sprite_ext(sprite_index, image_index, x, y, scale, scale, facingDirection, c_aqua, .5*alpha);
	}
	
	
	var totalIdleFrames = sprite_get_number(asset_get_index("spr_"+spriteString));
	
	idleFrame += 1;
	idleFrame = idleFrame % totalIdleFrames;

}

if isFairy {
	floatingFrame += 1;
	floatingFrame = floatingFrame % 60;
}

with obj_light_radius {
	if owner == other.id {
		light_set_scale(other.lightRadiusScale*other.scale);
	}
}

shader_reset();
