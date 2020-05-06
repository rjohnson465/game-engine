event_inherited();
subType = HandItemTypes.Melee;

name = "Spear";
baseName = "Spear";
spriteName = "spear";
itemSprite = spr_item_spear;
baseValue = 200;

range = 250;

ds_map_set(damages,SLASH,[0,0,0,0]);
ds_map_set(damages,PIERCE,[22,25,25,30]);
ds_map_set(damages,CRUSH,[0,0,0,0]);
act = 1;

weight = 10;

description = "Lets you stab your enemies one at a time from a long range, you coward.";