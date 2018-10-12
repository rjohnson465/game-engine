/// calculateIsCriticalHit(attackObj)
/// @param attackObj

var attackObj = argument[0];

if attackObj.owner.type == CombatantTypes.Player {
	var player = attackObj.owner;
	randomize();
	var rand = random_range(0,100);
	// melee or ranged attack
	if !attackObj.isSpell {
		var threshold = ds_map_find_value(player.criticalsChance,attackObj.weapon.weaponType);
		if rand <  threshold {
			return true;
		}
		// back stabs are instant criticals
		var ad1 = angle_difference(attackObj.facingDirection,facingDirection);
		//if attackObj.weapon.subType == HandItemTypes.Melee {
		var a1 = ((facingDirection-45)+360)%360;
		var a2 = (facingDirection+45)%360;
		if angleBetween(a1,a2,attackObj.facingDirection) {
			return true;
		}
		//}
	}
	// spell attack
	else {
		if rand < ds_map_find_value(player.criticalsChance,attackObj.spell.spriteName) {
			return true;
		}
	}
}