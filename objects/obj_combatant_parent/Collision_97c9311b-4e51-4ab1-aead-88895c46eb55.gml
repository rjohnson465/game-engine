// if enemy or ally, seek retribution (even if out of normal range)
if	(type == CombatantTypes.Enemy || type == CombatantTypes.Ally) 
	&& state == CombatantStates.Idle
	{
		wasJustHit = true; 
	}


if	state != CombatantStates.Dodging && 
	(type == CombatantTypes.Player && other.owner.type == CombatantTypes.Enemy
	|| type == CombatantTypes.Ally && other.owner.type == CombatantTypes.Enemy 
	|| type == CombatantTypes.Enemy && other.owner.type == CombatantTypes.Ally
	|| type == CombatantTypes.Enemy && other.owner.type == CombatantTypes.Player) 	
{
	// if combatant has not been hit with this instance before (only get hit with an attack once)
	if ds_list_find_index(beenHitWith,other.id) == -1 {
		ds_list_add(beenHitWith,other.id);
		
		// run to get __x and __y (collision point where attack meet this combatant)
		script_execute(scr_collision_point,id,other.id);
		
		var assailant = other.owner;
		var damage = 0;
		var damagesMap = noone;
		var spell = noone;
		var attackNumber; var attackNumberInChain;
		var percentCharged = 1;
		// find damages map for the attack received (Player damage map dependent on item, enemy / ally damage map is hardcoded)
		if assailant.type == CombatantTypes.Player {
			// this could be a melee weapon, ranged weapon, or spell (I think??) -- Check attack_parent
			var itemHitWith;
			if !other.spell {
				itemHitWith = other.weapon;
				attackNumber = other.attackNumber;
				attackNumberInChain = other.attackNumberInChain;
			} else {
				itemHitWith = other.spell;
				spell = other.spell;
				attackNumber = 1;
				attackNumberInChain = 1;
				percentCharged = other.percentCharged;
			}
			// calculate damage, given this weapon / spell
			damagesMap = itemHitWith.damages;
		} 
		// enemies / allies have their attack damages pre-loaded
		else {
			attackNumber = other.attackNumber;
			attackNumberInChain = other.attackNumberInChain;
			var isRanged = other.isRanged;
			var damagesArray = isRanged ? assailant.rangedDamages : assailant.meleeDamages;
			damagesMap = damagesArray[attackNumber-1];
		}
		
		var currentDamageType = ds_map_find_first(damagesMap);
		var size = ds_map_size(damagesMap);
		for (var i = 0; i < size; i++) {
			var damageArray = ds_map_find_value(damagesMap,currentDamageType);
			var damageMin; var damageMax;
			// physical damage is dependent on attack number -- assuming the damage array is specified as such
			if currentDamageType == PHYSICAL && array_length_1d(damageArray) > (attackNumber - 1)*2 {
				var index = (attackNumber - 1)*2;
				damageMin = damageArray[index];
				damageMax = damageArray[index+1];
			}
			// any elemental / bleed damage
			else {
				// same amount of elemental damage on each attack in chain (for player attacks)
				if other.owner.type == CombatantTypes.Player {
					damageMin = damageArray[0];
					damageMax = damageArray[1];
				}
				// enemy/ally attacks may have various elemental bonuses per attack in chain
				else {
					var index = (attackNumber - 1)*2;
					damageMin = damageArray[index];
					damageMax = damageArray[index+1];
				}
			}
			randomize();
			var damageBase = random_range(damageMin,damageMax);
			// account for defense against this damageType
			var defense = ds_map_find_value(defenses,currentDamageType);
			
			// positive defense will offset x% of damageBase
			if defense >= 0 {
				damageBase -= (defense/100)*damageBase;
			}
			// negative defense will increase damageBase by abs(x)%
			else {
				damageBase += (defense/100)*damageBase;
			}
			// account for charge amount (spells, mostly)
			damageBase = round(damageBase*percentCharged);
			damage += damageBase;
			
			// create particles for the hit
			// blood for physical, elemental particles otherwise
			if damageBase > 1 {
				global.damageType = currentDamageType;
				global.x1 = __x;
				global.y1 = __y;
				global.shieldDirection = noone;
				instance_create_depth(0,0,1,obj_hit_particles);
			}
				
			// elemental conditions effected
			// TODO -- get a math major; Devin. How to add to conditionPercent 
			// while being fair and respecting defenses???
			// idea: add the percent of hp the elemental attack had to condition percent
			// caveat: if this percent is under 15%, just add 25-33%
			// then adjust this based on elemental defense
			// apply baseDamage amount to conditionPercentage 
			var currentConditionPercent = ds_map_find_value(conditionPercentages,currentDamageType);
			var addToCondition = 0;
			var damagePercentOfHp = damageBase / maxHp;
			if damagePercentOfHp < .25 && damagePercentOfHp != 0 {
				randomize();
				addToCondition = random_range(25,33);
			} else {
				addToCondition = damagePercentOfHp*100;
			}
			// adjust for elemental defense
			addToCondition = defense >= 0 ? addToCondition - (defense/100)*addToCondition : addToCondition + (defense/100)*addToCondition;
			//show_debug_message(addToCondition);
			if currentConditionPercent + damageBase > 100 {
				addToCondition = 100-currentConditionPercent;
			}
			
			// if this was fire or poison damage, record an altered version of the base amount in case this is the attack that burns or poisons 
			// TODO get a math major Devin. Need to figure out how much damage should be set to burn damage (or added to?)
			if currentDamageType == FIRE {
				burnDamage += .5*damageBase;
			} else if currentDamageType == POISON {
				poisonDamage += .5*damageBase;
			}
			
			ds_map_replace(conditionPercentages,currentDamageType,currentConditionPercent+addToCondition);
			
			// if theres not already a condition handler for this, show the condition bar
			// this does not appear for mere physical damage
			if type == CombatantTypes.Player && currentDamageType != PHYSICAL {
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
			
			// go to the next damageType in array
			currentDamageType = ds_map_find_next(damagesMap, currentDamageType);
		}
		var actualDamage = damage;
		if damage > hp {
			damage = hp;
		}
		
		if	isShielding 
			&& script_execute(scr_is_facing,assailant,id)
			{
				//global.hitType = "yellow";
				//instance_create_depth(__x,__y,1,obj_hit);
				global.damageType = "Block";
				global.x1 = __x;
				global.y1 = __y;
				global.shieldDirection = facingDirection;
				instance_create_depth(0,0,1,obj_hit_particles);
				// remove the same percentage of stamina as it would have removed health
				var percentageOfHealth = actualDamage / maxHp;
				stamina -= maxStamina*percentageOfHealth;
				//stamina -= actualDamage;
				// shields are only ever held in left hand
				hp -= damage*((100-leftHandItem.blockPercentage)/100);
				if type != CombatantTypes.Player {
					global.damageAmount = damage;
					global.victim = id;
					instance_create_depth(x,y,1,obj_damage);
				}
				if stamina < 1 {
					isShielding = false;
					// if no more stamina, stagger (slow stagger)
					path_end();
					state = CombatantStates.Staggering;
					staggerFrame = 0;
					staggerDuration = 25; // TODO fix later
					staggerSpeed = 1;
				}		
			}
		else {
			//global.hitType = "red";
			//instance_create_depth(__x,__y,1,obj_hit);
			
			hp -= damage;
			if type != CombatantTypes.Player {
				global.damageAmount = damage;
				//global.damageType = other.damageType;
				global.victim = id;
				instance_create_depth(x,y,1,obj_damage);
			}
		}
	
		if type == CombatantTypes.Enemy && !showHp {
			showHp = true;
		}
	
		if state != CombatantStates.Staggering {
			// calc force of the hit and tell whether or not to stagger
			// TODO:  Attack force is item weight + damage (what about attacks that do not come from items?)
			var force = actualDamage; // + assailant.strength;
			if (force > poise) {
				// if player, reset global attackNumberInChain
				if type == CombatantTypes.Player {
					global.playerAttackNumberInChain = 1;
				}
				// for enemy / ally, stop the path they're on
				path_end();
				staggerFrame = 0;
				state = CombatantStates.Staggering;
				// TODO completely redo -- stagger should be decided based on weapon used, strength of assailant, and weight of victim
				/*if !isRanged {
					var a = hitBy.meleeAttacksStaggerDuration[attackNumber-1];
					staggerDuration = a[attackNumberInChain-1];
				}*/
				staggerDuration = 25;
				staggerDirection = assailant.facingDirection;
			}
		}
		
		// destroy most ranged projectiles on impact
		if other.isRanged || (other.isSpell && spell.name != "aoe") {
			instance_destroy(other,false);
		}
		
	}
}