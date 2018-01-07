owner = global.owner;
x = owner.x;
y = owner.y;
image_angle = owner.facingDirection;
originalDirection = owner.facingDirection;
facingDirection = owner.facingDirection;
weapon = noone;
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
	percentCharged = owner.prepAnimationFrame / owner.prepAnimationTotalFrames;
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
	// get attack number
	if owner.type != CombatantTypes.Player {
		isRanged = owner.currentMeleeAttack == noone ? true: false;
		isMelee = owner.currentMeleeAttack == noone ? false : true;
		attackNumber = owner.currentMeleeAttack == noone ? owner.currentRangedAttack : owner.currentMeleeAttack;
		attackNumberInChain = owner.attackNumberInChain;
	} else {
		attackNumber = global.playerAttackNumberInChain;
		attackNumberInChain = global.playerAttackNumberInChain;
		weapon = owner.currentAttackingHand == "l" ? owner.leftHandItem : owner.rightHandItem;
		isRanged = weapon.type == HandItemTypes.Ranged;
		isMelee = weapon.type == HandItemTypes.Melee;
	}

	if isMelee && owner.isSlowed {
		image_speed = .5;
	}
	
	// get current attacking hand item sprite name (or "")
	if owner.hasHands {
		//weapon = owner.currentAttackingHand == "l" ? owner.leftHandItem : owner.rightHandItem;
		currentAttackingHandItemSprite = owner.currentAttackingHand == "l" ? "_"+owner.leftHandItem.spriteName : "_"+owner.rightHandItem.spriteName;
	} else currentAttackingHandItemSprite = ""; // TODO for enemies without hands


	// get sprite string -- physical attacks
	var sprStr = "spr_"+owner.spriteString+currentAttackingHandItemSprite+"_attack_"+string(attackNumber);
	if owner.type != CombatantTypes.Player {
		sprStr += "_"+string(owner.attackNumberInChain);
	}

	// if this is a left hand attack, flip yscale
	if owner.hasHands && owner.currentAttackingHand == "l" {
		image_yscale = -1;
	}

	sprite_index = asset_get_index(sprStr);
	
	
	//if (weapon && weapon.type == HandItemTypes.Ranged) || isRanged {
	if isRanged {
		if weapon {
			speed = weapon.projectileSpeed;
		} else {
			speed = owner.rangedSpeeds[attackNumber-1];
		}
		direction = owner.facingDirection;
		facingDirection = direction; // facingDirection property needed for is_facing script
	
		var recoverSprite = asset_get_index("spr_"+owner.spriteString+currentAttackingHandItemSprite+"_recover_"+string(attackNumber));
		if owner.type != CombatantTypes.Player {
			var sprStr = "spr_"+owner.spriteString+currentAttackingHandItemSprite+"_recover_"+string(attackNumber)+"_"+string(owner.attackNumberInChain);
			var recoverSprite = asset_get_index(sprStr);
		}
	
		owner.stupidityFrame = 0;
		owner.recoverAnimationTotalFrames = sprite_get_number(recoverSprite);
		owner.recoverAnimationFrame = 0;
		owner.isAttacking = false;
		owner.isRecovering = true;
	}
}