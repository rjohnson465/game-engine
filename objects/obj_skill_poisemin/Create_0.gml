event_inherited();
name = "Poised";
description = "Increases poise, making you harder to stagger.";
levelMax = 20;
slot = Skills.PoiseMin;
skillSprite = spr_skill_poise;

ds_map_replace(bonusesMap,ModifiableProperties.PoiseMax,0);
ds_map_replace(nextLevelBonusesMap,ModifiableProperties.PoiseMax,3);