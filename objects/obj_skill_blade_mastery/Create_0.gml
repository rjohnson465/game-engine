event_inherited();
name = "Blade Dancer";
description = "Increases critical hit chance, critical hit damage, and overall damage with 1H swords, 2H swords, and daggers.";
levelMax = 15;
skillSprite = spr_skill_blademastery;

ds_map_replace(bonusesMap,ModifiableProperties.WeaponTypesDamage,0);
ds_map_replace(bonusesMap,ModifiableProperties.CriticalsChance,0);
ds_map_replace(bonusesMap,ModifiableProperties.CriticalsDamage,0);

ds_map_replace(nextLevelBonusesMap,ModifiableProperties.WeaponTypesDamage,1);
ds_map_replace(nextLevelBonusesMap,ModifiableProperties.CriticalsChance,2);
ds_map_replace(nextLevelBonusesMap,ModifiableProperties.CriticalsDamage,5);