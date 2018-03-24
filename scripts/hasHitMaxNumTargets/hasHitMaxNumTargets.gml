/// hasHitMaxNumTargets(assailant,attack)
/// @param assailant
/// @param attack

var assailant = argument[0];
var attack = argument[1];

if assailant.type == CombatantTypes.Player {
			
	if !attack.isSpell {
		var weaponNumberOfTargetsArr = attack.weapon.numberOfTargets;
		var attackNumberInChain = attack.attackNumberInChain;
		var weaponNumberOfTargets = weaponNumberOfTargetsArr[attackNumberInChain-1];
		if ds_list_size(attack.combatantsHit) > weaponNumberOfTargets {
			return true;
		}
	} else if attack.isSpell && ds_list_size(attack.combatantsHit) > attack.spell.numberOfTargets {
		return true;
	}
}
else if assailant.type != CombatantTypes.Player 
	&& ds_list_size(attack.combatantsHit) > attack.attackData.numberOfTargets {
		return true;
	}
	
return false;