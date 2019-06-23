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

// Declare properties map and apply addendums

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

var rarePropertiesMap = ds_map_create();
ds_map_replace(rarePropertiesMap,ModifiableProperties.PoiseMax,5);
ds_map_replace(rarePropertiesMap,ModifiableProperties.XpMultiplier,5);
ds_map_replace(rarePropertiesMap,ModifiableProperties.HpMax,5);
ds_map_replace(rarePropertiesMap,ModifiableProperties.StaminaMax,5);
ds_map_replace(rarePropertiesMap,ModifiableProperties.OffHandDamage,5);
ds_map_replace(rarePropertiesMap,ModifiableProperties.GoldDrop,5);

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

//var numProps = 0;

var numProps = round(random_range(1,5));

var numBasicProps = 0; var numRareProps = 0; var numVrareProps = 0;

// roll for up to 2 vrares -- 20% chance each
for (var i = 0; i < 2; i++) {
	randomize();
	var rand = random_range(0,100);
	if rand < 20 && numVrareProps < numProps {
		numVrareProps++;
	}
}

// roll for up to 2 rares -- 45% chance each
for (var i = 0; i < 2; i++) {
	randomize();
	var rand = random_range(0,100);
	if rand < 45 && (numVrareProps + numRareProps) < numProps {
		numRareProps++;
	}
}

if (numVrareProps + numRareProps) < numProps {
	numBasicProps = numProps - numVrareProps - numRareProps;
}


/*
// basic properties
var numBasicProps = 0;

numProps += numBasicProps;

// rare properties
var numRareProps = 0;

// do not exceed 5 properties total
if numProps + numRareProps > 5 {
	numRareProps -= ((numProps + numRareProps)-5);
}
numProps += numRareProps;

// vrare properties
var numVrareProps = 0;

// do not exceed 5 properties total
if numProps + numVrareProps > 5 {
	numVrareProps -= ((numProps + numVrareProps)-5);
}
numProps += numVrareProps;*/



/*
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
		if rand < 10 {
			numBasicProps = 0;
		}
		else if rand < 30 {
			numBasicProps = 1;
		} else if rand < 70 {
			numBasicProps = 2;
		} else numBasicProps = 3;
		break;
	}
	case ItemRarities.Masterwork: {
		if rand < 25 {
			numBasicProps = 0;
		}
		else if rand < 50 {
			numBasicProps = 1;
		} else if rand < 90 {
			numBasicProps = 2;
		} else numBasicProps = 3;
		break;
	}
	case ItemRarities.Legendary: {
		if rand < 25 {
			numBasicProps = 0;
		}
		else if rand < 50 {
			numBasicProps = 1;
		} else if rand < 90 {
			numBasicProps = 2;
		} else numBasicProps = 3;
		break;
	}
}*/



/*randomize();
var rand = random_range(0,100);
switch rarity {
	case ItemRarities.Normal: {
		if rand < 50 {
			numRareProps = 0;
		} else if rand < 100 {
			numRareProps = 1;
		} else numRareProps = 0;
		break;
	}
	case ItemRarities.Fine: {
		if rand < 25 {
			numRareProps = 0;
		} else if rand < 70 {
			numRareProps = 1;
		} else numRareProps = 2;
		break;
	}
	case ItemRarities.Masterwork: {
		if rand < 60 {
			numRareProps = 1;
		} else if rand < 100 {
			numRareProps = 2;
		} else numRareProps = 2;
		break;
	}
	case ItemRarities.Legendary: {
		if rand < 60 {
			numRareProps = 1;
		} else if rand < 100 {
			numRareProps = 2;
		} else numRareProps = 2;
		break;
	}
}
*/

/*
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
}*/


// get some # of pts to put into this item's improvements.
// "pts" is a standardized unit used to assess item value / quality of buffs
// "pts" are applied a bit differently depending on which proprty they're being applied to 
// # of pts is dependent on rarirty and act
var pts = 0;
var arr = [0,10,10,20,20,30,30,40];

randomize();
switch rarity {
	case ItemRarities.Normal: {
		pts = round(random_range(arr[0], arr[1]));
		break;
	}
	case ItemRarities.Fine: {
		pts = round(random_range(arr[2], arr[3]));
		break;
	}
	case ItemRarities.Masterwork: {
		pts = round(random_range(arr[4], arr[5]));
		break;
	}
	case ItemRarities.Legendary: {
		pts = round(random_range(arr[6], arr[7]));
		break;
	}
}

pts *= act;
item._pts = pts;
var buffAmounts = splitMIntoNParts(pts,numProps);
var buffIndex = 0;

// choose numBasicProps distinct properties from basicProperties map
for (var i = 0; i < numBasicProps; i++) {
	addItemPropertyByPtsAndAct(item,basicPropertiesMap,act,buffAmounts[buffIndex]);
	buffIndex++;
}

// choose numRareProps distinct properties from rarePropertiesMap
for (var i = 0; i < numRareProps; i++) {
	addItemPropertyByPtsAndAct(item,rarePropertiesMap,act,buffAmounts[buffIndex]);
	buffIndex++;
}

// choose numVrareProps distinct properties from vrarePropertiesMap
for (var i = 0; i < numVrareProps; i++) {
	addItemPropertyByPtsAndAct(item,vrarePropertiesMap,act,buffAmounts[buffIndex]);
	buffIndex++;
}

ds_map_destroy(basicPropertiesMap); basicPropertiesMap = -1;
ds_map_destroy(rarePropertiesMap); rarePropertiesMap = -1;
ds_map_destroy(vrarePropertiesMap); vrarePropertiesMap = -1;