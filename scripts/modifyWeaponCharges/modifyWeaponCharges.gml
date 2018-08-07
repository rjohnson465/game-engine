/// modifyWeaponCharges(weapon, buff)
/// @param weapon
/// @param buff

var weapon = argument[0];
var buff = argument[1];

var adjustedBuff = round(buff);
// simple increment charges by buff amount
weapon.chargesMax += adjustedBuff;
weapon.charges += adjustedBuff;
ds_map_replace(weapon.itemPropertyModifiers, WeaponProperties.ChargesBonus, adjustedBuff);
