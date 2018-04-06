event_inherited();
name = "Brute";
description = "Increases critical hit chance, critical hit damage, and overall damage with 1H and 2H clubs.";
levelMax = 15;
skillSprite = spr_skill_clubmastery;

ds_map_replace(bonusesMap,ModifiableProperties.WeaponTypesDamage,0);
ds_map_replace(bonusesMap,ModifiableProperties.CriticalsChance,0);
ds_map_replace(bonusesMap,ModifiableProperties.CriticalsDamage,0);

ds_map_replace(nextLevelBonusesMap,ModifiableProperties.WeaponTypesDamage,1);
ds_map_replace(nextLevelBonusesMap,ModifiableProperties.CriticalsChance,2);
ds_map_replace(nextLevelBonusesMap,ModifiableProperties.CriticalsDamage,5);