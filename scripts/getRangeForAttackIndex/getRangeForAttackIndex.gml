/// getRangeForAttackIndex(attackIndex,isMelee)
/// @param attackIndex
/// @param isMelee 

var ind = argument[0];
var isMelee = argument[1];

var arr = !isMelee ? rangedAttacks : meleeAttacks;

var chain = arr[ind];
var firstAttackObj = chain[0];
return firstAttackObj.minRange; 