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
		
		if hasHands {
			
			var isRightHandInUse = ds_map_find_value(preparingHands,"r") != undefined || ds_map_find_value(recoveringHands,"r") != undefined || ds_map_find_value(attackingHands,"r") != undefined;
			var isLeftHandInUse = ds_map_find_value(preparingHands,"l") != undefined || ds_map_find_value(recoveringHands,"l") != undefined || ds_map_find_value(attackingHands,"l") != undefined;
			
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
		}
	}
	
}
// NEED TO OVERRIDE THIS FOR PLAYER -- SPRITESTRING NEEDS TO BE DIFFERENT BASED ON PLAYER EQUIPPED ITEMS
if state == CombatantStates.Attacking {
	
	if spriteType != "player" {
		var attackNumber = currentMeleeAttack == noone ? currentRangedAttack : currentMeleeAttack;
		
		// draw attack prep hand animation
		if ds_map_size(preparingHands) != 0 {
			if attackNumberInChain == noone {
				attackNumberInChain = 1;
			}
			var hand = ds_map_find_first(preparingHands); // l or r
			
			for (var i = 0; i < ds_map_size(preparingHands); i++) {
				var attackInChain = ds_map_find_value(preparingHands,hand);
				var attackData = noone;
				if currentMeleeAttack {
					var attackChain = meleeAttacks[attackNumber-1];
					attackData = attackChain[attackInChain-1];
				} else {
					var attackChain = rangedAttacks[attackNumber-1];
					attackData = attackChain[attackInChain-1];
				}
			
				var prepSprite = asset_get_index(attackData.spriteName+"_prep_"+string(attackData.spriteAttackNumber)+"_"+string(attackData.spriteAttackNumberInChain));
				var frame = ds_map_find_value(prepFrames,hand);
				if hand == "r" {
					draw_sprite_ext(prepSprite,frame,x,y,scale,scale,facingDirection,c_white,1);
					if isSlowed {
						draw_sprite_ext(prepSprite, frame, x, y, scale, scale, facingDirection, c_aqua, .5);
					} 
					else if isFrozen {
						draw_sprite_ext(prepSprite, frame, x, y, scale, scale, facingDirection, c_aqua, .75);
					}
				} else {
					if isSlowed {
						draw_sprite_ext(prepSprite, frame, x, y, scale, -scale, facingDirection, c_aqua, .5);
					} 
					else if isFrozen {
						draw_sprite_ext(prepSprite, frame, x, y, scale, -scale, facingDirection, c_aqua, .75);
					}
					draw_sprite_ext(prepSprite,frame,x,y,scale,-scale,facingDirection,c_white,1);
				}
			
				if isSlowed {
					var percentSpeed = functionalSpeed / normalSpeed;
					var currentVal = ds_map_find_value(prepFrames,hand);
					ds_map_replace(prepFrames,hand,currentVal+percentSpeed);

				} else {
					var currentVal = ds_map_find_value(prepFrames,hand);
					ds_map_replace(prepFrames,hand,currentVal+1);
				}
				
				hand = ds_map_find_next(preparingHands, hand);
			}
		}
	
		// draw recover hand animation
		if ds_map_size(recoveringHands) != 0 {
			var hand = ds_map_find_first(recoveringHands); // l or r
			
			for (var i = 0; i < ds_map_size(recoveringHands); i++) {
				var attackInChain = ds_map_find_value(recoveringHands,hand);
				var attackData = noone;
				if currentMeleeAttack {
					var attackChain = meleeAttacks[attackNumber-1];
					attackData = attackChain[attackInChain-1];
				} else {
					var attackChain = rangedAttacks[attackNumber-1];
					attackData = attackChain[attackInChain-1];
				}
			
				var recoverSprite = asset_get_index(attackData.spriteName+"_recover_"+string(attackData.spriteAttackNumber)+"_"+string(attackData.spriteAttackNumberInChain));
				var frame = ds_map_find_value(recoverFrames,hand);
				if hand == "r" { 
					draw_sprite_ext(recoverSprite,frame,x,y,scale,scale,facingDirection,c_white,1);
					if isSlowed {
						draw_sprite_ext(recoverSprite, frame, x, y, scale, scale, facingDirection, c_aqua, .5);
					} 
					else if isFrozen {
						draw_sprite_ext(recoverSprite, frame, x, y, scale, scale, facingDirection, c_aqua, .75);
					}
				} else {
					if isSlowed {
						draw_sprite_ext(recoverSprite, frame, x, y, scale, -scale, facingDirection, c_aqua, .5);
					} 
					else if isFrozen {
						draw_sprite_ext(recoverSprite, frame, x, y, scale, -scale, facingDirection, c_aqua, .75);
					}
					draw_sprite_ext(recoverSprite,frame,x,y,scale,-scale,facingDirection,c_white,1);
				}
			
				if isSlowed {
					var percentSpeed = functionalSpeed / normalSpeed;
					var currentVal = ds_map_find_value(recoverFrames,hand);
					ds_map_replace(recoverFrames,hand,currentVal+percentSpeed);

				} else {
					var currentVal = ds_map_find_value(recoverFrames,hand);
					ds_map_replace(recoverFrames,hand,currentVal+1);
				}
				
				hand = ds_map_find_next(recoveringHands,hand);
			}
		}
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


