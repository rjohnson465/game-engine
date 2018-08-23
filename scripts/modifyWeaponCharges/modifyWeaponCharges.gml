/// modifyWeaponCharges(weapon, buff)
/// @param weapon
/// @param buff

var weapon = argument[0];
var buff = argument[1];

var adjustedBuff = round(buff);
// simple increment charges by buff amount
weapon.chargesMax += adjustedBuff;
weapon.charges += adjustedBuff;
// adjusted buff is simply how many charges were added to the item
ds_map_replace(weapon.itemPropertyModifiers, WeaponProperties.ChargesBonus, adjustedBuff);
ds_map_replace(weapon.itemPropertyModifiersPts, WeaponProperties.ChargesBonus, buff);