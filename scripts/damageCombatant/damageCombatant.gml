/// damageCombatant(damagesMap,*staggerDuration,*staggerDirection,*hitSound,*assailant)
/// @param damagesMap
/// @param staggerDuration
/// @param staggerDirection
/// @param hitSound
/// @param assailant
// invoking instance must be combatant to damage
// used to damage a combatant by some non-standard combat means (i.e. environment hazard)

var damagesMap = argument[0];

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

	damageMin = damageArray[0];
	damageMax = damageArray[1];
	randomize();
	var damageBase = random_range(damageMin,damageMax);

	// account for defense against this damageType
	var defense = ds_map_find_value(defenses,currentDamageType);
	
	// case PHYSICAL | CRUSH | SLASH | PIERCE -- damage reduction by constant value
	if currentDamageType == PHYSICAL || currentDamageType == CRUSH || currentDamageType == PIERCE || currentDamageType == SLASH {
		if damageBase > 0 {
			if !isShocked {
				damageBase = applyDefenseToDamageBase(damageBase, defense);
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
	}
	ds_map_replace(damagesTaken,currentDamageType,damageBase);
	damage += damageBase;
			
	// create particles for the hit
	// blood for physical, elemental particles attackObjwise
	if argument_count > 4 {
		if !script_execute(scr_collision_point,id,argument[4]) {
			__x = x; __y = y;
		}
	}
	if damageBase > 0 {
		global.damageType = currentDamageType;
		global.x1 = __x;
		global.y1 = __y;
		global.particleDirection = noone;
		global.hitParticlesLayer = layer;
		global.victim = id;
		//if (!(isShielding && scr_is_facing(assailant,id))) {
			instance_create_depth(0,0,1,obj_hit_particles);
		//}
		
	}
				
	// elemental conditions applied?			
	// roll random and compare against defense
	var nonConditioningDamageTypes = [PHYSICAL,CRUSH,PIERCE,SLASH];
	if (damageBase > 0 && !arrayIncludes(nonConditioningDamageTypes,currentDamageType)) {
		maybeApplyElementalCondition(currentDamageType,damageBase,spell,attackObj);
	}
			
	// if this was fire or poison damage, record an altered version of the base amount in case this is the attack that burns or poisons 
	// TODO get a math major Devin. Need to figure out how much damage should be set to burn damage (or added to?)
	if currentDamageType == FIRE {
		burnDamage += .75*damageBase;
		if burnDamage > maxHp/10 {
			burnDamage = maxHp/10;
		}
	} else if currentDamageType == POISON {
		poisonDamage += .5*damageBase;
		if poisonDamage > maxHp/10 {
			poisonDamage = maxHp/10;
		}
	}
			
	// go to the next damageType in array
	currentDamageType = ds_map_find_next(damagesMap, currentDamageType);
}

// maybe stagger
if argument_count > 1 {
	staggerDuration = argument[1];
	if argument_count > 2 {
		staggerDirection = argument[2];
	} else staggerDirection = facingDirection;
	if staggerDuration > 0 {
		path_end(); 
		state = CombatantStates.Staggering;
	}
}

if argument_count > 3 {
	audio_play_sound_at(argument[3],x,y,depth,50,AUDIO_MAX_FALLOFF_DIST,1,0,1);
}

hp -= damage;	
global.damageAmount = damage;
global.healingSustained = 0;
global.victim = id;
global.isCriticalHit = false; // critical?
instance_create_depth(x,y,1,obj_damage);

return [damage,damagesTaken];