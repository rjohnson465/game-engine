owner = global.owner;
limbKey = global.limbKey;
limbItem = ds_map_find_value(owner.equippedLimbItems,limbKey);
persistent = global.isPersistent;
depth = 5;

global.limb = id;
instance_create_depth(x,y,1,obj_weapon);

spriteString = "";

if owner.type != CombatantTypes.Player {
	spriteString = "spr_"+owner.spriteString + "_limb_" + limbItem.spriteName;
} else {
	if limbItem.type == HandItemTypes.Ranged {
		
	} 
	else if limbItem.subType == HandItemTypes.Melee {
		switch limbItem.weaponType {
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

