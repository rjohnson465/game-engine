event_inherited();
subType = HandItemTypes.Melee;

name = "Foil";
baseName = "Foil";
spriteName = "foil";
itemSprite = spr_item_foil;

// for each attack in chain
numberOfTargets = [1,1,1,5];

charges = 10;
chargesMax = 10;

range = 80;
weight = 10;

ds_map_set(damages,PIERCE,[7,10,7,10,9,10]);
ds_map_set(damages,SLASH,[0,0,0,0,0,0,5,8]);
//staminaCostArray=[10,10,25];

act = 1;

numberOfSockets = 3;