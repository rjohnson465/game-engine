/// modifyHatElementalResistance(hat, buff, element)
/// @param hat
/// @param buff
/// @param element

var hat = argument[0];
var element = argument[2];
var buff = argument[1];

var currentElementalRes = ds_map_find_value(hat.defenses, element);
var newDef = round(currentElementalRes + buff);
if newDef > 100 {
	newDef = 100;
}
ds_map_replace(hat.defenses, element, newDef);