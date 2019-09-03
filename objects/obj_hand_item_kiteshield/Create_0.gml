event_inherited();
name = "Kite Shield";
baseName = "Kite Shield";
spriteName = "kiteshield";
itemSprite = spr_item_kiteshield;
baseValue = 250;

material = METAL;
weight = 12;
stability = 15;
ds_map_replace(defenses,SLASH,100);
ds_map_replace(defenses,PIERCE,100);
ds_map_replace(defenses,CRUSH,100);
ds_map_replace(defenses,PHYSICAL,100);
ds_map_replace(defenses,LIGHTNING,-50);
baseValue = 200;

act = 1;
durabilityMax = 30;
durability = 30;

soundDrop = snd_item_metal;

description = "A big, heavy hunk of metal. Absorbs physical attacks well, but increases damage dealt by lightning";