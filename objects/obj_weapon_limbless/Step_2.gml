if owner.state == CombatantStates.Dodging || (owner.isShielding && limbItem.subType == HandItemTypes.Shield) {
	visible = false;
} else visible = true;
var leftHandItem = ds_map_find_value(owner.equippedLimbItems,"l");
x = owner.x;
y = owner.y;
image_angle = owner.facingDirection;
image_alpha = owner.alpha;
image_xscale = 1*owner.scale;
image_yscale = 1*owner.scale;
part_system_depth(system,layer_get_depth(owner.layer));

/*
if !(limbKey == "r" || (leftHandItem.isRanged && leftHandItem.isTwoHanded)) {
	image_yscale = -1*owner.scale;
}*/

layer = owner.layer;
//depth = layer_get_depth(layer) - 5000;
if owner.currentUsingSpell != noone {
	visible = false;
}

// switch weapon sprite
var eqLimbItem = ds_map_find_value(owner.equippedLimbItems, limbKey);
if limbItem != eqLimbItem || refreshParticles {
	limbItem = eqLimbItem;
	
	var hh = false;
	for (var i = 0; i < limbItem.socketedGems; i++) {
		var gem = ds_list_find_value(limbItem.socketedGems, i);
		if gem.object_index == obj_gem_hematite hh = true;
	}
	hasHematite = hh;

	refreshParticles = false;

	spriteString = "spr_"+owner.spriteString+"_"+eqLimbItem.spriteName;
	sprite_index = asset_get_index(spriteString);
	
	updateWeaponParticles(limbItem);
}

// show weapon particles
if owner.layer == global.player.layer && owner.currentUsingSpell == noone && owner.isAlive {
	for (var i = 0; i < array_length_1d(weaponParticles); i++) {
		var part = weaponParticles[i];
		if part == noone || part == undefined continue;
		var num = weaponParticlesNums[i];
		part_emitter_region(system,emitter,bbox_left,bbox_right,bbox_top,bbox_bottom,ps_shape_ellipse,ps_distr_gaussian);
		part_emitter_burst(system,emitter,part, num);
	}
}

if (owner.state == CombatantStates.Moving || owner.state == CombatantStates.Wary) && owner.isMoving {
	sprite_index = asset_get_index(spriteString + "_move");
	image_index = owner.image_index;
}

else if owner.state == CombatantStates.Staggering {
	sprite_index = asset_get_index(spriteString + "_stagger");
}
else if owner.isShielding {
	sprite_index = asset_get_index(spriteString + "_block");
}
/*
else if ds_map_find_value(owner.preparingLimbs,limbKey) >= 0 {
	image_index = ds_map_find_value(owner.prepFrames,limbKey);
	sprite_index = getLimbSpriteIndex("prep");
}

else if ds_map_find_value(owner.attackingLimbs,limbKey) >= 0 {
	image_index = ds_map_find_value(owner.attackFrames,limbKey);
	sprite_index = getLimbSpriteIndex("attack");
}

else if ds_map_find_value(owner.recoveringLimbs,limbKey) >= 0 {
	image_index = ds_map_find_value(owner.recoverFrames,limbKey);
	sprite_index = getLimbSpriteIndex("recover");
} */
else {
	sprite_index = asset_get_index(spriteString);
}

