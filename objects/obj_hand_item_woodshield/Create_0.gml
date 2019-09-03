event_inherited();
name = "Wood Shield";
baseName = "Wood Shield";
spriteName = "woodshield";
itemSprite = spr_item_woodshield;

baseValue = 50;

material = WOOD;
weight = 8;
ds_map_replace(defenses,SLASH,75);
ds_map_replace(defenses,PIERCE,75);
ds_map_replace(defenses,CRUSH,75);
ds_map_replace(defenses,PHYSICAL,75);
ds_map_replace(defenses,FIRE,-100);
baseValue = 200;

act = 1;
durabilityMax = 14;
durability = 14;

soundDrop = snd_item_wood;

description = "Breaks easily and can be set on fire, doubling fire damage. That's what you get for using an old piece of wood as a shield, you doofus.";