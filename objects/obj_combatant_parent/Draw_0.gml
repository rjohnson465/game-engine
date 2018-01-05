// draw dodge sprite if dodging
if state == CombatantStates.Dodging {
	draw_sprite_ext(asset_get_index("spr_"+spriteString+"_dodge"),dodgeFrame,x,y,1,1,dodgeDirection,c_white,1);
} else {
	if type != CombatantTypes.Player {
		// normally draw base sprite + hands (if applicable) 
		draw_sprite_ext(asset_get_index("spr_"+spriteString), 1, x, y, 1, 1, facingDirection, c_white, 1);
	
		if hasHands {
			
			// two handed items always go in right hand
			if !rightHandItem.isTwoHanded {
				// right hand
				if (currentAttackingHand != "r") {
					draw_sprite_ext(asset_get_index("spr_"+spriteString+"_"+rightHandItem.spriteName),1,x,y,1,1,facingDirection,c_white,1);
				}
				// left hand -- only left hands can hold shields. 
				//if isShielding is true, a block object will be created in front of the combatant
				if (currentAttackingHand != "l" && !isShielding) {
					draw_sprite_ext(asset_get_index("spr_"+spriteString+"_"+leftHandItem.spriteName),1,x,y,1,-1,facingDirection,c_white,1);
				}
			} else {
				// right hand -- sprite should include both hands
				if (currentAttackingHand != "r") {
					draw_sprite_ext(asset_get_index("spr_"+spriteString+"_"+rightHandItem.spriteName),1,x,y,1,1,facingDirection,c_white,1);
				}
			}
		}
	}
}
// NEED TO OVERRIDE THIS FOR PLAYER -- SPRITESTRING NEEDS TO BE DIFFERENT BASED ON PLAYER EQUIPPED ITEMS
if state == CombatantStates.Attacking {
	
	if spriteType != "player" {
		
		if hasHands {
			var currentAttackingHandItemSprite = currentAttackingHand == "l" ? "_"+leftHandItem.spriteName : "_"+rightHandItem.spriteName;
		} else var currentAttackingHandItemSprite = "";
		
		// draw attack prep hand animation
		if isPreparingAttack && prepAnimationFrame < prepAnimationTotalFrames {
			var attackNumber = currentMeleeAttack == noone ? currentRangedAttack : currentMeleeAttack;
			// TODO -- sometimes this returns -1 -- My guess is attackNumberInChain is still noone. Please fix
			if attackNumberInChain == noone {
				attackNumberInChain = 1; // ??? -- BANDAID, need to improve
			}
			show_debug_message(attackNumberInChain);
			var prepSprite = asset_get_index("spr_"+spriteString+currentAttackingHandItemSprite+"_prep_"+string(attackNumber)+"_"+string(attackNumberInChain));
			// right hand 
			if (currentAttackingHand == "r") {
				draw_sprite_ext(prepSprite,prepAnimationFrame,x,y,1,1,facingDirection,c_white,1);
			}
			// left hand
			else {
				draw_sprite_ext(prepSprite,prepAnimationFrame,x,y,1,-1,facingDirection,c_white,1);
			}
			prepAnimationFrame++;
		}
	
		// draw recover hand animation
		if isRecovering && recoverAnimationFrame < recoverAnimationTotalFrames {
		
			var attackNumber = currentMeleeAttack == noone ? currentRangedAttack : currentMeleeAttack;
			var recoverSprite = asset_get_index("spr_"+spriteString+currentAttackingHandItemSprite+"_recover_"+string(attackNumber)+"_"+string(attackNumberInChain));
			// right hand 
			if (currentAttackingHand == "r") {
				draw_sprite_ext(recoverSprite,recoverAnimationFrame,x,y,1,1,facingDirection,c_white,1);
			}
			// left hand
			else {
				draw_sprite_ext(recoverSprite,recoverAnimationFrame,x,y,1,-1,facingDirection,c_white,1);
			}
			recoverAnimationFrame++;
		}
	}
}

if state == CombatantStates.Staggering {
	var staggerSprite = asset_get_index("spr_staggering");
	var staggerSpriteFrames = sprite_get_number(staggerSprite);
	draw_sprite(staggerSprite,staggerFrame%staggerSpriteFrames,mean(x-.5*sprite_width,x+.5*sprite_width),y-.5*sprite_height);
}



