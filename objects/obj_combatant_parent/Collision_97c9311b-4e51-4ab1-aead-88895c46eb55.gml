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
		var itemHitWith;
		if assailant.hasHands {
			if other.weapon && other.weapon.type == HandItemTypes.Ranged {
				itemHitWith = other.weapon;
			} else if !other.isSpell {
				itemHitWith = assailant.currentAttackingHand == "l" ? assailant.leftHandItem : assailant.rightHandItem;
			} else {
				itemHitWith = other.spell;
			}
		}
		
		var baseDamage;
		if itemHitWith.type != SpellTypes.Martial {
			var attackNumber = other.attackNumber;
			var attackNumberInChain = other.attackNumberInChain;
			var isRanged = false;
			if assailant.type != CombatantTypes.Player {
				isRanged = assailant.currentRangedAttack == noone ? false : true;
			} 
		
			// calc base damage
			// these damage calculations are a mess and you really shoulds be fed dog
			var baseDamageMin; var baseDamageMax;
		
			// Enemy or Ally is assailant
			if assailant.type != CombatantTypes.Player {
			
				var a;
				// if assailant has hands, base damage on their weapons
				if assailant.hasHands {
					// this will not work for Ranged attacks, since currentAttackingHand is reset after recover
					a = itemHitWith.physicalDamageArray;
				}
				// if assailant does not have hands, base damage on their meleeAttacksDamage and rangedAttacksDamage Arrays
				else {
					if !isRanged {
						a = assailant.meleeAttacksDamages[attackNumber-1];
					} else {
						a = assailant.rangedAttacksDamages[attackNumber-1];
					}
				}
				baseDamageMin = a[attackNumberInChain-1];     
				baseDamageMax = a[attackNumberInChain];
			}
			// Player is assailant
			else {
				var i = (attackNumber - 1)*2;
				baseDamageMin = itemHitWith.physicalDamageArray[i];
				baseDamageMax = itemHitWith.physicalDamageArray[i+1];
			}
		
			baseDamage = random_range(baseDamageMin, baseDamageMax);
		}
		// hit with a martial spell
		else {	
			var key = ds_map_find_first(itemHitWith.damages);
			baseDamage = ds_map_find_value(itemHitWith.damages,key);
			baseDamage = other.percentCharged * baseDamage;
		}
		
		// run to get __x and __y (collision point)
		script_execute(scr_collision_point,id,other.id);
		if	isShielding 
			&& script_execute(scr_is_facing,assailant,id)
			{
				global.hitType = "yellow";
				instance_create_depth(__x,__y,1,obj_hit);
				stamina -= baseDamage;
				// shields are only ever held in left hand
				hp -= baseDamage*((100-leftHandItem.blockPercentage)/100);
				if type != CombatantTypes.Player {
					global.damageAmount = baseDamage;
					global.damageType = other.damageType;
					global.victim = id;
					instance_create_depth(x,y,1,obj_damage);
				}
				if stamina < 1 {
					isShielding = false;
					// if no more stamina, stagger (slow stagger)
					path_end();
					state = CombatantStates.Staggering;
					staggerFrame = 0;
					staggerDuration = 25; // fix later
					staggerSpeed = 1;
				}		
			}
		else {
			//global.hitType = type == CombatantTypes.Player ? "white" : "red";
			global.hitType = "red";
			instance_create_depth(__x,__y,1,obj_hit);
			hp -= baseDamage;
			if type != CombatantTypes.Player {
				global.damageAmount = baseDamage;
				global.damageType = other.damageType;
				global.victim = id;
				instance_create_depth(x,y,1,obj_damage);
			}
		}
	
		if type == CombatantTypes.Enemy && !showHp {
			showHp = true;
		}
	
		if state != CombatantStates.Staggering {
			// calc force of the hit and tell whether or not to stagger
			// TODO:  Attack force is item weight + damage
			var force = baseDamage + assailant.strength;
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
		
		if itemHitWith.type == HandItemTypes.Ranged || itemHitWith.type == SpellTypes.Martial {
			instance_destroy(other,false);
		}
	}
}