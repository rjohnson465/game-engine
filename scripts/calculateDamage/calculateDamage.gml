/// calculateDamage(attack)
/// @param attack
/// Pre-Condition -- must be called by the victim in a collision event with attackObj

if hp <= 0 exit;
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

// if combatant has not been hit with this instance before (only get hit with an attack once)
if ds_list_find_index(beenHitWith,attackObj.id) != -1 exit;

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
		
	if !attackObj.combatantsHit {
		attackObj.combatantsHit = ds_list_create();
	}
		
	ds_list_add(attackObj.combatantsHit,id);
	ds_list_add(beenHitWith,attackObj.id);
		
	// run to get __x and __y (collision point where attack meet this combatant)
	script_execute(scr_collision_point,id,attackObj.id);
		
	var assailant = attackObj.owner;
	var damage = 0;
	var damagesMap = noone;
	var spell = noone;
	var attackNumber; var attackNumberInChain;
	var percentCharged = 1;
	var isBlockBroken = false;
	// case: AI combatant as assailant
	var attackData = noone;
	// case: Player as assailant; this could be a melee weapon, ranged weapon, or spell 
	var itemHitWith = noone;
	// find damages map for the attack received (Player damage map dependent on item, enemy / ally damage map is hardcoded)
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
		var isRanged = attackObj.isRanged;
		var attackChain = isRanged ? attackObj.owner.rangedAttacks[attackNumber-1] : attackObj.owner.meleeAttacks[attackNumber-1];
		attackData = attackChain[attackNumberInChain-1];
		damagesMap = attackData.damages;
			
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
		
	// shielding was broken earlier by an unblockable attack
	if isBlockBroken {
		var shield = ds_map_find_value(equippedLimbItems,"r");
		damageItem(shield,.2*actualDamage);
	}
		
	// hit a shield
	var hitShield = false;
	if isShielding && script_execute(scr_is_facing,assailant,id) {
		hitShield = true;
		handleBlockedAttack(attackObj,assailant,damagesTaken,actualDamage,isCriticalHit,itemHitWith,attackData);
	}
	// hit
	if !isShielding || !scr_is_facing(assailant,id) {			
		handleUnblockedAttack(attackObj,assailant,damage,actualDamage,isCriticalHit,itemHitWith);
	}
	
	// if this is the first time an enemy was hit, show the hp of the enemy
	if type == CombatantTypes.Enemy && !showHp {
		showHp = true;
	}
	
	// STAGGER OR FLINCH
	staggerOrFlinch(attackObj,assailant,actualDamage);
	
	
	
	// destroy most ranged projectiles on impact
	if attackObj.isRanged || (attackObj.isSpell) {
		//ds_list_destroy(attackObj.combatantsHit);
		instance_destroy(attackObj,true);
		// also destroy the ranged attack's light radius, if it exists
		var attackObjId = attackObj;
		with obj_light_radius {
			if owner == attackObjId {
				instance_destroy(id);
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
		state = CombatantStates.Idle;
	}
		
	// update enemy data for room persistence, if this combatant is an enemy
	if enemyData != noone && type == CombatantTypes.Enemy {
		enemyData.hp = hp;
	}
	
	ds_map_destroy(damagesTaken);
}


