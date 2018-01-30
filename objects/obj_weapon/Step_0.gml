x = hand.x;
y = hand.y;
image_angle = owner.facingDirection;

if ds_map_find_value(owner.prepFrames,handSide) > 0 {
	var attackNumber = ds_map_find_value(owner.preparingHands,handSide);
	//image_index = 0;
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
		sprite_index = attackSprite;
	}
	//var frame = 0;
	with attackObjHand {
		frame = image_index-1;
	}
	//image_index = frame;
} else if ds_map_find_value(owner.prepFrames,handSide) > 0 {
	//image_index = ds_map_find_value(owner.prepFrames,handSide);
	
	if ds_map_find_value(owner.prepFrames,handSide) == 0 {
		var attackNumber = ds_map_find_value(owner.preparingHands,handSide);
		frame = -1;
		sprite_index = asset_get_index(spriteString+"_prep_"+string(attackNumber));
	} //else image_index = frame++;
} 
else if ds_map_find_value(owner.recoverFrames,handSide) > 0 {
	//image_index = ds_map_find_value(owner.recoverFrames,handSide);
	if ds_map_find_value(owner.recoverFrames,handSide) == 0 {
		var attackNumber = ds_map_find_value(owner.recoveringHands,handSide);
		//image_index = 0;
		frame = -1;
		sprite_index = asset_get_index(spriteString+"_recover_"+string(attackNumber));
	}
} else {
	frame = -1;
	sprite_index = asset_get_index(spriteString);
}

frame++;
image_index = frame;
show_debug_message(sprite_get_name(sprite_index) + string(image_index));
//if image_index > sprite_get_number(sprite_index) image_index = sprite_get_number(sprite_index);
*/
