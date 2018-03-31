event_inherited();
name = "Git Gud with Slashy Slashy";
description = "Increases critical hit chance, critical hit damage, and overall damage with 1H swords, 2H swords, and daggers .";

#macro DAMAGE " base damage"
#macro CRITCHANCE " % critical hit chance"
#macro CRITDAMAGE " % critical hit damage"

ds_map_replace(bonusesMap,DAMAGE,0);
ds_map_replace(bonusesMap,CRITCHANCE,0);
ds_map_replace(bonusesMap,CRITDAMAGE,0);

ds_map_replace(nextLevelBonusesMap,DAMAGE,1);
ds_map_replace(nextLevelBonusesMap,CRITCHANCE,2);
ds_map_replace(nextLevelBonusesMap,CRITDAMAGE,5);