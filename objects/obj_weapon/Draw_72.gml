if owner.currentUsingSpell != noone exit;
if limbItem.weaponType == PISTOL || limbItem.weaponType == SHURIKEN exit;
var leftHandItem = ds_map_find_value(owner.equippedLimbItems,"l");
var rightHandItem = ds_map_find_value(owner.equippedLimbItems,"r");
if limbKey == "r" && rightHandItem.weaponType == THROWN && rightHandItem.ammo == 0 {
	visible = false;
	exit;
}
if limbKey == "l" && leftHandItem.weaponType == THROWN && leftHandItem.ammo == 0 {
	visible = false;
	exit;
}

prepareLayerShader();

if sprite_index == -1 exit;

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

// draw based on state
var ys = (limbKey == "r" || (leftHandItem.isRanged && leftHandItem.isTwoHanded)) ? 1 : -1;
var rot = owner.facingDirection;
var frame = 0; var sprite = asset_get_index(spriteString);
// preparing limb
if ds_map_find_value(owner.preparingLimbs,limbKey) >= 0 {
	frame = ds_map_find_value(owner.prepFrames,limbKey)
	sprite = getLimbSpriteIndex("prep");
	
}

// attacking limb
else if ds_map_find_value(owner.attackingLimbs,limbKey) >= 0 {
	frame = ds_map_find_value(owner.attackFrames,limbKey)
	sprite = getLimbSpriteIndex("attack");
}

// recovering limb
else if ds_map_find_value(owner.recoveringLimbs,limbKey) >= 0 {
	frame = ds_map_find_value(owner.recoverFrames,limbKey)
	sprite = getLimbSpriteIndex("recover");
}

draw_sprite_ext(sprite,frame,owner.x,owner.y,owner.scale,ys*owner.scale,rot,c_white,owner.alpha);
shader_reset();