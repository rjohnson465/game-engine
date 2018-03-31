owner = global.player;
limbKey = global.limbKey;
weapon = ds_map_find_value(owner.equippedLimbItems,limbKey);
weaponType = weapon.weaponType;
//attackNumber = global.attackNumber;

switch weaponType {
	case BOW: {
		sprite_index = spr_player_bow_attack_charge;
		direction = owner.facingDirection;
		image_angle = direction;
		speed = 25;
		ds_map_replace(owner.recoveringLimbs,limbKey,1);
		
		// set recoverFrames to -1
		ds_map_replace(owner.recoverFrames,limbKey,-1);
		
		// remove limbKey from attackingLimbs map
		ds_map_delete(owner.attackingLimbs,limbKey);
		break;
	}
}