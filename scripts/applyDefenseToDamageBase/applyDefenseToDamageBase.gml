/// applyDefenseToDamageBase(damageBase, defense)
/// @param damageBase
/// @param defense

var damageBase = argument0;
var defense = argument1;

var factor = defense / damageBase;
var reductionPercentage = 0;

if factor <= 1 {
	// when def is 0, take 100% damage. When def is 1x atk, take 70% damage
	reductionPercentage = 1 - (.3*(factor));
}
else if factor > 1 && factor < 2 {
	// when def is between 1x and 2x attack, take between 70% and 50% damage
	reductionPercentage = (-.2*(factor)) + .9;
}
else {
	// when def is 2x atk, take 50% damage, when def is 3x attack, take 33% damage...
	reductionPercentage = 1 / factor;
}

var newAtk = damageBase * reductionPercentage;

return newAtk;