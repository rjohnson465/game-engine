/// calculateDamage(attack)
/// @param attack
/// Pre-Condition -- must be called by the victim in a collision event with attackObj

if hp <= 0 exit;
if isInvulnerable exit;
if isFalling exit;
var isFading = false;
with obj_fade {
	if instance_count > 0 {
		isFading = true;
	}
}
if isFading {
	exit;
}

var attackObj = other;
if state == CombatantStates.Dodging && ds_list_find_index(beenHitWith,attackObj.id) == -1 {
	exit;
}

if attackObj.alarm[0] >= 0 exit;

// assailant and victim must be on the same layer
if attackObj.owner.layer != layer {
	exit;
}

// if combatant has not been hit with this instance before (only get hit with an attack once)
if !ds_exists(beenHitWith,ds_type_list) {
	beenHitWith = -1; beenHitWith = ds_list_create();
}
if ds_list_find_index(beenHitWith,attackObj.id) != -1 exit;

// if player, check if player has been hit with some member of this AOE group recently
if type == CombatantTypes.Player && (object_is_ancestor(attackObj, obj_attack_aoe) || attackObj.object_index == obj_attack_aoe) {
	if ds_exists(beenHitWith, ds_type_list) {
		for (var i = 0; i < ds_list_size(beenHitWith); i++) {
			var atkThatHit = ds_list_find_value(beenHitWith, i);
			if is_string(atkThatHit) && string_pos(attackObj.owner.key, atkThatHit) && attackObj.aoeOnlyHitsOnce {
				exit;
			}
		}
	}
}

// if enemy or ally, seek retribution (even if out of normal range)
if	(type == CombatantTypes.Enemy || type == CombatantTypes.Ally) 
	&& state == CombatantStates.Idle
	{
		wasJustHit = true; 
	}


if	state != CombatantStates.Dodging && 
	(type == CombatantTypes.Player && attackObj.owner.type == CombatantTypes.Enemy
	|| type == CombatantTypes.Ally && attackObj.owner.type == CombatantTypes.Enemy 
	|| type == CombatantTypes.Enemy && attackObj.owner.type == CombatantTypes.Ally
	|| type == CombatantTypes.Enemy && attackObj.owner.type == CombatantTypes.Player) 
	&& attackObj.owner.id != id
{
		
	if !attackObj.combatantsHit || !ds_exists(attackObj.combatantsHit, ds_type_list) {
		attackObj.combatantsHit = ds_list_create();
	}
	
	// if this is an enemy that was just hit and it is not aggressive, maybe become aggressive
	if !instance_exists(lockOnTarget) && type == CombatantTypes.Enemy {
		maybeAggro();
	}
		
	ds_list_add(attackObj.combatantsHit,id);
	if type == CombatantTypes.Player && (object_is_ancestor(attackObj, obj_attack_aoe) || attackObj.object_index == obj_attack_aoe) {
		ds_list_add(beenHitWith, "AOE-" + string(attackObj.owner.key));
	} else {
		ds_list_add(beenHitWith,attackObj.id);
	}
		
	// run to get __x and __y (collision point where attack meet this combatant)
	if !script_execute(scr_collision_point,id,attackObj.id) {
		__x = x; __y = y;
	}
	
	var assailant = attackObj.owner;
	if assailant.isFalling exit;
	var damage = 0;
	var damagesMap = noone;
	var spell = noone;
	var attackNumber = noone; var attackNumberInChain = noone;
	var percentCharged = 1;
	var isBlockBroken = false;
	// case: AI combatant as assailant
	var attackData = noone;
	// case: Player as assailant; this could be a melee weapon, ranged weapon, or spell 
	var itemHitWith = noone;
	
	if attackObj != noone && attackObj.object_index == obj_damage_dealer {
		attackData = attackObj.attackData;
		damagesMap = attackData.damages;
	}
		
	
		// find damages map for the attack received (Player damage map dependent on item, enemy / ally damage map is hardcoded)
	else {
		if assailant.type == CombatantTypes.Player {
			
			if !attackObj.spell {
				itemHitWith = attackObj.weapon;
				attackNumber = attackObj.attackNumber;
				attackNumberInChain = attackObj.attackNumberInChain;
			} else {
				itemHitWith = attackObj.spell;
				spell = attackObj.spell;
				attackNumber = 1;
				attackNumberInChain = 1;
				percentCharged = attackObj.percentCharged;
			}
			// calculate damage, given this weapon / spell
			damagesMap = itemHitWith.damages;
		} 
		// enemies / allies have their attack damages pre-loaded
		else {
			attackNumber = attackObj.attackNumber;
			attackNumberInChain = attackObj.attackNumberInChain;
			attackData = attackObj.attackData
			damagesMap = attackObj.attackData.damages;
			if variable_instance_exists(attackObj, "hitIndex") && attackObj.hitIndex != 0 {
				damagesMap = ds_map_find_value(attackData.extraHitsDamages, attackObj.hitIndex);
			}
			
			// unblockable attacks break guard / kill stamina
			if !attackData.isBlockable && isShielding {
				stamina = -10;
				isShielding = false;
				// damage shield durability (1/10 of attack's damage)
				if type == CombatantTypes.Player {
					var shield = ds_map_find_value(equippedLimbItems,"r");
					isBlockBroken = true;
				}
			}
		}
	}
		
	// limit number of combatants hit per attack based on num targets an attack can hit
	if hasHitMaxNumTargets(assailant,attackObj) exit;
			
	// is this a critical hit?
	var isCriticalHit = calculateIsCriticalHit(attackObj);
	
	// returns [damage, damagesTaken]
	var damageInfo = calculateAllDamages(attackObj,assailant,damagesMap,attackNumber,spell);
	var damage = damageInfo[0];
	var damagesTaken = damageInfo[1];
	
	var actualDamage = damage; // the actual damage of the hit (recieved damage might be less if actual damage exceeds hp)
	// factor combo mode
	if assailant.type == CombatantTypes.Player {
		damage += (assailant.comboModeLevel*.25)*damage;
	}
	
	// HP steal?
	if assailant.hpSteal != 0 {
		var percentStolen = assailant.hpSteal / 100;
		if attackObj.isSpell {
			percentStolen = percentStolen / spell.numberOfProjectiles;
		}
		assailant.hp += actualDamage*percentStolen;
		if assailant.hp > assailant.maxHp assailant.hp = assailant.maxHp;
	}
	
	// Stamina Steal?
	if assailant.staminaSteal != 0 {
		var percentStolen = assailant.staminaSteal / 100;
		if attackObj.isSpell {
			percentStolen = percentStolen / spell.numberOfProjectiles;
		}
		assailant.stamina += actualDamage*percentStolen;
		if assailant.stamina > assailant.maxStamina assailant.stamina = assailant.maxStamina;
	}
		
	// factor critical hit
	if isCriticalHit damage = calculateCriticalHitDamage(attackObj,damage);	
	if damage > hp damage = hp;
	
	if isCriticalHit {
		audio_play_sound_at(snd_hit_critical,__x,__y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
	}
		
	// shielding was broken earlier by an unblockable attack
	if isBlockBroken {
		var shield = ds_map_find_value(equippedLimbItems,"r");
		damageItem(shield,(.2*actualDamage)/3);
	}
		
	// hit a shield
	var hitShield = false;
	if isShielding && script_execute(scr_is_facing,assailant,id) && (attackObj.object_index != obj_attack_zone || attackData.zoneCanHitShield) {
		if gamepad_is_connected(global.gamePadIndex) && attackObj != noone && !attackObj.isRanged {
			gamepad_set_vibration(global.gamePadIndex,.5,.5);
			global.gameManager.alarm[1] = 10;
		}
		hitShield = true;
		handleBlockedAttack(attackObj,assailant,damagesTaken,actualDamage,isCriticalHit,itemHitWith,attackData);
	}
	// hit
	else if !isShielding || !scr_is_facing(assailant,id) {		
		if gamepad_is_connected(global.gamePadIndex) && type == CombatantTypes.Player {
			gamepad_set_vibration(global.gamePadIndex,1,1);
			// duration of vibration is: 20% hp is 20 frames, 0% hp is 1 frame
			var percentOfHp = actualDamage / maxHp;
			var duration = (95*percentOfHp)+1;
			global.gameManager.alarm[1] = duration;
		}
		// this is not vocal stuff, just stuff like metal on metal, metal on flesh
		if array_length_1d(soundsWhenHit) != 0 {
			randomize();
			var rand = round(random_range(0,array_length_1d(soundsWhenHit)-1));
			var snd = soundsWhenHit[rand];
			if snd && snd != noone {
				audio_play_sound_at(snd,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
			}
		}
		
		handleUnblockedAttack(attackObj,assailant,damage,actualDamage,isCriticalHit,itemHitWith);
		isBeingHit = true;
		alarm[5] = 5;
	}
	
	// if this is the first time an enemy was hit, show the hp of the enemy
	if type == CombatantTypes.Enemy && !showHp {
		showHp = true;
	}
	
	// STAGGER OR FLINCH
	if (attackData == noone || !attackData.doesNotStagger) {
		staggerOrFlinch(attackObj,assailant,actualDamage);
	}
	
	
	// destroy most ranged projectiles on impact
	if attackObj.isRanged || attackObj.isSpell || attackObj.object_index == obj_attack_aoe {
		
		if attackObj.isSpell && !attackObj.hasSetAlarm {
			with attackObj {
				alarm[0] = 15;
				visible = 0;
				speed = 0;
				//x = global.x1;
				//y = global.y1;
				hasSetAlarm = true;
				audio_stop_sound(sound);
			}
		} else {
			// instance_destroy(attackObj,true);
			if !attackObj.hasSetAlarm {
				with attackObj {
					alarm[0] = 60;
					if variable_instance_exists(id, "_light_alpha") {
						alarm[0] = 15;
					}
					visible = 0;
					speed = 0;
					hasSetAlarm = true;
				}
			}
			// also destroy the ranged attack's light radius, if it exists
			var attackObjId = attackObj;
			with obj_light_radius {
				if owner == attackObjId {
					instance_destroy(id);
				}
			}
		}
	}
	// destroy melee attack objects if they hit a shield (otherwise the weapon will take durability damage every frame)
	//else if attackObj.isMelee && hitShield instance_destroy(attackObj);
		
	// combo
	if assailant.type == CombatantTypes.Player {
		assailant.comboNumber += 1;
		assailant.comboFrame = 0;
		assailant.comboEffectiveNumber += 1;
	}
	// get out of wary state
	if state == CombatantStates.Wary {
		hasCalculatedWillDodge = false;
		hasCalculatedWillShield = false;
		state = CombatantStates.Idle;
	}
		
	// update enemy data for room persistence, if this combatant is an enemy
	if type == CombatantTypes.Enemy {
		//enemyData.hp = hp;
		updatePersistentElementProperty(id,"Hp",hp);
	}
	
	ds_map_destroy(damagesTaken); damagesTaken = -1;
}


