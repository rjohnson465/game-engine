event_inherited();
name = "Steroids";
description = "Increases max equipment load.";
levelMax = 20;
slot = Skills.EquipLoad;
skillSprite = spr_skill_steroids;

ds_map_replace(bonusesMap,ModifiableProperties.EquipmentLoad,0);
ds_map_replace(nextLevelBonusesMap,ModifiableProperties.EquipmentLoad,3);