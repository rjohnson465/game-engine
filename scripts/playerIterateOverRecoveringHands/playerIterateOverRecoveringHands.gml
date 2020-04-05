// iterate over recovering hands
// if they just started recovering, need to assign recover frames / total frames
// if they just finished recovering, need to check if we need to leave attack state or if we need to attack with that hand again
if ds_map_size(recoveringLimbs) != 0 {
	var hand = ds_map_find_first(recoveringLimbs);
	for (var i = 0; i < ds_map_size(recoveringLimbs); i++) {
		var attackInChain = ds_map_find_value(recoveringLimbs,hand);
		var recoverFrame = ds_map_find_value(recoverFrames,hand);
		var recoverFrameTotal = ds_map_find_value(recoverFrameTotals,hand);
				
		// check if this hand just started recovering attack
		if recoverFrame == -1 {
			ds_map_replace(recoverFrames,hand,0);
			var itemSprite = hand == "l" ? leftHandItem.spriteName : rightHandItem.spriteName;
			var recoverSprite = asset_get_index("spr_player_"+itemSprite+"_recover_"+string(attackInChain));
			ds_map_replace(recoverFrameTotals,hand,sprite_get_number(recoverSprite));
		}
		// if at end of recover, we may need to leave attack state (if no other hands are recovering or preparing or attacking)
		else if recoverFrame >= recoverFrameTotal-1 {
			// no matter what, we need to remove this hand from recoveringLimbs and reset frame values
			ds_map_replace(recoverFrames,hand,-1);
			ds_map_replace(recoverFrameTotals,hand,0);
			ds_map_delete(recoveringLimbs,hand);
					
			// if attackAgain, restart chain
			if ds_map_find_value(attackAgain,hand) {
				var itemSprite = hand == "l" ? leftHandItem.spriteName : rightHandItem.spriteName;
				var prepString = "spr_"+spriteString+"_"+itemSprite+"_prep_1";
				//var prepString = "spr_"+spriteString+"_"+itemSprite+"_prep_1";
				ds_map_replace(preparingLimbs,hand,1);
				ds_map_replace(prepFrames,hand,0);
				ds_map_replace(prepFrameTotals,hand,sprite_get_number(asset_get_index(prepString)));
				ds_map_delete(recoveringLimbs,hand);
				ds_map_replace(recoverFrames,hand,-1);
				ds_map_replace(recoverFrameTotals,hand,0);
				ds_map_replace(attackAgain,hand,false);
			}
					
			ds_map_replace(attackAgain,hand,false);
					
			if ds_map_size(preparingLimbs) == 0 && ds_map_size(attackingLimbs) == 0 && ds_map_size(recoveringLimbs) == 0 {
				state = CombatantStates.Idle;
				break;
			} 
		} else {
			// if we're in recover but told to attack again:
			// make sure there is another attack in the chain
			// decrement recover frames until at 0
			// then create new preparingLimb / prepFrames
			var itemSprite = hand == "l" ? leftHandItem.spriteName : rightHandItem.spriteName;
			var prepString = "spr_"+spriteString+"_"+itemSprite+"_prep_"+string(attackInChain+1);
					
			if ds_map_find_value(attackAgain,hand) != 0 && asset_get_index(prepString) != -1 {
						
				if recoverFrame <= 0 {
					ds_map_replace(preparingLimbs,hand,attackInChain+1);
					ds_map_replace(prepFrames,hand,0);
					ds_map_replace(prepFrameTotals,hand,sprite_get_number(asset_get_index(prepString)));
					ds_map_delete(recoveringLimbs,hand);
					ds_map_replace(recoverFrames,hand,-1);
					ds_map_replace(recoverFrameTotals,hand,0);
					ds_map_replace(attackAgain,hand,false);
				} else {
					ds_map_replace(recoverFrames,hand,recoverFrame-1);
				}
				break;
			}
					
			ds_map_replace(recoverFrames,hand,recoverFrame+1);
		}
		hand = ds_map_find_next(recoveringLimbs,hand);
	}
}