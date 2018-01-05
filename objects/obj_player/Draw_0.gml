event_inherited();
// draw dodge sprite if dodging
if state == CombatantStates.Dodging {
	draw_sprite_ext(asset_get_index("spr_player_dodge"),dodgeFrame,x,y,1,1,dodgeDirection,c_white,1);
} else {
	// draw base player sprite if not dodging
	draw_sprite_ext(spr_player, 1, x, y, 1, 1, facingDirection, c_white, 1);
	
	// two handed items always go in right hand
	if !rightHandItem.isTwoHanded {
		// right hand
		if (currentAttackingHand != "r" && currentUsingSpell == noone) {
			draw_sprite_ext(asset_get_index("spr_"+spriteString+"_"+rightHandItem.spriteName),1,x,y,1,1,facingDirection,c_white,1);
		}
		// left hand -- only left hands can hold shields. 
		//if isShielding is true, a block object will be created in front of the combatant
		if (currentAttackingHand != "l" && !isShielding && currentUsingSpell == noone) {
			draw_sprite_ext(asset_get_index("spr_"+spriteString+"_"+leftHandItem.spriteName),1,x,y,1,-1,facingDirection,c_white,1);
		}
	} else {
		// right hand
		if (currentAttackingHand != "r" && currentUsingSpell == noone) {
			draw_sprite_ext(asset_get_index("spr_"+spriteString+"_"+rightHandItem.spriteName),1,x,y,1,1,facingDirection,c_white,1);
		}
	}
}

if state == CombatantStates.Attacking {
	
	// martial spell
	if currentUsingSpell != noone {
		var spellHandPrepSprite = asset_get_index("spr_player_spellprep");
		var spellPrepHandSpriteTotalFrames = sprite_get_number(spellHandPrepSprite);
		if isPreparingAttack && prepAnimationFrame < prepAnimationTotalFrames {
			var frame = prepAnimationFrame%spellPrepHandSpriteTotalFrames;
			// right hand ?
			draw_sprite_ext(spellHandPrepSprite,frame,x,y,1,1,facingDirection+75,c_white,1);
			// left hand
			draw_sprite_ext(spellHandPrepSprite,frame,x,y,1,-1,facingDirection-75,c_white,1);
			prepAnimationFrame++;
		}
	}
	// physical attack (ranged or melee)
	else {
	
		
		var currentAttackingHandItem = currentAttackingHand == "l" ? leftHandItem.spriteName : rightHandItem.spriteName;
		var currentAttackingHandItemSpriteString = "spr_player_"+currentAttackingHandItem;
	
		// draw attack prep hand animation
		if isPreparingAttack && prepAnimationFrame < prepAnimationTotalFrames {
			var attackNumber = global.playerAttackNumberInChain;
			var prepSprite = asset_get_index(currentAttackingHandItemSpriteString+"_prep_"+string(attackNumber));
			// right hand 
			if (currentAttackingHand == "r") {
				draw_sprite_ext(prepSprite,prepAnimationFrame,x,y,1,1,facingDirection,c_white,1);
			}
			// left hand
			else {
				draw_sprite_ext(prepSprite,prepAnimationFrame,x,y,1,-1,facingDirection,c_white,1);
			}
			if !isReadyToFire {
				prepAnimationFrame++;
			}
		}
	
		// draw recover hand animation
		if isRecovering && recoverAnimationFrame < recoverAnimationTotalFrames {
		
			var attackNumber = global.playerAttackNumberInChain;
			var recoverSprite = asset_get_index(currentAttackingHandItemSpriteString+"_recover_"+string(attackNumber));
			// right hand 
			if (currentAttackingHand == "r") {
				draw_sprite_ext(recoverSprite,recoverAnimationFrame,x,y,1,1,facingDirection,c_white,1);
			}
			// left hand
			else{
				draw_sprite_ext(recoverSprite,recoverAnimationFrame,x,y,1,-1,facingDirection,c_white,1);
			}
			recoverAnimationFrame++;
		}
	}
}

// casting a spell
if isPreparingAttack && currentUsingSpell != noone {
	// total stamina bar outline
	var x1 = x-(.5*sprite_width);
	var y1 = y-(.5*sprite_height)-15;
	var x2 = x+(.5*sprite_width);
	var y2 = y-(.5*sprite_height)-5;
	draw_set_color(c_white);
	draw_rectangle(x1,y1,x2,y2,true);
	// current stamina
	var percentDone = prepAnimationFrame / prepAnimationTotalFrames;
	var x2 = x1 + (sprite_width * percentDone)
	if (x2 < x1) x2 = x1;
	draw_set_color(c_olive);
	draw_rectangle(
		x1,
		y1,
		x2,
		y2,
		false);
	var x1 = x-(.5*sprite_width);
	var y1 = y-(.5*sprite_height)-15;
	var x2 = x+(.5*sprite_width);
	var y2 = y-(.5*sprite_height)-5;
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_font(font_main);
	var spell = ds_map_find_value(knownSpells,currentUsingSpell);
	draw_text(mean(x1,x2),y1-2,spell.name);
}

// lock on target
if (isLockedOn && lockOnTarget != noone) {
	draw_sprite(spr_lockon,1,lockOnTarget.x, lockOnTarget.y);
}


