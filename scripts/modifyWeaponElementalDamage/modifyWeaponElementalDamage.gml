/// modifyWeaponElementalDamage(weapon, element, buff)
/// @param weapon
/// @param element
/// @param buff

var weapon = argument[0];
var element = argument[1];
var buff = argument[2];

// buff elemental damage based on buff amount
var minDamageBuff = round((buff/6));
var maxDamageBuff = round(minDamageBuff*1.5);
if maxDamageBuff == 0 maxDamageBuff = 1;
var currentElementalDamage = ds_map_find_value(weapon.damages, element);
currentElementalDamage[0] += minDamageBuff;
currentElementalDamage[1] += maxDamageBuff;

ds_map_replace(weapon.damages, element, currentElementalDamage);
// adjustedBuff holds how many points of elemental damage were added

// ds_map_replace(weapon.itemPropertyModifiers, WeaponProperties.ElementalDamageBonus, [element, (minDamageBuff+maxDamageBuff)]);
ds_map_replace(weapon.itemPropertyModifiers, WeaponProperties.ElementalDamageBonus, [element, buff]);
ds_map_replace(weapon.itemPropertyModifiersPts, WeaponProperties.ElementalDamageBonus, [element, buff]);