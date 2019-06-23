/// hasHitMaxDestructables(assailant,attack)
/// @param assailant
/// @param attack

var assailant = argument[0];
var attack = argument[1];

if !variable_instance_exists(attack, "destructablesHit") return false;
if attack.destructablesHit == undefined || !attack.destructablesHit return false;
if !ds_exists(attack.destructablesHit, ds_type_list) return false;

if assailant.type == CombatantTypes.Player {
			
	if !attack.isSpell {
		var weaponNumberOfTargetsArr = attack.weapon.numberOfTargets;
		var attackNumberInChain = attack.attackNumberInChain;
		var weaponNumberOfTargets = weaponNumberOfTargetsArr[attackNumberInChain-1];
		if ds_list_size(attack.destructablesHit) >= weaponNumberOfTargets {
			return true;
		}
	} else if attack.isSpell && ds_list_size(attack.destructablesHit) >= attack.spell.numberOfTargets {
		return true;
	}
}
else if assailant.type != CombatantTypes.Player 
	&& ds_list_size(attack.destructablesHit) > attack.attackData.numberOfTargets {
		return true;
	}
	
return false;