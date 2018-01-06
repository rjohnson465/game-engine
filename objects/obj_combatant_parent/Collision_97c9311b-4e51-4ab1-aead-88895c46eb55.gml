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
		
		var assailant = other.owner;
		var damage = 0;
		var damagesMap = noone;
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
			var isRanged = assailant.currentRangedAttack == noone ? false : true;
			var damagesArray = isRanged ? assailant.rangedDamages : assailant.meleeDamages;
			damagesMap = damagesArray[attackNumber-1];
		}
		
		var currentDamageType = ds_map_find_first(damagesMap);
		var size = ds_map_size(damagesMap);
		for (var i = 0; i < size; i++) {
			var damageArray = ds_map_find_value(damagesMap,currentDamageType);
			var damageMin; var damageMax;
			// physical damage is dependent on attack number
			if currentDamageType == PHYSICAL {
				var index = (attackNumber - 1)*2;
				damageMin = damageArray[index];
				damageMax = damageArray[index+1];
			}
			// any elemental / bleed damage
			else {
				// same amount of elemental damage on each attack in chain (for player attacks)
				if type != CombatantTypes.Player {
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
			damageBase = damageBase*percentCharged;
			damage += round(damageBase);
				
			// TODO -- account for elemental-specific effects
			
			// go to the next damageType in array
			currentDamageType = ds_map_find_next(damagesMap, currentDamageType);
		}
		
		if damage > hp {
			damage = hp;
		}
		// run to get __x and __y (collision point where attack meet this combatant)
		script_execute(scr_collision_point,id,other.id);
		if	isShielding 
			&& script_execute(scr_is_facing,assailant,id)
			{
				global.hitType = "yellow";
				instance_create_depth(__x,__y,1,obj_hit);
				stamina -= damage;
				// shields are only ever held in left hand
				hp -= damage*((100-leftHandItem.blockPercentage)/100);
				if type != CombatantTypes.Player {
					global.damageAmount = damage;
					//global.damageType = other.damageType;
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
			global.hitType = "red";
			instance_create_depth(__x,__y,1,obj_hit);
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
			var force = damage; // + assailant.strength;
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
		
		/*
		if itemHitWith.type == HandItemTypes.Ranged || itemHitWith.type == SpellTypes.Martial {
			instance_destroy(other,false);
		}*/
	}
}