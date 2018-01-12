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
	
	// normally draw base sprite + hands (if applicable) 
	draw_sprite_ext(asset_get_index("spr_"+spriteString), 1, x, y, 1, 1, facingDirection, c_white, 1);
	
	if isSlowed {
		draw_sprite_ext(asset_get_index("spr_"+spriteString), 1, x, y, 1, 1, facingDirection, c_aqua, .5);
	} 
	else if isFrozen {
		draw_sprite_ext(asset_get_index("spr_"+spriteString), 1, x, y, 1, 1, facingDirection, c_aqua, .75);
	} 
	
	if type != CombatantTypes.Player {
		
		if hasHands {
			
			//var d = ds_list_find_value(preparingHands,"r");
			var isRightHandInUse = ds_map_find_value(preparingHands,"r") != undefined || ds_map_find_value(recoveringHands,"r") != undefined || ds_map_find_value(attackingHands,"r") != undefined;
			var isLeftHandInUse = ds_map_find_value(preparingHands,"l") != undefined || ds_map_find_value(recoveringHands,"l") != undefined || ds_map_find_value(attackingHands,"l") != undefined;
			
			// two handed items always go in right hand
			if !rightHandItem.isTwoHanded {
				// right hand
				if !isRightHandInUse {
					draw_sprite_ext(asset_get_index("spr_"+spriteString+"_"+rightHandItem.spriteName),1,x,y,1,1,facingDirection,c_white,1);
				}
				// left hand -- only left hands can hold shields. 
				//if isShielding is true, a block object will be created in front of the combatant
				if (!isLeftHandInUse && !isShielding) {
					draw_sprite_ext(asset_get_index("spr_"+spriteString+"_"+leftHandItem.spriteName),1,x,y,1,-1,facingDirection,c_white,1);
				}
			} else {
				// right hand -- sprite should include both hands
				if !isRightHandInUse {
					draw_sprite_ext(asset_get_index("spr_"+spriteString+"_"+rightHandItem.spriteName),1,x,y,1,1,facingDirection,c_white,1);
				}
			}
		}
	}
}
// NEED TO OVERRIDE THIS FOR PLAYER -- SPRITESTRING NEEDS TO BE DIFFERENT BASED ON PLAYER EQUIPPED ITEMS
if state == CombatantStates.Attacking {
	
	if spriteType != "player" {
		var attackNumber = currentMeleeAttack == noone ? currentRangedAttack : currentMeleeAttack;
		/*if hasHands {
			var currentAttackingHandItemSprite = currentAttackingHand == "l" ? "_"+leftHandItem.spriteName : "_"+rightHandItem.spriteName;
		} else var currentAttackingHandItemSprite = "";*/
		
		// draw attack prep hand animation
		if ds_map_size(preparingHands) != 0 {
			if attackNumberInChain == noone {
				attackNumberInChain = 1;
			}
			var hand = ds_map_find_first(preparingHands); // l or r
			for (var i = 0; i < ds_map_size(preparingHands); i++) {
				
				//var hand = ds_list_find_value(preparingHands,i); // l or r
				var prepHandItemSprite = hand == "l" ? "_" + leftHandItem.spriteName : "_"+rightHandItem.spriteName;
			
				var prepSprite = asset_get_index("spr_"+spriteString+prepHandItemSprite+"_prep_"+string(attackNumber)+"_"+string(attackNumberInChain));
				var frame = ds_map_find_value(prepFrames,hand);
				if hand == "r" {
					draw_sprite_ext(prepSprite,frame,x,y,1,1,facingDirection,c_white,1);
				} else {
					draw_sprite_ext(prepSprite,frame,x,y,1,-1,facingDirection,c_white,1);
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
		
		//if isPreparingAttack && prepAnimationFrame < prepAnimationTotalFrames {
		/*if ds_list_size(preparingHands) != 0 {
			var isLeftHandPreparing = ds_list_find_value(preparingHands,"l");
			var isRightHandPreparing = ds_list_find_value(preparingHands,"r");
			
			var attackNumber = currentMeleeAttack == noone ? currentRangedAttack : currentMeleeAttack;
			if attackNumberInChain == noone {
				attackNumberInChain = 1; // ??? -- BANDAID, need to improve
			}
			
			var prepSprite = asset_get_index("spr_"+spriteString+currentAttackingHandItemSprite+"_prep_"+string(attackNumber)+"_"+string(attackNumberInChain));
			
			// right hand 
			//if (currentAttackingHand == "r") {
			if isRightHandPreparing {
				var frame = ds_map_find_value(prepFrames,"r");
				draw_sprite_ext(prepSprite,frame,x,y,1,1,facingDirection,c_white,1);
			}
			// left hand
			else if isLeftHandPreparing {
				var frame = ds_map_find_value(prepFrames,"l");
				draw_sprite_ext(prepSprite,frame,x,y,1,-1,facingDirection,c_white,1);
			}
			if isSlowed {
				var percentSpeed = functionalSpeed / normalSpeed;
				if isRightHandPreparing {
					var currentVal = ds_map_find_value(prepFrames,"r");
					ds_map_replace(prepFrames,"r",currentVal+percentSpeed);
				} else {
					var currentVal = ds_map_find_value(prepFrames,"l");
					ds_map_replace(prepFrames,"l",currentVal+percentSpeed);
				}
				//prepAnimationFrame += percentSpeed;
			} else {
				
				if isRightHandPreparing {
					var currentVal = ds_map_find_value(prepFrames,"r");
					ds_map_replace(prepFrames,"r",currentVal+1);
				} else {
					var currentVal = ds_map_find_value(prepFrames,"l");
					ds_map_replace(prepFrames,"l",currentVal+1);
				}
				
				//prepAnimationFrame++;
			}
		}*/
		
		// draw recover prep hand animation
		if ds_map_size(recoveringHands) != 0 {
			var hand = ds_map_find_first(recoveringHands); // l or r
			for (var i = 0; i < ds_map_size(recoveringHands); i++) {
				//var hand = ds_list_find_value(recoveringHands,i); // l or r
				var recoverHandItemSprite = hand == "l" ? "_" + leftHandItem.spriteName : "_"+rightHandItem.spriteName;
			
				var recoverSprite = asset_get_index("spr_"+spriteString+recoverHandItemSprite+"_recover_"+string(attackNumber)+"_"+string(attackNumberInChain));
				var frame = ds_map_find_value(recoverFrames,hand);
				if hand == "r" {
					draw_sprite_ext(recoverSprite,frame,x,y,1,1,facingDirection,c_white,1);
				} else {
					draw_sprite_ext(recoverSprite,frame,x,y,1,-1,facingDirection,c_white,1);
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
	
		// draw recover hand animation
		//if isRecovering && recoverAnimationFrame < recoverAnimationTotalFrames {
		/*if ds_list_size(recoveringHands) != 0 {
			var isLeftHandRecovering = ds_list_find_value(recoveringHands,"l");
			var isRightHandRecovering = ds_list_find_value(recoveringHands,"r");
		
			var attackNumber = currentMeleeAttack == noone ? currentRangedAttack : currentMeleeAttack;
			var recoverSprite = asset_get_index("spr_"+spriteString+currentAttackingHandItemSprite+"_recover_"+string(attackNumber)+"_"+string(attackNumberInChain));
			// right hand 
			//if (currentAttackingHand == "r") {
			if isRightHandRecovering {
				var frame = ds_map_find_value(recoverFrames,"r");
				draw_sprite_ext(recoverSprite,frame,x,y,1,1,facingDirection,c_white,1);
			}
			// left hand
			else if isLeftHandRecovering {
				var frame = ds_map_find_value(recoverFrames,"l");
				draw_sprite_ext(recoverSprite,frame,x,y,1,-1,facingDirection,c_white,1);
			}
			if isSlowed {
				var percentSpeed = functionalSpeed / normalSpeed;
				if isRightHandRecovering {
					var currentVal = ds_map_find_value(recoverFrames,"r");
					ds_map_replace(recoverFrames,"r",currentVal+percentSpeed);
				} else {
					var currentVal = ds_map_find_value(recoverFrames,"l");
					ds_map_replace(recoverFrames,"l",currentVal+percentSpeed);
				}
				//recoverAnimationFrame += percentSpeed;
			} else {
				
				if isRightHandRecovering {
					var currentVal = ds_map_find_value(recoverFrames,"r");
					ds_map_replace(recoverFrames,"r",currentVal+1);
				} else {
					var currentVal = ds_map_find_value(recoverFrames,"l");
					ds_map_replace(recoverFrames,"l",currentVal+1);
				}
				
				//recoverAnimationFrame++;
			}
		}*/
	}
}

if state == CombatantStates.Staggering {
	var staggerSprite = asset_get_index("spr_staggering");
	var staggerSpriteFrames = sprite_get_number(staggerSprite);
	//draw_sprite(staggerSprite,staggerFrame%staggerSpriteFrames,mean(x-.5*sprite_width,x+.5*sprite_width),y-.5*sprite_height);
	draw_sprite(staggerSprite,staggerFrame%staggerSpriteFrames,x,y);
}



