// iterate over preparing hands 
// if they just started preparing, need to assign prepare frames / total frames
// if they are finishing preparing, need to create attack objects
if ds_map_size(preparingLimbs) != 0 {
	var hand = ds_map_find_first(preparingLimbs);
	for (var i = 0; i < ds_map_size(preparingLimbs); i++) {
		var weapon = hand == "l" ? leftHandItem : rightHandItem;
		var attackInChain = ds_map_find_value(preparingLimbs,hand);
				
		var prepFrame = ds_map_find_value(prepFrames,hand);
		var prepFrameTotal = ds_map_find_value(prepFrameTotals,hand);
				
		// check if this hand just started preparing attack
		if prepFrame == -1 {
			ds_map_replace(prepFrames,hand,0);
			var itemSprite = hand == "l" ? leftHandItem.spriteName : rightHandItem.spriteName;
			var prepSprite = asset_get_index("spr_player_"+itemSprite+"_prep_"+string(attackInChain));
			ds_map_replace(prepFrameTotals,hand,sprite_get_number(prepSprite));
		}
		// if at the end of attack preparation, we need to create an attack object (slightly different process for ranged vs melee) 
		else if prepFrame >= prepFrameTotal-1 {
			if ( !(weapon.subType == HandItemTypes.Ranged && leftHandItem.isTwoHanded)) {
				speed = 0;
				ds_map_replace(prepFrames,hand,-1);
				ds_map_replace(prepFrameTotals,hand,0);
				ds_map_delete(preparingLimbs,hand);
				ds_map_replace(attackingLimbs,hand,attackInChain);
				stamina -= weapon.staminaCostArray[attackInChain-1];
				global.owner = id;
				global.limbKey = hand;
				instance_create_depth(x,y,1,obj_attack);
				if weapon.isRanged {
					weapon.ammo -= 1;
					weapon.copyOf.ammo -=1;
					if weapon.ammo < 1 {
						alert(weapon.name + " out of ammo", c_red);
					}
				}
			}
			else {
				ds_map_replace(prepFrames,hand,prepFrame-1);
				isReadyToFire = true;
			}
		} 
				
		// if preparing an attack and no attacks are happening with other hand, move back a bit (if you can)
		if ds_map_size(attackingLimbs) == 0 {
			var x1 = x +lengthdir_x(-.5,facingDirection);
			var y1 = y +lengthdir_y(-.5,facingDirection);
		
			if weapon.subType == HandItemTypes.Melee && !place_meeting_layer(x1, y1, obj_solid_parent){
				moveToNearestFreePoint((facingDirection+180)%360,.5);
			}
		} 
		hand = ds_map_find_next(preparingLimbs,hand);
	}
}