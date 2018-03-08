prepareLayerShader();
// draw based on state
if limbKey == "r" {
	var leftHand = noone;
	var oId = owner;
	with obj_limb {
		if owner == oId && limbKey == "l" {
			leftHand = id;
		}
	}
	if leftHand {
		var leftHandItem = ds_map_find_value(owner.equippedLimbItems,"l");
		if leftHandItem.isTwoHanded exit;
	}
}

var ys = limbKey == "l" ? -1 : 1;
var rot = owner.facingDirection;
if limbItem.subType == HandItemTypes.Shield && owner.isShielding rot+=90;
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

draw_sprite_ext(sprite,frame,owner.x,owner.y,1*owner.fallScaleFactor,ys*owner.fallScaleFactor,rot,c_white,owner.alpha);

if owner.isSlowed {
	var percentFrozen = ds_map_find_value(owner.conditionPercentages,ICE);
	var colorAlpha = (3/320)*percentFrozen;
	draw_sprite_ext(sprite,frame,owner.x,owner.y,1,ys*owner.fallScaleFactor,rot,c_aqua,colorAlpha*owner.alpha);
} else if owner.isFrozen {
	draw_sprite_ext(sprite,frame,owner.x,owner.y,1*owner.fallScaleFactor,ys*owner.fallScaleFactor,rot,c_aqua,.75*owner.alpha);
} else if owner.isPoisoned {
	var percentPoisoned = ds_map_find_value(owner.conditionPercentages,POISON);
	var colorAlpha = (3/320)*percentPoisoned;
	draw_sprite_ext(sprite,frame,owner.x,owner.y,1*owner.fallScaleFactor,ys*owner.fallScaleFactor,rot,c_aqua,colorAlpha*owner.alpha);
}

shader_reset();