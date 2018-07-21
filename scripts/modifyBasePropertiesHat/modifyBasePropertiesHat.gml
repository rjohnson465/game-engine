/// modifyBasePropertiesHat(hat, rarity, pointsToSpend)
/// @param hat
/// @param rarity
/// @param pointsToSpend

var hat = argument[0];
var rarity = argument[1];
var pts = argument[2];

randomize();
var numPropsToBuff = round(random_range(1, HatProperties.length));
var buffAmounts = splitMIntoNParts(pts,numPropsToBuff);
// pick buffAmounts random properties from HatProperties enum
var propsToBuff = pickNUniqueNumbersInRange(numPropsToBuff,0,HatProperties.length);

for (var i = 0; i < array_length_1d(propsToBuff); i++) {
	var buff = buffAmounts[i];
	var prop = propsToBuff[i];
	switch prop {
		case HatProperties.SlashDefenseBonus: {
			ds_map_replace(hat.itemPropertyModifiers, prop, buff);
			break;
		}
		case HatProperties.CrushDefenseBonus: {
			ds_map_replace(hat.itemPropertyModifiers, prop, buff);
			break;
		}
		case HatProperties.PierceDefenseBonus: {
			ds_map_replace(hat.itemPropertyModifiers, prop, buff);
			break;
		}
		case HatProperties.ElementalDefenseBonus: {
			// need to pick an element macro
			var macro = noone;
			randomize();
			var rand = round(random_range(0,array_length_1d(global.ALL_ELEMENTS)-1));
			macro = global.ALL_ELEMENTS[rand];
			
			// do not buff an elemental resistance to over 100%
			var currentRes = ds_map_find_value(hat.defenses, macro);
			var amountOver100 = (currentRes + buff) - 100;
			var amountTo100 = noone;
			if amountOver100 > 0 {
				amountTo100 = 100-currentRes;
				buff = amountTo100;
				buffAmounts[i] = buff;
				
				// reassign amountOver100 to some other defense buff -- then retrigger this whole loop
				randomize();
				var rand = round(random_range(1,3));
				var propToAddTo = noone;
				if rand == 1 propToAddTo = HatProperties.SlashDefenseBonus;
				if rand == 2 propToAddTo = HatProperties.CrushDefenseBonus;
				if rand == 3 propToAddTo = HatProperties.PierceDefenseBonus;
				
				var appliedOverage = false;
				for (var j = 0; j < propsToBuff; j++) {
					var p = propsToBuff[j];
					if p == propToAddTo {
						buffAmounts[j] += amountOver100;
						appliedOverage = true;
					}
				}
				
				if !appliedOverage {
					propsToBuff[array_length_1d(propsToBuff)] = propToAddTo;
					buffAmounts[array_length_1d(buffAmounts)] = amountOver100;
				}
				i = 0;
				
			} else {
				ds_map_replace(hat.itemPropertyModifiers, prop, [macro, buff]);
			}
			break;
		}
	}
}