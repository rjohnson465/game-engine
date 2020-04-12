event_inherited();
name = "Ice Shield";
baseName = "Ice Shield";
spriteName = "iceshield";
itemSprite = spr_item_iceshield;

material = ICE;
weight = 5;
ds_map_replace(defenses,SLASH,75);
ds_map_replace(defenses,PIERCE,75);
ds_map_replace(defenses,CRUSH,75);
ds_map_replace(defenses,PHYSICAL,75);
ds_map_replace(defenses,FIRE,-100);
ds_map_replace(defenses,ICE,100);
ds_map_replace(defenses,MAGIC,75);
baseValue = 500;

act = 1;
durabilityMax = 5;
durability = 5;

soundDrop = snd_hit_ice_1;

description = "An old slab of the Mystic Ice that used to cover all of Winter Wonderground. Often used by Krampus Elves. Offers defense for ice, magic, and physical attacks, but is incredibly fragile.";