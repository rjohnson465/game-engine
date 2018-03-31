event_inherited();
name = "I Said She Doesn't Have the Stamina";
description = "Increases max stamina.";

#macro MAXSTAMINA " Stamina"

ds_map_replace(bonusesMap,MAXSTAMINA,0);
ds_map_replace(nextLevelBonusesMap,MAXSTAMINA,1);