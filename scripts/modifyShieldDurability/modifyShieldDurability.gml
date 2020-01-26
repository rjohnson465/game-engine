/// modifyWeaponDurability(shield, buff)
/// @param shield
/// @param buff

var shield = argument[0];
var buff = argument[1];

if !instance_exists(shield) || !object_is_ancestor(shield.object_index, obj_shield_parent) exit;
if !is_real(buff) exit;

var adjustedBuff = round(buff);
var newDurability = round(shield.durabilityMax + buff);
if newDurability == shield.durabilityMax {
	newDurability += 1;
}
shield.durability = newDurability;
shield.durabilityMax = newDurability;
// adjustedBuff is how many durability points we added
ds_map_replace(shield.itemPropertyModifiers, ShieldProperties.DurabilityBonus, adjustedBuff);
ds_map_replace(shield.itemPropertyModifiersPts, ShieldProperties.DurabilityBonus, adjustedBuff);