if hp < 1 exit;
// only regen stamina when moving or idle
var SHIFT = keyboard_check(vk_shift) 
			|| gamepad_button_check(global.player.gamePadIndex, gp_stickl)
			|| global.player.isHoldingSprintButton;
if	 stamina < maxStamina && (state == CombatantStates.Idle || state == CombatantStates.Moving 
	|| (state == CombatantStates.Attacking && type == CombatantTypes.Player)) {
	// do not regen stamina while dashing
	if	type != CombatantTypes.Player || (type == CombatantTypes.Player && (!SHIFT || sprintNeedsReset))
		|| (type == CombatantTypes.Player && state == CombatantStates.Attacking)
	{
		var lamplightCondi = ds_map_find_value(conditionLevels, "spr_item_lamplight");
		// stamina regens slower if shielding
		if isShielding {
			stamina += (.5*staminaRegen)/room_speed;
			if lamplightCondi != undefined && lamplightCondi > 0 {
				stamina += ((.5*staminaRegen) / room_speed);
			}
		}
		else if (type == CombatantTypes.Player && state == CombatantStates.Attacking) {
			var lhItem = ds_map_find_value(equippedLimbItems,"l");
			if lhItem.isTwoHanded && lhItem.subType == HandItemTypes.Ranged {
				stamina += (.5*staminaRegen)/room_speed;
					if lamplightCondi != undefined && lamplightCondi > 0 {
					stamina += ((.5*staminaRegen) / room_speed);
				}
			}
		}
		else {
			stamina += staminaRegen/room_speed;
			if lamplightCondi != undefined && lamplightCondi > 0 {
				stamina += ((1*staminaRegen) / room_speed);
			}
		}
	}
}
if hp < maxHp {
	hp += hpRegen/room_speed;
	var lamplightCondi = ds_map_find_value(conditionLevels, "spr_item_lamplight");
	if lamplightCondi != undefined && lamplightCondi > 0 {
		hp += hpRegen / room_speed;
	}
	// update the data for this combatant if not player
	if type != CombatantTypes.Player {
		updatePersistentElementProperty(id, "Hp", hp);
	}
}

if stamina > maxStamina stamina = maxStamina;
if hp > maxHp hp = maxHp;

// regen poise too
if poiseCurrent < poiseMax {
	var pRegenAmount = isShielding ? ((poiseRegen/room_speed)/2) : poiseRegen/room_speed;
	poiseCurrent += pRegenAmount;
	if poiseCurrent > poiseMax {
		poiseCurrent = poiseMax;
	}
}

if poiseCurrent < 0 {
	poiseCurrent = 0;
}

if poiseCurrent > poiseMax {
	poiseCurrent = poiseMax;
}

// TODO: decrement elemental conditions buildup
var ck = ds_map_find_first(conditionsBuildupMap);
for (var i = 0; i < ds_map_size(conditionsBuildupMap); i++) {
	
	var currentBuildupAmount = ds_map_find_value(conditionsBuildupMap, ck);
	
	// decrement buildup amount
	if currentBuildupAmount > 0 {
		// 4 per second, affected by elemental resistance
		var res = ds_map_find_value(defenses, ck);
		var resMod = 1;
		if res >= 0 {
			resMod = 1 + (res / 100);
		} else {
			resMod = 1 - (abs(res) / 100);
		}
		var decrementAmount = 4 * resMod;
		// slowest possible decrementAmount is .5 perc / sec
		if decrementAmount <= .5 {
			decrementAmount = .5;
		}
		var newBuildupAmount = currentBuildupAmount - (decrementAmount / 30);
		ds_map_replace(conditionsBuildupMap, ck, newBuildupAmount);
	}
	
	ck = ds_map_find_next(conditionsBuildupMap, ck);
}