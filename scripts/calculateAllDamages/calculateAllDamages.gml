/// calculateAllDamages(attackObj,assailant,damagesMap,attackNumber,spell)
/// @param attackObj
/// @param assailant
/// @param damagesMap
/// @param attackNumber
/// @param spell

var attackObj = argument[0];
var assailant = argument[1];
var damagesMap = argument[2];
var attackNumber = argument[3];
var spell = argument[4];

var damage = 0;
// keep track of how much of each type of damage is taken (shields absorb different percentages of elements)
var damagesTaken = ds_map_create(); 

var currentDamageType = ds_map_find_first(damagesMap);
var size = ds_map_size(damagesMap);
for (var i = 0; i < size; i++) {
	var damageArray = ds_map_find_value(damagesMap,currentDamageType);
	var damageMin; var damageMax;
	// physical damage is dependent on attack number -- assuming the damage array is specified as such
	var physicalDamages = [SLASH,CRUSH,PIERCE,PHYSICAL];
	if arrayIncludes(physicalDamages,currentDamageType) && array_length_1d(damageArray) > (attackNumber - 1)*2 {
		if attackObj.owner.type == CombatantTypes.Player {
			var index = (attackNumber - 1)*2;
			damageMin = damageArray[index];
			damageMax = damageArray[index+1];
			// account for PhysicalDamageTypesMultiplier property (item bonus)
			var multiplier = ds_map_find_value(attackObj.owner.physicalDamageTypesMultipliers,currentDamageType) / 100;
			damageMin = damageMin*multiplier;
			damageMax = damageMax*multiplier;
			if damageMin > 0 {
				// account for weapon damage modifier (+ k constant)
				var weaponDamageModifier = ds_map_find_value(attackObj.owner.weaponTypesDamage,attackObj.weapon.weaponType);
				damageMin += weaponDamageModifier;
				damageMax += weaponDamageModifier;
			}
		}
		// damages are pre-loaded ranges for each attack data object for ai combatants
		else {
			damageMin = damageArray[0];
			damageMax = damageArray[1];
		}
	}
	// any elemental 
	else {
		damageMin = damageArray[0];
		damageMax = damageArray[1];
		if attackObj.owner.type == CombatantTypes.Player && !arrayIncludes(physicalDamages,currentDamageType) {
			// account for ElementalDamageTypesMultiplier property (item bonus)
			var multiplier = ds_map_find_value(attackObj.owner.elementalDamageTypesMultipliers,currentDamageType) / 100;
			damageMin = damageMin*multiplier;
			damageMax = damageMax*multiplier;
		}
	}
	randomize();
	var damageBase = random_range(damageMin,damageMax);
	// off hand weapons deal less damage
	if attackObj.owner.type == CombatantTypes.Player && attackObj.limbKey == "r" {
		if !attackObj.isSpell {
			if attackObj.weapon.weaponType != UNARMED {
				var modifier = attackObj.owner.offHandDamagePercent/100;
				damageBase = damageBase*modifier;
			}
		}
	}
	// account for defense against this damageType
	var defense = ds_map_find_value(defenses,currentDamageType);
	
	// case PHYSICAL | CRUSH | SLASH | PIERCE -- damage reduction by constant value
	if currentDamageType == PHYSICAL || currentDamageType == CRUSH || currentDamageType == PIERCE || currentDamageType == SLASH {
		damageBase = round(damageBase*attackObj.percentCharged);
		// hexed assailants have their physical damage output reduced
		if assailant.isHexed {
			damageBase *= assailant.hexedDamageModifier;
		}
		if damageBase > 0 {
			if !isShocked {
				randomize();
				var damageReduction = random_range(0,defense);
				damageBase -= damageReduction;
			} else {
				// enhance damage by 25% if shocked
				damageBase *= 1.25;
			}
			if damageBase < 0 damageBase = 0;
		}
	} 
	// case MAGIC | FIRE | ICE | POISON | LIGHTNING -- damage reduction by percent
	else {
		// positive defense will offset x% of damageBase, negative defense increase damageBase by abs(x)%
		damageBase = defense >= 0 ? damageBase - (defense/100)*damageBase : damageBase + abs((defense/100))*damageBase;
		if damageBase > 0 {
			// account for charge amount (spells, mostly)
			damageBase = round(damageBase*attackObj.percentCharged);
			// this could happen if defense is over 100
			if damageBase < 0 {
				damageBase = 0;
			}
		}
	}
	ds_map_replace(damagesTaken,currentDamageType,damageBase);
	damage += damageBase;
			
	// create particles for the hit
	// blood for physical, elemental particles attackObjwise
	if damageBase > 0 {
		global.damageType = currentDamageType;
		global.x1 = __x;
		global.y1 = __y;
		global.particleDirection = noone;
		global.hitParticlesLayer = layer;
		//if (!(currentDamageType == PHYSICAL && isShielding)) {
		if (!(isShielding && scr_is_facing(assailant,id))) {
			instance_create_depth(0,0,1,obj_hit_particles);
		}
		if arrayIncludes(global.ALL_ELEMENTS, currentDamageType) {
			randomize(); var rand = random_range(0,1);
			if rand < .33 || attackObj.isSpell {
				var hitSnd = asset_get_index("snd_magic_"+currentDamageType+"_hit");
				audio_play_sound_at(hitSnd,x,y,depth,100,300,1,0,1);
			}
		}
	}
				
	// elemental conditions applied?			
	// roll random and compare against defense
	var nonConditioningDamageTypes = [PHYSICAL,CRUSH,PIERCE,SLASH];
	if damageBase > 0 && !arrayIncludes(nonConditioningDamageTypes,currentDamageType) {
		applyElementalCondition(currentDamageType,damageBase,spell);
	}
			
	// if this was fire or poison damage, record an altered version of the base amount in case this is the attack that burns or poisons 
	// TODO get a math major Devin. Need to figure out how much damage should be set to burn damage (or added to?)
	if currentDamageType == FIRE {
		burnDamage += .75*damageBase;
	} else if currentDamageType == POISON {
		poisonDamage += .5*damageBase;
	}
			
	// go to the next damageType in array
	currentDamageType = ds_map_find_next(damagesMap, currentDamageType);
}

return [damage,damagesTaken];