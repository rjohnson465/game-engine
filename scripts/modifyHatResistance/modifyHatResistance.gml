/// modifyHatElementalResistance(hat, buff, element)
/// @param hat
/// @param buff
/// @param element

var hat = argument[0];
var element = argument[2];
var buff = argument[1];

var resBoost = round(((5*buff)/12)); // 0 buff = 0% boost, 60 buff = 25% boost
var currentElementalRes = ds_map_find_value(hat.defenses, element);
var newDef = round(currentElementalRes + resBoost);
if newDef > 100 newDef = 100;
ds_map_replace(hat.defenses, element, newDef);
ds_map_replace(hat.itemPropertyModifiers, HatProperties.ElementalDefenseBonus, [element, round(resBoost)]);
ds_map_replace(hat.itemPropertyModifiersPts, HatProperties.ElementalDefenseBonus, [element, buff]);