if room == game_menu {
	exit;
}event_inherited();
if !isAlive exit;
var mainHandItem = ds_map_find_value(equippedLimbItems,"r");
var offHandItem = ds_map_find_value(equippedLimbItems,"l");

if state == CombatantStates.Attacking {
	
	// martial spell
	if currentUsingSpell != noone {
	}
	// physical attack (ranged or melee) TODO -- consolidate with obj_combatant
	else {
		
		// draw attack prep hand animation
		if ds_map_size(preparingLimbs) != 0 {
			var hand = ds_map_find_first(preparingLimbs); // l or r
			
			for (var i = 0; i < ds_map_size(preparingLimbs); i++) {
				var attackInChain = ds_map_find_value(preparingLimbs,hand);
				//var hand = ds_list_find_value(preparingLimbs,i); // l or r
				var prepHandItemSprite = hand == "l" ? "_" + offHandItem.spriteName : "_"+mainHandItem.spriteName;
				
				
				var prepSprite = asset_get_index("spr_"+spriteString+prepHandItemSprite+"_prep_"+string(attackInChain));
				
				var sprSpeed = sprite_get_speed(prepSprite);
				var frameInc = sprSpeed / room_speed;
				
				var frame = ds_map_find_value(prepFrames,hand);
				if hand == "r" {
					//draw_sprite_ext(prepSprite,frame,x,y,1,1,facingDirection,c_white,1);
				} else {
					//draw_sprite_ext(prepSprite,frame,x,y,1,-1,facingDirection,c_white,1);
				}
			
				if isSlowed {
					// var percentSpeed = functionalSpeed / normalSpeed;
					var currentVal = ds_map_find_value(prepFrames,hand);
					frameInc *= slowedSpeedModifier;
					ds_map_replace(prepFrames,hand,currentVal+frameInc);

				} else {
					var currentVal = ds_map_find_value(prepFrames,hand);
					ds_map_replace(prepFrames,hand,currentVal+frameInc);
				}
				
				hand = ds_map_find_next(preparingLimbs, hand);
			}
		}
		
		// draw recover prep hand animation
		if ds_map_size(recoveringLimbs) != 0 {
			var hand = ds_map_find_first(recoveringLimbs); // l or r			
			for (var i = 0; i < ds_map_size(recoveringLimbs); i++) {
				var attackInChain = ds_map_find_value(recoveringLimbs,hand);
				
				var recoverHandItemSprite = hand == "l" ? "_" + offHandItem.spriteName : "_"+mainHandItem.spriteName;
			
				var recoverSprite = asset_get_index("spr_"+spriteString+recoverHandItemSprite+"_recover_"+string(attackInChain));
				var frame = ds_map_find_value(recoverFrames,hand);
				if hand == "r" {
					//draw_sprite_ext(recoverSprite,frame,x,y,1,1,facingDirection,c_white,1);
				} else {
					//draw_sprite_ext(recoverSprite,frame,x,y,1,-1,facingDirection,c_white,1);
				}
				
				var sprSpeed = sprite_get_speed(recoverSprite);
				var frameInc = sprSpeed / room_speed;
			
			/*
				if isSlowed {
					// var percentSpeed = functionalSpeed / normalSpeed;
					var currentVal = ds_map_find_value(recoverFrames,hand);
					frameInc *= slowedSpeedModifier;
					ds_map_replace(recoverFrames,hand,currentVal+frameInc);

				} else {
					var currentVal = ds_map_find_value(recoverFrames,hand);
					//ds_map_replace(recoverFrames,hand,currentVal+1);
				} */
				
				hand = ds_map_find_next(recoveringLimbs,hand);
			}
		}
	}
}

// casting a spell
if (ds_map_size(preparingLimbs) != 0 && (currentUsingSpell != noone || (mainHandItem.isRanged && mainHandItem.isTwoHanded))) {
	// spell bar outline
	var x1 = x-(.75*sprite_width);
	var y1 = y-(.5*sprite_height)-10;
	var x2 = x+(.75*sprite_width);
	var y2 = y-(.5*sprite_height)-5;
	
	var lk = mainHandItem.isRanged ? "r" : "l";
	
	var prepFrame = ds_map_find_value(prepFrames,lk);
	var prepFrameTotal = ds_map_find_value(prepFrameTotals,lk);
	var percentDone = currentUsingSpell != noone ? prepFrame / prepFrameTotal : (prepFrame / (prepFrameTotal-1));
	var c = currentUsingSpell != noone ? c_aqua : c_lime;
	var minC = currentUsingSpell != noone ? c_ltgray : c_red;
	draw_healthbar(x1,y1,x2,y2,percentDone*100,c_black,minC,c,0,true,true);
	//if currentUsingSpell != noone {
	//	draw_set_color(c_white);
	//	draw_set_halign(fa_center); draw_set_valign(fa_top);
	//	draw_set_font(font_damage);
	//	var spell = ds_map_find_value(knownSpells,currentUsingSpell);
	//	scr_draw_text_outline(mean(x1,x2),y1-4,spell.name,c_white,c_ltgray,1,1,0);
	//}
}

