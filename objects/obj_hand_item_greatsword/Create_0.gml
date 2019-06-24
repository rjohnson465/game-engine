event_inherited();

name = "Greatsword";
baseName = "Greatsword";
spriteName = "greatsword";
itemSprite = spr_item_greatsword;
baseValue = 200;

// for each attack in chain
numberOfTargets = [5,5,2];

range = 70;

ds_map_set(damages,SLASH,[18,28,22,30,0,0]);
ds_map_set(damages,PIERCE,[0,0,0,0,25,37]);
ds_map_set(damages,CRUSH,[0,0,0,0,0,0]);

act = 1;

//numberOfSockets = 3;

weight = 13.5;