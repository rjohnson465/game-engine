/// calculateCriticalHitDamage(attackObj,damage)
/// @param attackObj
/// @param damage
var attackObj = argument[0];
var damage = argument[1];

var criticalsDamageMap = attackObj.owner.criticalsDamage;
var t = noone;
if attackObj.isSpell {
	t = attackObj.spell.spriteName;
} else {
	t = attackObj.weapon.weaponType;
}
var modifier = ds_map_find_value(criticalsDamageMap,t)/100
damage += damage*modifier;
return damage;