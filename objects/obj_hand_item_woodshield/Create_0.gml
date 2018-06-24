event_inherited();
name = "Wood Shield";
baseName = "Wood Shield";
spriteName = "woodshield";
itemSprite = spr_item_woodshield;

material = WOOD;
weight = 5;
ds_map_replace(defenses,SLASH,100);
ds_map_replace(defenses,PIERCE,100);
ds_map_replace(defenses,CRUSH,100);
ds_map_replace(defenses,PHYSICAL,100);

act = 1;
durabilityMax = 20;
durability = 20;

//numberOfSockets = 1;