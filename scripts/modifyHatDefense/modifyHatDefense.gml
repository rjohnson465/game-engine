/// modifyHatDefense(hat, buff, defenseType)
/// @param hat
/// @param buff
/// @param defenseType

var hat = argument[0];
var buff = argument[1];
var defenseType = argument[2];

var adjustedBuff = 0;
var currentDefense = ds_map_find_value(hat.defenses, defenseType);

//var newDefense = round(currentDefense * (1 + (buff/100)));
var defBoost = round((buff/6)*hat.act);
var newDefense = round(currentDefense+defBoost);
adjustedBuff = defBoost;
if newDefense == currentDefense {
	newDefense += 1;
	adjustedBuff = 1;
}

/*var fraction = newDefense / currentDefense;
adjustedBuff = (fraction - 1)*100;*/
ds_map_replace(hat.defenses, defenseType, newDefense);
var prop = noone;
switch defenseType {
	case SLASH: {
		prop = HatProperties.SlashDefenseBonus; break;
	}
	case CRUSH: {
		prop = HatProperties.CrushDefenseBonus; break;
	}
	case PIERCE: {
		prop = HatProperties.PierceDefenseBonus; break;
	}
}
// adjustedBuff is how many defense points were added
ds_map_replace(hat.itemPropertyModifiers, prop, adjustedBuff);
ds_map_replace(hat.itemPropertyModifiersPts, prop, buff);