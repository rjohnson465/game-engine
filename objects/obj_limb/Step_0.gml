// switch hand sprites if weapon changes and uses different weapon art
if ds_map_find_value(owner.equippedLimbItems,limbKey) != limbItem {
	limbItem = ds_map_find_value(owner.equippedLimbItems,limbKey);
	
	if owner.type != CombatantTypes.Player {
		spriteString = "spr_"+owner.spriteString + "_hand_" + limbItem.spriteName;
	} else {
		if limbItem.subType == HandItemTypes.Ranged {
		
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
	
	var attackNumber = noone;
	if owner.type == CombatantTypes.Player {
		attackNumber = ds_map_find_value(owner.preparingLimbs,limbKey);
	} else {
		attackNumber = owner.currentMeleeAttack != noone? owner.currentMeleeAttack : owner.currentRangedAttack;
	}
	
	image_index = ds_map_find_value(owner.prepFrames,limbKey);
	
	if owner.type == CombatantTypes.Player {
		sprite_index = asset_get_index(spriteString+"_prep_"+string(attackNumber));
	} else {		
		var attackChainsArray = owner.currentMeleeAttack != noone? owner.meleeAttacks : owner.rangedAttacks;
		var attackChainArray = attackChainsArray[attackNumber-1];
		var attackNumberInChain = ds_map_find_value(owner.preparingLimbs,limbKey);
		var attackData = attackChainArray[attackNumberInChain-1];
		
		var spriteAttackNumber = attackData.spriteAttackNumber;
		var spriteAttackNumberInChain = attackData.spriteAttackNumberInChain;
		
		sprite_index = asset_get_index(spriteString+"_prep_"+string(spriteAttackNumber)+"_"+string(spriteAttackNumberInChain));
	}
}

/*
if owner.type != CombatantTypes.Player {
show_debug_message(sprite_get_name(sprite_index) + " | " + string(image_index));
}*/

