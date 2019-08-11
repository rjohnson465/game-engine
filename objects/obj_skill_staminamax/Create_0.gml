event_inherited();
name = "Endurance";
description = "Increases max stamina.";
levelMax = 99;
skillSprite = spr_skill_staminamax;

ds_map_replace(bonusesMap,ModifiableProperties.StaminaMax,0);
ds_map_replace(nextLevelBonusesMap,ModifiableProperties.StaminaMax,1);