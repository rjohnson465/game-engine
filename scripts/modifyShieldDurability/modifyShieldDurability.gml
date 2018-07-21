/// modifyWeaponDurability(shield, buff)
/// @param shield
/// @param buff

var shield = argument[0];
var buff = argument[1];

var newDurability = round(shield.durabilityMax * (1 + (buff/100)));
if newDurability == shield.durabilityMax {
	newDurability += 1;
}
shield.durability = newDurability;
shield.durabilityMax = newDurability;
