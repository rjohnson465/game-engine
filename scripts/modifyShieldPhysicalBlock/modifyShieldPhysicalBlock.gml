/// modifyShieldPhysicalBlock(shield, buff)
/// @param shield
/// @param buff

var shield = argument[0];
var buff = argument[1];

var currentPhysicalBlock = ds_map_find_value(shield.defenses, PHYSICAL);
var newDef = round(currentPhysicalBlock + buff);
ds_map_replace(shield.defenses, PHYSICAL, newDef);
ds_map_replace(shield.defenses, SLASH, newDef);
ds_map_replace(shield.defenses, PIERCE, newDef);
ds_map_replace(shield.defenses, CRUSH, newDef);