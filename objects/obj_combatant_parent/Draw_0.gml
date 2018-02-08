//draw_path(path,x,y,true);

// draw stagger sprite if staggering
if state == CombatantStates.Staggering {
	draw_sprite_ext(asset_get_index("spr_"+spriteString+"_stagger"),1,x,y,1,1,facingDirection,c_white,1);
	// slowed
	if isSlowed {
		draw_sprite_ext(asset_get_index("spr_"+spriteString+"_stagger"), 1, x, y, 1, 1, facingDirection, c_aqua, .5);
	} else if isPoisoned {
		draw_sprite_ext(asset_get_index("spr_"+spriteString+"_stagger"), 1, x, y, 1, 1, facingDirection, c_green, .5);
	}
}
var scale = 1;
var scaleFactor = 1;
// jumping
if jumpFrame < jumpTotalFrames {
	var percentDone = jumpFrame / jumpTotalFrames;
	scaleFactor = (-.5*abs((2*percentDone)-1))+1.5;
	scale = scale * scaleFactor;
}
// draw dodge sprite if dodging
if state == CombatantStates.Dodging {
	draw_sprite_ext(asset_get_index("spr_"+spriteString+"_dodge"),dodgeFrame,x,y,1,1,dodgeDirection,c_white,1);
	// slowed
	if isSlowed {
		draw_sprite_ext(asset_get_index("spr_"+spriteString+"_dodge"), dodgeFrame, x, y, 1, 1, dodgeDirection, c_aqua, .5);
	} else if isPoisoned {
		draw_sprite_ext(asset_get_index("spr_"+spriteString+"_dodge"), dodgeFrame, x, y, 1, 1, dodgeDirection, c_green, .5);
	}
	
} else {
	
	if type != CombatantTypes.Player {
		
		/*if hasHands {
			
			var isRightHandInUse = ds_map_find_value(preparingLimbs,"r") != undefined || ds_map_find_value(recoveringLimbs,"r") != undefined || ds_map_find_value(attackingLimbs,"r") != undefined;
			var isLeftHandInUse = ds_map_find_value(preparingLimbs,"l") != undefined || ds_map_find_value(recoveringLimbs,"l") != undefined || ds_map_find_value(attackingLimbs,"l") != undefined;
			
			// two handed items always go in right hand
			if !rightHandItem.isTwoHanded {
				// right hand
				if !isRightHandInUse {
					draw_sprite_ext(asset_get_index("spr_"+spriteString+"_"+rightHandItem.spriteName),1,x,y,scale,scale,facingDirection,c_white,1);
				}
				// left hand -- only left hands can hold shields. 
				//if isShielding is true, a block object will be created in front of the combatant
				if (!isLeftHandInUse && !isShielding) {
					draw_sprite_ext(asset_get_index("spr_"+spriteString+"_"+leftHandItem.spriteName),1,x,y,scale,-scale,facingDirection,c_white,1);
				}
			} else {
				// right hand -- sprite should include both hands
				if !isRightHandInUse {
					draw_sprite_ext(asset_get_index("spr_"+spriteString+"_"+rightHandItem.spriteName),1,x,y,scale,scale,facingDirection,c_white,1);
				}
			}
		}*/
	}
	
}

if state != CombatantStates.Dodging && state != CombatantStates.Staggering {
	// normally draw base sprite -- on top of hands
	
	var alpha = 1;
	
	// fairies float
	if isFairy {
		if isPhasing alpha = .5;
		scale = .1*cos((pi*floatingFrame)/30)+.9; // normal floating
	} 
	
	draw_sprite_ext(asset_get_index("spr_"+spriteString), idleFrame, x, y, scale, scale, facingDirection, c_white, alpha);
	
	if isSlowed {
		draw_sprite_ext(asset_get_index("spr_"+spriteString), idleFrame, x, y, 1, 1, facingDirection, c_aqua, .5);
	} 
	else if isFrozen {
		draw_sprite_ext(asset_get_index("spr_"+spriteString), idleFrame, x, y, 1, 1, facingDirection, c_aqua, .75);
	} 
	
	var totalIdleFrames = sprite_get_number(asset_get_index("spr_"+spriteString));
	
	idleFrame += 1;
	idleFrame = idleFrame % totalIdleFrames;
}

if isFairy {
	floatingFrame += 1;
	floatingFrame = floatingFrame % 60;
}


