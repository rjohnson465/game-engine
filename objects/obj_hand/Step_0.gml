// if we currently have a 2h weapon equipped, make the left hand fuck off
if owner.rightHandItem.isTwoHanded && handSide == "l" {
	x = -10;
	y = -10;
}

x = owner.x;
y = owner.y;
image_angle = owner.facingDirection;

if ds_map_find_value(owner.preparingHands,handSide) > 0 {
	var attackNumber = ds_map_find_value(owner.preparingHands,handSide);
	sprite_index = asset_get_index(spriteString+"_prep_"+string(attackNumber));
}

/*var handOwner = owner.id;
var handHandSide = handSide;
var attackObjHand = noone;
with obj_attack {
	if owner == handOwner && handSide = handHandSide {
		attackObjHand = id;
	}
}

if attackObjHand != noone  {
	var attackNumber = attackObjHand.attackNumber;
	var attackSprite = asset_get_index(spriteString+"_attack_"+string(attackNumber));
	if sprite_index != attackSprite {
		//image_index = 0;
		sprite_index = attackSprite;
	}
} else if ds_map_find_value(owner.prepFrames,handSide) >= 0 {
	if ds_map_find_value(owner.prepFrames,handSide) == 0 {
		var attackNumber = ds_map_find_value(owner.preparingHands,handSide);
		sprite_index = asset_get_index(spriteString+"_prep_"+string(attackNumber));
	}
} 
else if ds_map_find_value(owner.recoverFrames,handSide) >= 0 {
	var a = ds_map_find_value(owner.recoverFrames,handSide);
	if ds_map_find_value(owner.recoverFrames,handSide) == 0 {
		var attackNumber = ds_map_find_value(owner.recoveringHands,handSide);
		//image_index = 0;
		sprite_index = asset_get_index(spriteString+"_recover_"+string(attackNumber));
	}
} else {
	sprite_index = asset_get_index(spriteString);
}




