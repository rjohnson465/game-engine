event_inherited();
name = "Buckler";
baseName = "Buckler";
spriteName = "buckler";
itemSprite = spr_item_buckler;

material = WOOD;
weight = 9;
stability = 8;
ds_map_replace(defenses,SLASH,60);
ds_map_replace(defenses,PIERCE,60);
ds_map_replace(defenses,CRUSH,60);
ds_map_replace(defenses,PHYSICAL,60);
ds_map_replace(defenses,FIRE,0);
baseValue = 200;

act = 1;
durabilityMax = 22;
durability = 22;

//numberOfSockets = 1;
soundDrop = snd_item_wood;