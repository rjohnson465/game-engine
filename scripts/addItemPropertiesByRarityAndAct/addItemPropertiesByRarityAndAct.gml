/// addItemPropertiesByRarityAndAct(item,rarity,act,*propsChanceMapAddendums)
/// @param item
/// @param rarity
/// @param act -- determines the intensity of the item property bonus
/// @param *propsChanceMapAddendums

var item = argument[0];
var rarity = argument[1];
var act = argument[2];
var addendums = noone;
if argument_count >=4 {
	addendums = argument[3];
}

var numProps = 0;

// basic properties
var numBasicProps = 0;
randomize();
var rand = random_range(0,100);
// how many basic properties to add? depends on rarity and rng
switch rarity {
	case ItemRarities.Normal: {
		if rand < 50 {
			numBasicProps = 1;
		} else numBasicProps = 2;
		break;
	}
	case ItemRarities.Fine: {
		//numBasicProps = round(random_range(1,3)); break;
		if rand < 30 {
			numBasicProps = 1;
		} else if rand < 70 {
			numBasicProps = 2;
		} else numBasicProps = 3;
		break;
	}
	case ItemRarities.Masterwork: {
		//numBasicProps = round(random_range(1,3)); break;
		if rand < 50 {
			numBasicProps = 1;
		} else if rand < 90 {
			numBasicProps = 2;
		} else numBasicProps = 3;
		break;
	}
	case ItemRarities.Legendary: {
		//numBasicProps = round(random_range(1,3)); break;
		if rand < 50 {
			numBasicProps = 1;
		} else if rand < 90 {
			numBasicProps = 2;
		} else numBasicProps = 3;
		break;
	}
}
numProps += numBasicProps;

var basicPropertiesMap = ds_map_create();
ds_map_replace(basicPropertiesMap,ModifiableProperties.CriticalsChance,5);
ds_map_replace(basicPropertiesMap,ModifiableProperties.CriticalsDamage,5);
ds_map_replace(basicPropertiesMap,ModifiableProperties.WeaponTypesDamage,5);
ds_map_replace(basicPropertiesMap,ModifiableProperties.PhysicalDamageTypesMultiplier,5);
ds_map_replace(basicPropertiesMap,ModifiableProperties.ElementalDamageTypesMultiplier,5);
ds_map_replace(basicPropertiesMap,ModifiableProperties.Defenses,5);

// apply relevant addendums to basicPropertiesMap
if addendums != noone {
	for (var i = 0; i < array_length_1d(addendums); i++) {
		var el = addendums[i];
		var prop = el[0]; var val = el[1];
		if ds_map_find_value(basicPropertiesMap,prop) != undefined {
			ds_map_replace(basicPropertiesMap,prop,val);
		}
	}
}

// choose numBasicProps distinct properties from basicProperties map
for (var i = 0; i < numBasicProps; i++) {
	addItemPropertyByRarityAndAct(item,basicPropertiesMap,act,rarity);
}

// rare properties
var numRareProps = 0;
randomize();
var rand = random_range(0,100);
switch rarity {
	case ItemRarities.Normal: {
		//numRareProps = round(random_range(0,1)); break;
		if rand < 50 {
			numRareProps = 0;
		} else if rand < 100 {
			numRareProps = 1;
		} else numRareProps = 0;
		break;
	}
	case ItemRarities.Fine: {
		//numRareProps = round(random_range(0,2)); break;
		if rand < 25 {
			numRareProps = 0;
		} else if rand < 70 {
			numRareProps = 1;
		} else numRareProps = 2;
		break;
	}
	case ItemRarities.Masterwork: {
		//numRareProps = round(random_range(1,2)); break;
		if rand < 60 {
			numRareProps = 1;
		} else if rand < 100 {
			numRareProps = 2;
		} else numRareProps = 2;
		break;
	}
	case ItemRarities.Legendary: {
		//numRareProps = round(random_range(1,2)); break;
		if rand < 60 {
			numRareProps = 1;
		} else if rand < 100 {
			numRareProps = 2;
		} else numRareProps = 2;
		break;
	}
}
// do not exceed 5 properties total
if numProps + numRareProps > 5 {
	numRareProps -= ((numProps + numRareProps)-5);
}
numProps += numRareProps;

var rarePropertiesMap = ds_map_create();
ds_map_replace(rarePropertiesMap,ModifiableProperties.Poise,5);
ds_map_replace(rarePropertiesMap,ModifiableProperties.XpMultiplier,5);
ds_map_replace(rarePropertiesMap,ModifiableProperties.HpMax,5);
ds_map_replace(rarePropertiesMap,ModifiableProperties.StaminaMax,5);
ds_map_replace(rarePropertiesMap,ModifiableProperties.OffHandDamage,5);

// apply relevant addendums to rarePropertiesMap
if addendums != noone {
	for (var i = 0; i < array_length_1d(addendums); i++) {
		var el = addendums[i];
		var prop = el[0]; var val = el[1];
		if ds_map_find_value(rarePropertiesMap,prop) != undefined {
			ds_map_replace(rarePropertiesMap,prop,val);
		}
	}
}

// choose numRareProps distinct properties from rarePropertiesMap
for (var i = 0; i < numRareProps; i++) {
	addItemPropertyByRarityAndAct(item,rarePropertiesMap,act,rarity);
}

// vrare properties
var numVrareProps = 0;
randomize();
var rand = random_range(0,100);
// TODO -- more control over how many vrare props
// i.e. 90% chance of 0 vrare props for Normal Item
switch rarity {
	case ItemRarities.Normal: {
		//numVrareProps = round(random_range(0,1)); break;
		if rand < 90 {
			numVrareProps = 0;
		} else if rand < 100 {
			numVrareProps = 1;
		} else numVrareProps = 2;
		break;
	}
	case ItemRarities.Fine: {
		//numVrareProps = round(random_range(0,1)); break;
		if rand < 75 {
			numVrareProps = 0;
		} else if rand < 100 {
			numVrareProps = 1;
		} else numVrareProps = 2;
		break;
	}
	case ItemRarities.Masterwork: {
		//numVrareProps = round(random_range(0,2)); break;
		if rand < 40 {
			numVrareProps = 0;
		} else if rand < 75 {
			numVrareProps = 1;
		} else numVrareProps = 2;
		break;
	}
	case ItemRarities.Legendary: {
		//numVrareProps = round(random_range(1,2)); break;
		if rand < 50 {
			numVrareProps = 1;
		} else if rand < 100 {
			numVrareProps = 2;
		} else numVrareProps = 2;
		break;
	}
}
// do not exceed 5 properties total
if numProps + numVrareProps > 5 {
	numVrareProps -= ((numProps + numVrareProps)-5);
}
numProps += numVrareProps;

var vrarePropertiesMap = ds_map_create();
ds_map_replace(vrarePropertiesMap,ModifiableProperties.HpSteal,5);
ds_map_replace(vrarePropertiesMap,ModifiableProperties.StaminaSteal,5);
ds_map_replace(vrarePropertiesMap,ModifiableProperties.HpRegen,5);
ds_map_replace(vrarePropertiesMap,ModifiableProperties.StaminaRegen,5);

// apply relevant addendums to vrarePropertiesMap
if addendums != noone {
	for (var i = 0; i < array_length_1d(addendums); i++) {
		var el = addendums[i];
		var prop = el[0]; var val = el[1];
		if ds_map_find_value(vrarePropertiesMap,prop) != undefined {
			ds_map_replace(vrarePropertiesMap,prop,val);
		}
	}
}

// choose numVrareProps distinct properties from vrarePropertiesMap
for (var i = 0; i < numVrareProps; i++) {
	addItemPropertyByRarityAndAct(item,vrarePropertiesMap,act,rarity);
}

ds_map_destroy(basicPropertiesMap);
ds_map_destroy(rarePropertiesMap);
ds_map_destroy(vrarePropertiesMap);