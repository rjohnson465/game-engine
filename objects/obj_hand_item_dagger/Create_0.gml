event_inherited();
subType = HandItemTypes.Melee;

name = "Dagger";
baseName = "Dagger";
spriteName = "dagger";
itemSprite = spr_item_dagger;
baseValue = 200;

range = 20;

ds_map_set(damages,SLASH,[4,6,4,6,5,8,8,10]);
ds_map_set(damages,PIERCE,[0,0,0,0,0,0,0,0]);
ds_map_set(damages,CRUSH,[0,0,0,0,0,0,0,0]);
staminaCostArray=[4,4,5,7];

ds_map_set(damagesPoise, 0, 3);
ds_map_set(damagesPoise, 1, 3);
ds_map_set(damagesPoise, 2, 4);
ds_map_set(damagesPoise, 3, 5);

act = 1;

description = "A small, simple dagger. Incredibly fast, and allows movement while attacking.";

weight = 3;