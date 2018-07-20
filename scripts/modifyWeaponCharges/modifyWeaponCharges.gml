/// modifyWeaponCharges(weapon, buff)
/// @param weapon
/// @param buff

var weapon = argument[0];
var buff = argument[1];

// simple increment charges by buff amount
weapon.chargesMax += round(buff);
weapon.charges += round(buff);
