event_inherited();
name = "Ambidextrous";
description = "Increases damage dealt with offhand weapon.";
levelMax = 10;
skillSprite = spr_skill_ambidextrous;

var base = 50;
ds_map_replace(bonusesMap,ModifiableProperties.OffHandDamage,base+0);
ds_map_replace(nextLevelBonusesMap,ModifiableProperties.OffHandDamage,base+5);