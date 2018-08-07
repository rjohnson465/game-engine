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

weight = 10;
staggerDuration = 10; // frames
ds_map_set(damages,SLASH,[5,8,5,8,6,9,8,10]);
//ds_map_set(damages,PIERCE,[0,0,0,0,25,30]);
//ds_map_set(damages,CRUSH,[0,0,0,0,0,0]);
staminaCostArray=[10,10,10,10];

act = 1;

//numberOfSockets = 1;