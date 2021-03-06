if room == game_menu exit;
//if limbItem.weaponType == PISTOL exit; // must draw pistols on top of hands
shader_reset();
if !owner.isBeingHit {
	//prepareLayerShader();
} else {
	shader_set(sh_red);
	var uPOSITION = shader_get_uniform(sh_red, "Position");
	shader_set_uniform_f(uPOSITION,owner.alarm[5]/5);
}
var rightHandItem = ds_map_find_value(owner.equippedLimbItems,"r");
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
		
		if (rightHandItem.isTwoHanded || owner.state == CombatantStates.Healing) && owner.currentUsingSpell == noone {
			shader_reset();
			exit;
		}
	}
}

var ys = (limbKey == "r" || (rightHandItem.isRanged && rightHandItem.isTwoHanded)) ? 1 : -1;
if limbKey == "l" && owner.currentUsingSpell != noone ys = -1;
var rot = owner.facingDirection;
//if limbItem.subType == HandItemTypes.Shield && owner.isShielding rot+=90;
var frame = 0; var sprite = asset_get_index(spriteString);
if owner.state == CombatantStates.Healing {
	frame = owner.healingFrame;
	sprite = spr_player_heal;
}
else if owner.currentUsingSpell == noone {
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
} else {
	var frame = ds_map_find_value(owner.prepFrames,"l")/2;
	var sprite = asset_get_index("spr_player_hand_spellprep");
}

if sprite < 0 {
	shader_reset();
	exit;
}

draw_sprite_ext(sprite,frame,owner.x,owner.y,owner.scale,ys*owner.scale,rot,owner.image_blend,owner.alpha);

if owner.isSlowed {
	var percentFrozen = ds_map_find_value(owner.conditionPercentages,ICE);
	var colorAlpha = (3/320)*percentFrozen;
	draw_sprite_ext(sprite,frame,owner.x,owner.y,owner.scale,ys*owner.scale,rot,c_aqua,.5*owner.alpha);
} else if owner.isFrozen {
	draw_sprite_ext(sprite,frame,owner.x,owner.y,owner.scale,ys*owner.scale,rot,c_aqua,.75*owner.alpha);
} else if owner.isPoisoned {
	var percentPoisoned = ds_map_find_value(owner.conditionPercentages,POISON);
	var colorAlpha = (3/320)*percentPoisoned;
	draw_sprite_ext(sprite,frame,owner.x,owner.y,owner.scale,ys*owner.scale,rot,c_aqua,.5*owner.alpha);
}

shader_reset();