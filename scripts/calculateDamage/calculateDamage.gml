/// calculateDamage()
/// Pre-Condition -- must be called by the victim in a collision event with attackObj


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
	&& other.id != id
{
	
	// if combatant has not been hit with this instance before (only get hit with an attack once)
	if ds_list_find_index(beenHitWith,other.id) == -1 {
		
		ds_list_add(other.combatantsHit,id);
		
		// limit number of combatants hit per attack based on num targets an attack can hit
		if	other.owner.type == CombatantTypes.Player {
			
			if !other.isSpell && ds_list_size(other.combatantsHit) > other.weapon.numberOfTargets {
				exit;
			} else if other.isSpell && ds_list_size(other.combatantsHit) > other.spell.numberOfTargets {
				exit;
			}
		}
		else if other.owner.type != CombatantTypes.Player 
			&& ds_list_size(other.combatantsHit) > other.attackData.numberOfTargets {
				exit;
			}
		
		ds_list_add(beenHitWith,other.id);
		
		// run to get __x and __y (collision point where attack meet this combatant)
		script_execute(scr_collision_point,id,other.id);
		
		var assailant = other.owner;
		var damage = 0;
		var damagesMap = noone;
		var spell = noone;
		var attackNumber; var attackNumberInChain;
		var percentCharged = 1;
		// case AI combatant as assailant
		var attackData = noone;
		// case: Player as assailant; this could be a melee weapon, ranged weapon, or spell (I think??) -- Check attack_parent
		var itemHitWith = noone;
		// find damages map for the attack received (Player damage map dependent on item, enemy / ally damage map is hardcoded)
		if assailant.type == CombatantTypes.Player {
			
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
			var attackChain = isRanged ? other.owner.rangedAttacks[attackNumber-1] : other.owner.meleeAttacks[attackNumber-1];
			attackData = attackChain[attackNumberInChain-1];
			damagesMap = attackData.damages;
		}
		
		// keep track of how much of each type of damage is taken (shields absorb different percentages of elements)
		var damagesTaken = ds_map_create(); 
		
		var currentDamageType = ds_map_find_first(damagesMap);
		var size = ds_map_size(damagesMap);
		for (var i = 0; i < size; i++) {
			var damageArray = ds_map_find_value(damagesMap,currentDamageType);
			var damageMin; var damageMax;
			// physical damage is dependent on attack number -- assuming the damage array is specified as such
			if currentDamageType == PHYSICAL && array_length_1d(damageArray) > (attackNumber - 1)*2 {
				if other.owner.type == CombatantTypes.Player {
					var index = (attackNumber - 1)*2;
					damageMin = damageArray[index];
					damageMax = damageArray[index+1];
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
			// account for defense against this damageType
			var defense = ds_map_find_value(defenses,currentDamageType);
			
			// positive defense will offset x% of damageBase
			// negative defense will increase damageBase by abs(x)%
			damageBase = defense >= 0 ? damageBase - (defense/100)*damageBase : damageBase + abs((defense/100))*damageBase;
			// account for charge amount (spells, mostly)
			damageBase = round(damageBase*percentCharged);
			// this could happen if defense is over 100
			if damageBase < 0 {
				damageBase = 0;
			}
			ds_map_replace(damagesTaken,currentDamageType,damageBase);
			damage += damageBase;
			
			// create particles for the hit
			// blood for physical, elemental particles otherwise
			if	damageBase > 1 {
				global.damageType = currentDamageType;
				global.x1 = __x;
				global.y1 = __y;
				global.particleDirection = noone;
				if (!(currentDamageType == PHYSICAL && isShielding)) {
					instance_create_depth(0,0,1,obj_hit_particles);
				}
			}
				
			// elemental conditions applied?			
			// roll random and compare against defense
			if damageBase > 0 {
				randomize();
				var top = 1000;
				//var percentChance = .15;
				var percentChance = 1;
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
				if rand > topNum && ds_map_find_value(conditionPercentages,currentDamageType) == 0{
					ds_map_replace(conditionPercentages,currentDamageType,100);
					if type == CombatantTypes.Player && currentDamageType != PHYSICAL && currentDamageType != MAGIC {
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
		var actualDamage = damage; // the actual damage of the hit (recieved damage might be less if actual damage exceeds hp)
		
		// factor combo mode
		if assailant.type == CombatantTypes.Player {
			damage += (assailant.comboModeLevel*.25)*damage;
		}
		
		if damage > hp {
			damage = hp;
		}
		
		// hit a shield
		if	isShielding 
			&& script_execute(scr_is_facing,assailant,id)
			{
				global.damageType = "Block";
				global.x1 = __x;
				global.y1 = __y;
				global.particleDirection = facingDirection;
				instance_create_depth(0,0,1,obj_hit_particles);
				// remove the same percentage of stamina as it would have removed health
				var percentageOfHealth = actualDamage / maxHp;
				stamina -= maxStamina*percentageOfHealth;
				// shields are only ever held in left hand
				
				// damage needs to be refactored, as shields have their own defenses per element
				var currentDamageType = ds_map_find_first(damagesTaken);
				var shield = leftHandItem;
				var adjustedDamage = 0;
				for (var i = 0; i < ds_map_size(damagesTaken); i++) {
					
					var defense = ds_map_find_value(shield.defenses,currentDamageType);
					var damageTaken = ds_map_find_value(damagesTaken,currentDamageType);
					adjustedDamage += ((100-defense)/100)*damageTaken;
					
					currentDamageType = ds_map_find_next(damagesTaken,currentDamageType);
				}
				
				hp -= adjustedDamage;
				global.damageAmount = adjustedDamage;
				global.victim = id;
				global.healingSustained = 0;
				instance_create_depth(x,y,1,obj_damage);
				if stamina < 1 {
					isShielding = false;
					// if no more stamina, stagger (slow stagger)
					path_end();
					state = CombatantStates.Staggering;
					staggerFrame = 0;
					staggerDuration = 25; // TODO Devin fix later
					staggerSpeed = 1;
				}	
				// stagger assailant iff assailant weapon / attack staggers against blocks
				var itemOrAttack = attackData != noone ? attackData : itemHitWith;
				if itemOrAttack.staggersAgainstBlocks {
					with assailant {
						var itemIsMelee = false;
						if itemHitWith != noone {
							itemIsMelee = itemHitWith.type == HandItemTypes.Melee;
						}
						if assailant.currentMeleeAttack != noone || itemIsMelee {
							isShielding = false;
							path_end();
							staggerFrame = 0;
							staggerDuration = 1;
							staggerSpeed = 1;
							state = CombatantStates.Staggering;
						}
					}
				}
				
			}
		// hit
		else {			
			// critical?
			
			hp -= damage;
			global.damageAmount = damage;
			global.healingSustained = 0;
			global.victim = id;
			instance_create_depth(x,y,1,obj_damage);
		}
	
		// if this is the first time an enemy was hit, show the hp of the enemy
		if type == CombatantTypes.Enemy && !showHp {
			showHp = true;
		}
	
		// STAGGER OR FLINCH
	
		if state != CombatantStates.Staggering {

			var percentOfHp = actualDamage / maxHp;
			// maybe stagger
			// always a 15% + damage% of totalHp chance to stagger
			var chanceToStagger = .15 + percentOfHp;
			randomize();
			var rand = random_range(0,1);
			if rand < chanceToStagger {
				staggerFrame = 0;
				// stagger duration is 6 frames + damage% of of total hp frames
				staggerDuration = 6 + (percentOfHp*100);
				if staggerDuration > 25 {
					staggerDuration = 25;
				}
				staggerDirection = (assailant.facingDirection+360)%360;
				path_end();
				state = CombatantStates.Staggering;
			}
			// if not stagger, then flinch
			// all flinch values should be half of what a stagger value would have been
			else {
				path_end();
				isFlinching = true;
				totalFlinchFrames = 5 + (.5*(percentOfHp*100)); 
				flinchDirection = (assailant.facingDirection+360)%360;				
			}
		}
		
		// destroy most ranged projectiles on impact
		if other.isRanged || (other.isSpell)/* && spell.name != "aoe")*/ {
			instance_destroy(other,false);
			// also destroy the ranged attack's light radius, if it exists
			var attackObjId = other.id;
			with obj_light_radius {
				if owner == attackObjId {
					instance_destroy(id);
				}
			}
		}
		
		// combo
		if assailant.type == CombatantTypes.Player {
			assailant.comboNumber += 1;
			assailant.comboFrame = 0;
			assailant.comboEffectiveNumber += 1;
		}
		// get out of wary state
		if state == CombatantStates.Wary {
			hasCalculatedWillDodge = false;
			state = CombatantStates.Idle;
		}
		
		// update enemy data for room persistence, if this combatant is an enemy
		if enemyData != noone && type == CombatantTypes.Enemy {
			enemyData.hp = hp;
		}
		
	}
}