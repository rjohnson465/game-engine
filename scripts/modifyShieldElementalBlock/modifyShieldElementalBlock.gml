/// modifyShieldElementalBlock(shield, element, buff)
/// @param shield
/// @param element
/// @param buff

var shield = argument[0];
var element = argument[1];
var buff = argument[2];

var adjustedBuff = 0;
var currentElementalBlock = ds_map_find_value(shield.defenses, element);
var newDef = round(currentElementalBlock + buff);
if newDef > 100 newDef = 100;
ds_map_replace(shield.defenses, element, newDef);

adjustedBuff = newDef - currentElementalBlock;
ds_map_replace(shield.itemPropertyModifiers, ShieldProperties.ElementalBlockBonus, [element, adjustedBuff]);