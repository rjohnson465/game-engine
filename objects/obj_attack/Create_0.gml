owner = global.owner;
x = owner.x;
y = owner.y;
image_angle = owner.facingDirection;
originalDirection = owner.facingDirection;
facingDirection = owner.facingDirection;
weapon = noone;
handSide = global.handSide; // l, r, or empty string (no hands)
isSpell = false;
isRanged = false;
isMelee = false;
spell = noone;
percentCharged = 0;
combatantsHit = ds_list_create();

// spell logic
if owner.currentUsingSpell != noone {
	isRanged = true;
	isSpell = true;
	percentCharged = global.percentCharged;
	//percentCharged = owner.prepAnimationFrame / owner.prepAnimationTotalFrames;
	var currentSpell = ds_map_find_value(owner.knownSpells,owner.currentUsingSpell);
	spell = currentSpell;
	
	var attunementSpriteName = owner.currentSpellAttunement;
	if spell.spriteName != "aoe" {
		sprite_index = asset_get_index("spr_spell_"+spell.spriteName+"_"+attunementSpriteName);
	} else {
		sprite_index = asset_get_index("spr_spell_magicmissile_"+attunementSpriteName);
	}
	var totalProjectiles = spell.numberOfProjectiles;
	speed = spell.projectileSpeed;
	// TODO get a math major -- calculate spread dynamically, not statically
	if spell.spriteName == "magicmissile" {
		var spread = 0; var start = facingDirection;
		switch totalProjectiles {
			case 1: break;
			case 2: start = (facingDirection+360)-7.5; spread = 15; break;
			case 3: start = (facingDirection+360)-15; spread = 15; break;
			case 4: start = (facingDirection+360)-15; spread = 10; break;
			case 5: start = (facingDirection+360)-20; spread = 10; break;
		}
		var projectileNumber = global.projectileNumber;
		direction = start + (spread*projectileNumber-1);
	} else if spell.spriteName == "projectile" {
		direction = owner.facingDirection;
	} else if spell.spriteName == "aoe" {
		var spread = 360 / totalProjectiles;
		x = mouse_x;
		y = mouse_y;
		direction = spread*global.projectileNumber;
		facingDirection = direction;
	}
}
// ranged or melee: NOT A SPELL
else {
	var attackData = noone;
	// get attack number
	if owner.type != CombatantTypes.Player {
		isRanged = owner.currentMeleeAttack == noone ? true: false;
		isMelee = owner.currentMeleeAttack == noone ? false : true;
		attackNumber = owner.currentMeleeAttack == noone ? owner.currentRangedAttack : owner.currentMeleeAttack;
		attackNumberInChain = ds_map_find_value(owner.attackingHands,handSide);
		if isMelee {
			var attackChain = owner.meleeAttacks[attackNumber-1];
			attackData = attackChain[attackNumberInChain-1];
		} else {
			var attackChain = owner.rangedAttacks[attackNumber-1];
			attackData = attackChain[attackNumberInChain-1];
		}
	} else {
		attackNumber = ds_map_find_value(owner.attackingHands,handSide);
		attackNumberInChain = ds_map_find_value(owner.attackingHands,handSide);
		weapon = handSide == "l" ? owner.leftHandItem : owner.rightHandItem;
		isRanged = weapon.type == HandItemTypes.Ranged;
		isMelee = weapon.type == HandItemTypes.Melee;
	}

	if isMelee && owner.isSlowed {
		image_speed = .5; // TODO
	}
	
	// get current attacking hand item sprite name (or "")
	attackItemSprite = "";
	if owner.hasHands {
		attackItemSprite = handSide == "l" ? "_"+owner.leftHandItem.spriteName : "_"+owner.rightHandItem.spriteName;
	} else attackItemSprite = ""; // TODO for enemies without hands


	// get sprite string -- physical attacks
	var sprStr = "";
	if owner.type == CombatantTypes.Player {
		var sprStr = "spr_"+owner.spriteString+attackItemSprite+"_attack_"+string(attackNumber);
	} else {
		//sprStr = "_"+string(owner.attackNumberInChain);
		sprStr = attackData.spriteName + "_attack_" + string(attackData.spriteAttackNumber) + "_" + string(attackData.spriteAttackNumberInChain);
	}

	// if this is a left hand attack, flip yscale
	if owner.hasHands && handSide == "l" {
		image_yscale = -1;
	}

	sprite_index = asset_get_index(sprStr);
	
	// ranged attacks TODO for player
	if isRanged {
		if weapon {
			speed = weapon.projectileSpeed;
		} else {
			speed = attackData.projectileSpeed;
		}
		direction = owner.facingDirection;
		facingDirection = direction; // facingDirection property needed for is_facing script
	
		var recoverSprite = asset_get_index("spr_"+owner.spriteString+attackItemSprite+"_recover_"+string(attackNumber));
		if owner.type != CombatantTypes.Player {
			var sprStr = "spr_"+owner.spriteString+attackItemSprite+"_recover_"+string(attackNumber)+"_"+string(attackNumberInChain);
			var recoverSprite = asset_get_index(sprStr);
		}
	
		owner.stupidityFrame = 0;
		ds_map_add(owner.recoveringHands,handSide,attackNumberInChain);
		ds_map_replace(owner.recoverFrameTotals,handSide,sprite_get_number(recoverSprite));
		//owner.recoverAnimationTotalFrames = sprite_get_number(recoverSprite);
		ds_map_replace(owner.recoverFrames,handSide,0);
		//owner.recoverAnimationFrame = 0;
		owner.isAttacking = false;
		owner.isRecovering = true;
	}
}