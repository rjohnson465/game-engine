/// modifyShieldElementalBlock(shield, element, buff)
/// @param shield
/// @param element
/// @param buff

var shield = argument[0];
var element = argument[1];
var buff = argument[2];

var currentElementalBlock = ds_map_find_value(shield.defenses, element);
var newDef = round(currentElementalBlock + buff);
ds_map_replace(shield.defenses, element, newDef);