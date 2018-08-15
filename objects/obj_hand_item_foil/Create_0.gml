event_inherited();
subType = HandItemTypes.Melee;

name = "Foil";
baseName = "Foil";
spriteName = "foil";
itemSprite = spr_item_foil;
baseValue = 200;

// for each attack in chain
numberOfTargets = [1,1,1,5];

charges = 10;
chargesMax = 10;

range = 80;

ds_map_set(damages,PIERCE,[5,8,6,8,8,10,0,0]);
ds_map_set(damages,SLASH,[0,0,0,0,0,0,5,8]);
ds_map_set(damages,CRUSH,[0,0,0,0,0,0,0,0]);

act = 1;

numberOfSockets = 3;