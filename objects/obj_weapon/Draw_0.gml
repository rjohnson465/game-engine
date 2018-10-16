if owner.currentUsingSpell != noone exit;
if limbItem.weaponType == PISTOL || limbItem.weaponType == SHURIKEN || limbItem.weaponType == MUSKET || limbItem.weaponType == CROSSBOW exit;
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

//prepareLayerShader();

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

if sprite == -1 exit;

//draw_sprite_ext(sprite,frame,owner.x,owner.y,owner.scale,ys*owner.scale,rot,c_white,owner.alpha);

// draw glow effect, iff the weapon has hematite or a physical buff
var hasHematite = false;
for (var i = 0; i < limbItem.socketedGems; i++) {
	var gem = ds_list_find_value(limbItem.socketedGems, i);
	if gem.object_index == obj_gem_hematite hasHematite = true;
}
var hasPhysBuff = false;
var cb = ds_map_find_first(limbItem.itemPropertyModifiers);
for (var i = 0; i < ds_map_size(limbItem.itemPropertyModifiers); i++) {
	var val = ds_map_find_value(limbItem.itemPropertyModifiers, cb);
	if limbItem.subType != HandItemTypes.Shield {
		if cb == WeaponProperties.PhysicalDamageBonus && val > 0 {
			hasPhysBuff = true;
		}
	} else if limbItem.subType == HandItemTypes.Shield && cb == ShieldProperties.PhysicalBlockBonus && val > 0 {
		hasPhysBuff = true;
	}
	cb = ds_map_find_next(limbItem.itemPropertyModifiers, cb);
}
// only draw glow if hemataite or phys buff on weapon / shield
if hasHematite || hasPhysBuff {
	gpu_set_blendmode(bm_add);
	for(var c = 0;c < 360;c += 45){
		draw_sprite_ext(sprite,frame,owner.x+lengthdir_x(6,c),owner.y+lengthdir_y(6,c),owner.scale,ys*owner.scale,rot,c_silver,owner.alpha*0.15);
	}
	gpu_set_blendmode(bm_normal)
}
draw_sprite_ext(sprite_index,image_index,owner.x,owner.y,owner.scale,ys*owner.scale,rot,c_white,owner.alpha);
shader_reset();