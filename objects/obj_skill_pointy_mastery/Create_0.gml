event_inherited();
name = "Get to the Point";
description = "Increases critical hit chance, critical hit damage, and overall damage with rapiers and spears.";
levelMax = 15;

ds_map_replace(bonusesMap,ModifiableProperties.WeaponTypesDamage,0);
ds_map_replace(bonusesMap,ModifiableProperties.CriticalsChance,0);
ds_map_replace(bonusesMap,ModifiableProperties.CriticalsDamage,0);

ds_map_replace(nextLevelBonusesMap,ModifiableProperties.WeaponTypesDamage,1);
ds_map_replace(nextLevelBonusesMap,ModifiableProperties.CriticalsChance,2);
ds_map_replace(nextLevelBonusesMap,ModifiableProperties.CriticalsDamage,5);