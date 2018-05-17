event_inherited();
subType = HandItemTypes.Melee;

name = "Battleaxe";
baseName = "Battleaxe";
spriteName = "battleaxe";
itemSprite = spr_item_battleaxe;

charges = 10;
totalCharges = 10;

range = 60;

weight = 10;
staggerDuration = 35; // frames
ds_map_set(damages,SLASH,[20,25,22,30]);
//ds_map_set(damages,PIERCE,[0,0,0,0,25,30]);
//ds_map_set(damages,CRUSH,[0,0,0,0,0,0]);
staminaCostArray=[10,10,25];

act = 1;

numberOfSockets = 3;