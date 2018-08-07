/// modifyWeaponDurability(shield, buff)
/// @param shield
/// @param buff

var shield = argument[0];
var buff = argument[1];

var adjustedBuff = 0;
var newDurability = round(shield.durabilityMax * (1 + (buff/100)));
if newDurability == shield.durabilityMax {
	newDurability += 1;
}
var fraction = newDurability / shield.durabilityMax;
adjustedBuff = (fraction-1)*100;
shield.durability = newDurability;
shield.durabilityMax = newDurability;

ds_map_replace(shield.itemPropertyModifiers, ShieldProperties.DurabilityBonus, adjustedBuff);