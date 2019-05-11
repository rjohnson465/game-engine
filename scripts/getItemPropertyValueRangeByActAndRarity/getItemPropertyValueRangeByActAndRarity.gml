/// getItemPropertyValueRangeByActAndRarity(prop,act,rarity)
/// @param prop
/// @param act
/// @param rarity

var prop = argument[0];
var act = argument[1];
var rarity = argument[2];

// value range varies -- from item act, rarity, and rolled tier

var a1Vals = ds_map_create();
ds_map_replace(a1Vals,
	ModifiableProperties.HpMax,
	[ [1,10], [5,15], [8,18], [12,22] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.HpRegen,
	[ [.05,.2], [.2,.5], [.5,.7], [.7,1] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.StaminaMax,
	[ [1,10], [5,15], [8,18], [12,22] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.StaminaRegen,
	[ [.05,.2], [.2,.5], [.5,.7], [.7,1] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.WeaponTypesDamage,
	[ [1,3], [2,4], [3,7], [5,10] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.CriticalsChance,
	[ [1,5], [3,8], [5,10], [8,10] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.CriticalsDamage,
	[ [1,5], [3,8], [5,10], [8,10] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.PhysicalDamageTypesMultiplier,
	[ [1,3], [2,4], [3,7], [5,10] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.ElementalDamageTypesMultiplier,
	[ [1,3], [2,4], [3,7], [5,10] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.Defenses,
	[ [1,3], [2,4], [3,7], [5,10] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.Poise,
	[ [1,3], [2,4], [3,7], [5,10] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.OffHandDamage,
	[ [1,5], [5,8], [8,10], [10,15] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.HpSteal,
	[ [1,5], [5,8], [8,10], [10,15] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.StaminaSteal,
	[ [1,5], [5,8], [8,10], [10,15] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.GoldDrop,
	[ [1,5], [5,8], [8,10], [10,15] ]);
ds_map_replace(a1Vals,
	ModifiableProperties.XpMultiplier,
	[ [5,10], [10,15], [12,17], [15,20] ]);

var map = noone;
switch act {
	case 1: {
		map = a1Vals; break;
	}
}

var vals = ds_map_find_value(map,prop);
var val = vals[rarity];

ds_map_destroy(a1Vals); a1Vals = -1;

return val;
				
