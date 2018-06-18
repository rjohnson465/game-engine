/// addItemPropertyByRarityAndAct(item,propsChanceMap,act,rarity)
/// @param item
/// @param propsChanceMap
/// @param act
/// @param rarity

var item = argument[0];
var propsChanceMap = argument[1];
var act = argument[2];
var rarity = argument[3];

// choose unique property
var propKey = chooseItemPropertyToAdd(item,propsChanceMap);
	
// decide property value "intensity" by act/rarity/rolled tier
var propRange = getItemPropertyValueRangeByActAndRarity(propKey,act,rarity);
randomize();
var rand = random_range(propRange[0],propRange[1]);
// maybe round
if propKey != ModifiableProperties.HpRegen && propKey != ModifiableProperties.StaminaRegen {
	rand = round(rand);
}
var propVal = rand;
	
// might need a macro value
var macro = getPropertyMacro(propKey);
if macro != noone {
	ds_map_replace(item.itemProperties,propKey,[macro,propVal]);
} else {
	ds_map_replace(item.itemProperties,propKey,propVal);
}

updateItemName(item);