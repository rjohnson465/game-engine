event_inherited();
subType = HandItemTypes.Melee;

name = "Dagger";
baseName = "Dagger";
spriteName = "dagger";
itemSprite = spr_item_dagger;
baseValue = 200;

charges = 10;
chargesMax = 10;

range = 20;

ds_map_set(damages,SLASH,[4,6,4,6,5,8,8,10]);
ds_map_set(damages,PIERCE,[0,0,0,0,0,0,0,0]);
ds_map_set(damages,CRUSH,[0,0,0,0,0,0,0,0]);
staminaCostArray=[10,10,10,10];

act = 1;

//numberOfSockets = 1;