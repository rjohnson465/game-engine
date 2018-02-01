owner = global.owner;
depth = 1;
x = owner.x;
y = owner.y;
image_angle = owner.facingDirection;
originalDirection = owner.facingDirection;
facingDirection = owner.facingDirection;
weapon = noone;
limbKey = global.limbKey; // l | r is most common
isSpell = false;
isRanged = false;
isMelee = false;
attackData = noone;
spell = noone;
percentCharged = 0;
combatantsHit = ds_list_create();

// spell logic
if owner.currentUsingSpell != noone {
	
	isRanged = true;
	isSpell = true;
	percentCharged = global.percentCharged;
	var currentSpell = ds_map_find_value(owner.knownSpells,owner.currentUsingSpell);
	spell = currentSpell;
	
	// set spell damage type based on attunement
	for (var i = 0; i < array_length_1d(global.ALL_ELEMENTS); i++) {
		var el = global.ALL_ELEMENTS[i];
		if el == owner.currentSpellAttunement {
			ds_map_replace(spell.damages,el,[spell.minDamage,spell.maxDamage]);
		} else {
			ds_map_replace(spell.damages,el,[0,0]);
		}
	}
	
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
		attackNumberInChain = ds_map_find_value(owner.attackingLimbs,limbKey);
		if isMelee {
			var attackChain = owner.meleeAttacks[attackNumber-1];
			attackData = attackChain[attackNumberInChain-1];
		} else {
			var attackChain = owner.rangedAttacks[attackNumber-1];
			attackData = attackChain[attackNumberInChain-1];
		}
	} else {
		attackNumber = ds_map_find_value(owner.attackingLimbs,limbKey);
		attackNumberInChain = ds_map_find_value(owner.attackingLimbs,limbKey);
		
		weapon = ds_map_find_value(owner.equippedLimbItems,limbKey);
		
		isRanged = weapon.type == HandItemTypes.Ranged;
		isMelee = weapon.type == HandItemTypes.Melee;
	}

	if isMelee && owner.isSlowed {
		image_speed = .5; // TODO
	}
	
	// get current attacking limb item sprite name (or "")
	attackItemSprite = "";
	if owner.hasHands {
		attackItemSprite = "_"+ ds_map_find_value(owner.equippedLimbItems,limbKey).spriteName;
	} else attackItemSprite = ""; // TODO for enemies/attacks without hands


	// get sprite string -- physical attacks
	var sprStr = "";
	if owner.type == CombatantTypes.Player {
		var sprStr = "spr_"+owner.spriteString+attackItemSprite+"_attack_"+string(attackNumber);
	} else {
		//sprStr = "_"+string(owner.attackNumberInChain);
		sprStr = attackData.spriteName + "_attack_" + string(attackData.spriteAttackNumber) + "_" + string(attackData.spriteAttackNumberInChain);
	}

	// if this is a left hand attack, flip yscale
	if limbKey == "l" {
		image_yscale = -1;
	}

	sprite_index = asset_get_index(sprStr);
	
	// ranged attacks 
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
		ds_map_add(owner.recoveringLimbs,limbKey,attackNumberInChain);
		ds_map_replace(owner.recoverFrameTotals,limbKey,sprite_get_number(recoverSprite));
		ds_map_replace(owner.recoverFrames,limbKey,0);
		owner.isAttacking = false;
		owner.isRecovering = true;
	}
}