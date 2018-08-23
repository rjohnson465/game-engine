/// modifyShieldPhysicalBlock(shield, buff)
/// @param shield
/// @param buff

var shield = argument[0];
var buff = argument[1];

var adjustedBuff = 0;
var currentPhysicalBlock = ds_map_find_value(shield.defenses, PHYSICAL);
var newDef = round(currentPhysicalBlock + buff);
if newDef > 100 newDef = 100;
ds_map_replace(shield.defenses, PHYSICAL, newDef);
ds_map_replace(shield.defenses, SLASH, newDef);
ds_map_replace(shield.defenses, PIERCE, newDef);
ds_map_replace(shield.defenses, CRUSH, newDef);

adjustedBuff = newDef - currentPhysicalBlock;
// adjustedBuff is how many effective points were added
ds_map_replace(shield.itemPropertyModifiers, ShieldProperties.PhysicalBlockBonus, adjustedBuff);
ds_map_replace(shield.itemPropertyModifiersPts, ShieldProperties.PhysicalBlockBonus, buff);