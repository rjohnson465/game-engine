event_inherited();

name = "Greatsword";
baseName = "Greatsword";
spriteName = "greatsword";
itemSprite = spr_item_greatsword;
baseValue = 200;

// for each attack in chain
numberOfTargets = [5,5,2];

charges = 10;
chargesMax = 10;

range = 45;

ds_map_set(damages,SLASH,[18,24,20,28,0,0]);
ds_map_set(damages,PIERCE,[0,0,0,0,25,37]);
//ds_map_set(damages,CRUSH,[4,25,4,30,1,40]);

act = 1;

//numberOfSockets = 3;