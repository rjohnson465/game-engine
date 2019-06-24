/// defineItemPropertyRangesForPts()
/// static -- called at the beginning of the game to define a global map ranges ModifiableProperties have (min / max) which are used
/// in getItemPropertyValueByPts to affect change in a Ring via pts

global.itemPropertyRangesForPts = ds_map_create();
ds_map_replace(global.itemPropertyRangesForPts, ModifiableProperties.HpMax, [1,20]);
ds_map_replace(global.itemPropertyRangesForPts, ModifiableProperties.StaminaMax, [1,20]);
ds_map_replace(global.itemPropertyRangesForPts, ModifiableProperties.HpRegen, [.1,.5]);
ds_map_replace(global.itemPropertyRangesForPts, ModifiableProperties.StaminaRegen, [.1,.5]);
ds_map_replace(global.itemPropertyRangesForPts, ModifiableProperties.WeaponTypesDamage, [1,10]);
ds_map_replace(global.itemPropertyRangesForPts, ModifiableProperties.CriticalsDamage, [1,10]);
ds_map_replace(global.itemPropertyRangesForPts, ModifiableProperties.CriticalsChance, [1,5]);
ds_map_replace(global.itemPropertyRangesForPts, ModifiableProperties.OffHandDamage, [1,20]);
ds_map_replace(global.itemPropertyRangesForPts, ModifiableProperties.PhysicalDamageTypesMultiplier, [1,20]);
ds_map_replace(global.itemPropertyRangesForPts, ModifiableProperties.ElementalDamageTypesMultiplier, [1,20]);
ds_map_replace(global.itemPropertyRangesForPts, ModifiableProperties.Defenses, [1,10]);
ds_map_replace(global.itemPropertyRangesForPts, ModifiableProperties.PoiseMax, [1,15]);
ds_map_replace(global.itemPropertyRangesForPts, ModifiableProperties.HpSteal, [1,15]);
ds_map_replace(global.itemPropertyRangesForPts, ModifiableProperties.StaminaSteal, [1,15]);
ds_map_replace(global.itemPropertyRangesForPts, ModifiableProperties.GoldDrop, [1,15]);
ds_map_replace(global.itemPropertyRangesForPts, ModifiableProperties.XpMultiplier, [1,15]);