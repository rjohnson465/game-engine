// switch hand sprites if weapon changes and uses different weapon art
if ds_map_find_value(owner.equippedLimbItems,limbKey) != handItem {
	handItem = ds_map_find_value(owner.equippedLimbItems,limbKey);
	
	if owner.type != CombatantTypes.Player {
		spriteString = "spr_"+owner.spriteString + "_hand_" + handItem.spriteName;
	} else {
		if handItem.subType == HandItemTypes.Ranged {
		
		} 
		else if handItem.subType == HandItemTypes.Melee {
			switch handItem.weaponType {
				case WeaponTypes.Sword1H: {
					spriteString = "spr_player_hand_sword_1h";
					break;
				}
				case WeaponTypes.Unarmed: {
					spriteString = "spr_player_hand_unarmed";
					break;
				}
			}
		}
	}
	
	sprite_index = asset_get_index(spriteString);
}

// if we currently have a 2h weapon equipped, make the left hand fuck off
var rightHandItem = ds_map_find_value(owner.equippedLimbItems,"r");
if rightHandItem {
	if rightHandItem.isTwoHanded && limbKey == "l" {
		x = -10;
		y = -10;
	}
}

x = owner.x;
y = owner.y;
image_angle = owner.facingDirection;


if	ds_map_find_value(owner.preparingLimbs,limbKey) >= 0 &&
	ds_map_find_value(owner.prepFrames,limbKey) <= ds_map_find_value(owner.prepFrameTotals,limbKey) &&
	ds_map_find_value(owner.recoverFrames,limbKey) == -1 {
	
	//var a = ds_map_find_value(owner.recoverFrames,limbKey);
	//show_debug_message(a);
	
	var attackNumber = ds_map_find_value(owner.preparingLimbs,limbKey);
	image_index = ds_map_find_value(owner.prepFrames,limbKey);
	sprite_index = asset_get_index(spriteString+"_prep_"+string(attackNumber));
}

// TODO
// change hand item spriteString based on changed weapons
// do this here? Or when something is equipped / unequipped?

//show_debug_message(sprite_get_name(sprite_index) + " | " + string(image_index));