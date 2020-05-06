event_inherited();
subType = HandItemTypes.Melee;

name = "Warhammer";
baseName = "Warhammer";
spriteName = "warhammer";
itemSprite = spr_item_warhammer;
baseValue = 200;

range = 60;

ds_map_set(damages,SLASH,[0,0,0,0,0,0]);
ds_map_set(damages,PIERCE,[0,0,0,0,0,0]);
ds_map_set(damages,CRUSH,[29,30,32,35,40,50]);
act = 1;

weight = 20;

description = "For when regular hammers just aren't cutting it.";

ds_map_set(damagesPoise, 0, 50);
ds_map_set(damagesPoise, 1, 50);
ds_map_set(damagesPoise, 2, 60);