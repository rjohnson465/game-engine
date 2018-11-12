event_inherited();
name = "Spiked Shield";
baseName = "Spiked Shield";
spriteName = "spikedshield";
itemSprite = spr_item_woodshield;

material = WOOD;
weight = 5;
ds_map_replace(defenses,SLASH,100);
ds_map_replace(defenses,PIERCE,100);
ds_map_replace(defenses,CRUSH,100);
ds_map_replace(defenses,PHYSICAL,100);
ds_map_replace(defenses,FIRE,-100);
baseValue = 200;

act = 1;
durabilityMax = 5;
durability = 5;

//numberOfSockets = 1;
soundDrop = snd_item_wood;