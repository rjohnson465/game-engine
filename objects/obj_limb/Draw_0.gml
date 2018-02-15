// draw based on state

if limbKey == "l" {
	var rightHand = noone;
	var oId = owner;
	with obj_limb {
		if owner == oId && limbKey == "r" {
			rightHand = id;
		}
	}
	if rightHand {
		var rightHandItem = ds_map_find_value(owner.equippedLimbItems,"r");
		if rightHandItem.isTwoHanded exit;
	}
}

var ys = limbKey == "l" ? -1 : 1;
var rot = owner.facingDirection;
var frame = 0; var sprite = asset_get_index(spriteString);
// preparing limb
if ds_map_find_value(owner.preparingLimbs,limbKey) >= 0 {
	var frame = ds_map_find_value(owner.prepFrames,limbKey)
	var sprite = getLimbSpriteIndex("prep");
}

// attacking limb
else if ds_map_find_value(owner.attackingLimbs,limbKey) >= 0 {
	var frame = ds_map_find_value(owner.attackFrames,limbKey)
	var sprite = getLimbSpriteIndex("attack");
}

// recovering limb
else if ds_map_find_value(owner.recoveringLimbs,limbKey) >= 0 {
	var frame = ds_map_find_value(owner.recoverFrames,limbKey)
	var sprite = getLimbSpriteIndex("recover");
}

draw_sprite_ext(sprite,frame,owner.x,owner.y,1,ys,rot,c_white,owner.alpha);
//draw_sprite(sprite,frame,owner.x,owner.y);
