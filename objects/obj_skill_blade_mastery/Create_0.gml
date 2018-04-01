event_inherited();
name = "Git Gud with Slashy Slashy";
description = "Increases critical hit chance, critical hit damage, and overall damage with 1H swords, 2H swords, and daggers .";

#macro DAMAGE " base damage"
#macro CRITCHANCE " % critical hit chance"
#macro CRITDAMAGE " % critical hit damage"

ds_map_replace(bonusesMap,ModifiableProperties.WeaponTypesDamage,0);
ds_map_replace(bonusesMap,ModifiableProperties.CriticalsChance,0);
ds_map_replace(bonusesMap,ModifiableProperties.CriticalsDamage,0);

ds_map_replace(nextLevelBonusesMap,ModifiableProperties.WeaponTypesDamage,1);
ds_map_replace(nextLevelBonusesMap,ModifiableProperties.CriticalsChance,2);
ds_map_replace(nextLevelBonusesMap,ModifiableProperties.CriticalsDamage,5);