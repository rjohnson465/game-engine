owner = global.owner;
limbKey = global.limbKey;
handItem = ds_map_find_value(owner.equippedLimbItems,limbKey);

global.limb = id;
instance_create_depth(x,y,1,obj_weapon);

spriteString = "";

if owner.type != CombatantTypes.Player {
	spriteString = "spr_"+owner.spriteString + "_hand_" + handItem.spriteName;
} else {
	if handItem.type == HandItemTypes.Ranged {
		
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

if limbKey == "l" {
	image_yscale = -1;
}

sprite_index = asset_get_index(spriteString);

