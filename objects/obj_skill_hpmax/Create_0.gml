event_inherited();
name = "Whatever it TAKES, Goddammit";
description = "Increases max HP.";
levelMax = 99;
slot = Skills.HealthMax;
skillSprite = spr_skill_hpmax;

ds_map_replace(bonusesMap,ModifiableProperties.HpMax,0);
ds_map_replace(nextLevelBonusesMap,ModifiableProperties.HpMax,10);