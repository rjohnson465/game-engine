event_inherited();

var leftHandItem = ds_map_find_value(equippedLimbItems,"l");
var rightHandItem = ds_map_find_value(equippedLimbItems,"r");

// draw dodge sprite if dodging
/*if state == CombatantStates.Dodging {
	//draw_sprite_ext(asset_get_index("spr_player_dodge"),dodgeFrame,x,y,1,1,dodgeDirection,c_white,1);
} else */ {
	
	var isRightHandInUse = ds_map_find_value(preparingLimbs,"r") != undefined || ds_map_find_value(recoveringLimbs,"r") != undefined || ds_map_find_value(attackingLimbs,"r") != undefined;
	var isLeftHandInUse = ds_map_find_value(preparingLimbs,"l") != undefined || ds_map_find_value(recoveringLimbs,"l") != undefined || ds_map_find_value(attackingLimbs,"l") != undefined;
	
	// two handed items always go in right hand
	/*if !rightHandItem.isTwoHanded {
		// right hand
		if (!isRightHandInUse && currentUsingSpell == noone) {
			draw_sprite_ext(asset_get_index("spr_"+spriteString+"_"+rightHandItem.spriteName),1,x,y,1,1,facingDirection,c_white,1);
		}
		// left hand -- only left hands can hold shields. 
		//if isShielding is true, a block object will be created in front of the combatant
		if (!isLeftHandInUse && !isShielding && currentUsingSpell == noone) {
			draw_sprite_ext(asset_get_index("spr_"+spriteString+"_"+leftHandItem.spriteName),1,x,y,1,-1,facingDirection,c_white,1);
		}
	} else {
		// right hand
		if (!isRightHandInUse && currentUsingSpell == noone) {
			draw_sprite_ext(asset_get_index("spr_"+spriteString+"_"+rightHandItem.spriteName),1,x,y,1,1,facingDirection,c_white,1);
		}
	}*/
}

if state == CombatantStates.Attacking {
	
	// martial spell
	if currentUsingSpell != noone {
		var spellHandPrepSprite = asset_get_index("spr_player_spellprep");
		var spellPrepHandSpriteTotalFrames = sprite_get_number(spellHandPrepSprite);
		
		//if isPreparingAttack && prepAnimationFrame < prepAnimationTotalFrames {
		if ds_map_find_value(prepFrames,"r") < ds_map_find_value(prepFrameTotals,"r") {
			var prepFrame = ds_map_find_value(prepFrames,"r");
			var frame = prepFrame%spellPrepHandSpriteTotalFrames;
			// right hand ?
			draw_sprite_ext(spellHandPrepSprite,frame,x,y,1,1,facingDirection+75,c_white,1);
			// left hand
			draw_sprite_ext(spellHandPrepSprite,frame,x,y,1,-1,facingDirection-75,c_white,1);
			
			ds_map_replace(prepFrames,"r",prepFrame+1);
			//prepAnimationFrame++;
		}
	}
	// physical attack (ranged or melee) TODO -- consolidate with obj_combatant
	else {
		
		// draw attack prep hand animation
		if ds_map_size(preparingLimbs) != 0 {
			var hand = ds_map_find_first(preparingLimbs); // l or r
			
			for (var i = 0; i < ds_map_size(preparingLimbs); i++) {
				var attackInChain = ds_map_find_value(preparingLimbs,hand);
				if attackInChain == 2 {
					var a = 3;
				}
				//var hand = ds_list_find_value(preparingLimbs,i); // l or r
				var prepHandItemSprite = hand == "l" ? "_" + leftHandItem.spriteName : "_"+rightHandItem.spriteName;
			
				var prepSprite = asset_get_index("spr_"+spriteString+prepHandItemSprite+"_prep_"+string(attackInChain));
				var frame = ds_map_find_value(prepFrames,hand);
				if hand == "r" {
					//draw_sprite_ext(prepSprite,frame,x,y,1,1,facingDirection,c_white,1);
				} else {
					//draw_sprite_ext(prepSprite,frame,x,y,1,-1,facingDirection,c_white,1);
				}
			
				if isSlowed {
					var percentSpeed = functionalSpeed / normalSpeed;
					var currentVal = ds_map_find_value(prepFrames,hand);
					ds_map_replace(prepFrames,hand,currentVal+percentSpeed);

				} else {
					var currentVal = ds_map_find_value(prepFrames,hand);
					ds_map_replace(prepFrames,hand,currentVal+1);
				}
				
				hand = ds_map_find_next(preparingLimbs, hand);
			}
		}
		
		// draw recover prep hand animation
		if ds_map_size(recoveringLimbs) != 0 {
			var hand = ds_map_find_first(recoveringLimbs); // l or r			
			for (var i = 0; i < ds_map_size(recoveringLimbs); i++) {
				var attackInChain = ds_map_find_value(recoveringLimbs,hand);
				
				var recoverHandItemSprite = hand == "l" ? "_" + leftHandItem.spriteName : "_"+rightHandItem.spriteName;
			
				var recoverSprite = asset_get_index("spr_"+spriteString+recoverHandItemSprite+"_recover_"+string(attackInChain));
				var frame = ds_map_find_value(recoverFrames,hand);
				if hand == "r" {
					//draw_sprite_ext(recoverSprite,frame,x,y,1,1,facingDirection,c_white,1);
				} else {
					//draw_sprite_ext(recoverSprite,frame,x,y,1,-1,facingDirection,c_white,1);
				}
			
				if isSlowed {
					var percentSpeed = functionalSpeed / normalSpeed;
					var currentVal = ds_map_find_value(recoverFrames,hand);
					ds_map_replace(recoverFrames,hand,currentVal+percentSpeed);

				} else {
					var currentVal = ds_map_find_value(recoverFrames,hand);
					ds_map_replace(recoverFrames,hand,currentVal+1);
				}
				
				hand = ds_map_find_next(recoveringLimbs,hand);
			}
		}
	}
}

// casting a spell
if ds_map_size(preparingLimbs) != 0 && currentUsingSpell != noone {
	// spell bar outline
	var x1 = x-(.75*sprite_width);
	var y1 = y-(.5*sprite_height)-15;
	var x2 = x+(.75*sprite_width);
	var y2 = y-(.5*sprite_height)-5;
	var prepFrame = ds_map_find_value(prepFrames,"r");
	var prepFrameTotal = ds_map_find_value(prepFrameTotals,"r");
	var percentDone = prepFrame / prepFrameTotal;
	draw_healthbar(x1,y1,x2,y2,percentDone*100,c_black,c_ltgray,c_aqua,0,true,true);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_font(font_damage);
	var spell = ds_map_find_value(knownSpells,currentUsingSpell);
	scr_draw_text_outline(mean(x1,x2),y1-4,spell.name,c_white,c_ltgray,1,1,0);
}


