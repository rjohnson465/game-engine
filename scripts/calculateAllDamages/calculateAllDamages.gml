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
	var physicalDamages = [SLASH,CRUSH,PIERCE];
	if arrayIncludes(physicalDamages,currentDamageType) && array_length_1d(damageArray) > (attackNumber - 1)*2 {
		if attackObj.owner.type == CombatantTypes.Player {
			var index = (attackNumber - 1)*2;
			damageMin = damageArray[index];
			damageMax = damageArray[index+1];
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
	// any elemental / bleed damage
	else {
		damageMin = damageArray[0];
		damageMax = damageArray[1];
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
		randomize();
		var damageReduction = random_range(0,defense);
		damageBase -= damageReduction;
		if damageBase < 0 damageBase = 0;
	} 
	// case MAGIC | FIRE | ICE | POISON | LIGHTNING -- damage reduction by percent
	else {
		// positive defense will offset x% of damageBase, negative defense increase damageBase by abs(x)%
		damageBase = defense >= 0 ? damageBase - (defense/100)*damageBase : damageBase + abs((defense/100))*damageBase;
		// account for charge amount (spells, mostly)
		damageBase = round(damageBase*attackObj.percentCharged);
		// this could happen if defense is over 100
		if damageBase < 0 {
			damageBase = 0;
		}
	}
	ds_map_replace(damagesTaken,currentDamageType,damageBase);
	damage += damageBase;
			
	// create particles for the hit
	// blood for physical, elemental particles attackObjwise
	if	damageBase > 1 {
		global.damageType = currentDamageType;
		global.x1 = __x;
		global.y1 = __y;
		global.particleDirection = noone;
		//if (!(currentDamageType == PHYSICAL && isShielding)) {
		if (!(isShielding && scr_is_facing(assailant,id))) {
			instance_create_depth(0,0,1,obj_hit_particles);
		}
	}
				
	// elemental conditions applied?			
	// roll random and compare against defense
	var nonConditioningDamageTypes = [PHYSICAL,MAGIC,CRUSH,PIERCE,SLASH];
	if damageBase > 0 && !arrayIncludes(nonConditioningDamageTypes,currentDamageType) {
		randomize();
		var top = 1000;
		var percentChance = .15;
		//var percentChance = 1;
		//percentChance = 0;
		if spell != noone && spell.name == "magicmissile" {
			// every misile has a 20/numProjectiles% chance
			var percentChance = (20/spell.numberOfProjectiles)/100;
		}
		var rand = random_range(1,top);
		// TODO apply buffs?
		rand -= defense;
		var topNum = 1000-(percentChance*1000);
		// only apply the condition if the condition is not currently ongoing
		if rand > topNum && ds_map_find_value(conditionPercentages,currentDamageType) == 0 {
			ds_map_replace(conditionPercentages,currentDamageType,100);
			if type == CombatantTypes.Player {
				switch currentDamageType {
					case FIRE: {
						alert("Burning!",c_red);
						break;
					}
					case ICE: {
						alert("Frozen!",c_red);
						break;
					}
					case POISON: {
						alert("Poisoned!",c_red);
						break;
					}
					case LIGHTNING: {
						alert("Shocked!",c_red);
					}
				}
				var conditionBar = noone;
				with (obj_condition_bar) {
					if condition == currentDamageType && owner == global.player.id {
						conditionBar = id;
					}
				}
				if !conditionBar {
					global.owner = global.player.id;
					global.condition = currentDamageType;
					global.conditionBarCount += 1;
					instance_create_depth(x,y,1,obj_condition_bar);
				}
			}
		}
		// if the condition is already ongoing, increase duration based on how hard the hit was
		else if rand > topNum {
			// what percent damage of health was this hit? 
			var percentOfHp = (damageBase/maxHp)*100;
			var currentConditionPercent = ds_map_find_value(conditionPercentages,currentDamageType);
			if currentConditionPercent + percentOfHp > 100 {
				ds_map_replace(conditionPercentages,currentDamageType,100);
			} else if percentOfHp < 10 {
				ds_map_replace(conditionPercentages,currentDamageType,currentConditionPercent+10);
			} else {
				ds_map_replace(conditionPercentages,currentDamageType,currentConditionPercent+percentOfHp);
			}
		}
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