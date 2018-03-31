event_inherited();
name = "Whatever it TAKES, Goddammit";
description = "Increases max HP.";

#macro MAXHP " HP"

ds_map_replace(bonusesMap,MAXHP,0);
ds_map_replace(nextLevelBonusesMap,MAXHP,10);