if hp < 1 exit;
// only regen stamina when moving or idle
var SHIFT = keyboard_check(vk_shift) 
			|| gamepad_button_check(global.player.gamePadIndex, gp_stickl)
			|| global.player.isHoldingSprintButton;
if	 stamina < maxStamina && (state == CombatantStates.Idle || state == CombatantStates.Moving 
	|| (state == CombatantStates.Attacking && type == CombatantTypes.Player)) {
	// do not regen stamina while dashing
	if	type != CombatantTypes.Player || (type == CombatantTypes.Player && !SHIFT)
		|| (type == CombatantTypes.Player && state == CombatantStates.Attacking)
	{
		// stamina regens slower if shielding
		if isShielding {
			stamina += (.5*staminaRegen)/30;
		}
		else if (type == CombatantTypes.Player && state == CombatantStates.Attacking) {
			var lhItem = ds_map_find_value(equippedLimbItems,"l");
			if lhItem.isTwoHanded && lhItem.subType == HandItemTypes.Ranged /*&& isReadyToFire*/ {
				stamina += (.5*staminaRegen)/30;
			}
		}
		else stamina += staminaRegen/30;
	}
}
if hp < maxHp {
	hp += hpRegen/30;
	// update the data for this combatant if not player
	if type != CombatantTypes.Player {
		updatePersistentElementProperty(id, "Hp", hp);
	}
}

if stamina > maxStamina stamina = maxStamina;
if hp > maxHp hp = maxHp;