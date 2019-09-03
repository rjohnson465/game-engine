event_inherited();
name = "Buckler";
baseName = "Buckler";
spriteName = "buckler";
itemSprite = spr_item_buckler;
baseValue = 200;

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

soundDrop = snd_item_wood;

description = "An old, light shield, bound with leather. Won't absorb the full impact of a blow, but better than nothing.";