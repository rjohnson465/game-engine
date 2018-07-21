/// modifyHatDefense(hat, buff, defenseType)
/// @param hat
/// @param buff
/// @param defenseType

var hat = argument[0];
var buff = argument[1];
var defenseType = argument[2];

var currentDefense = ds_map_find_value(hat.defenses, defenseType);
var newDefense = round(currentDefense * (1 + (buff/100)));
if newDefense == currentDefense {
	newDefense += 1;
}
ds_map_replace(hat.defenses, defenseType, newDefense);
