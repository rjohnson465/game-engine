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
	else if handItem.type == HandItemTypes.Melee {
		switch handItem.weaponType {
			case WeaponTypes.Sword1H: {
				spriteString = "spr_player_hand_sword_1h";
				break;
			}
		}
	}
}

sprite_index = asset_get_index(spriteString);

// player case
/*if owner.type == CombatantTypes.Player {
	if handItem.type == HandItemTypes.Ranged {
		
	} 
	else if handItem.type == HandItemTypes.Melee {
		if handItem.isTwoHanded {
			spriteString = "spr_player_hand_melee_2h";
		} else {
			spriteString = "spr_player_hand_melee_1h";
		}
	}
}
else {
	// TODO ai combatant case
}
