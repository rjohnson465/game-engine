event_inherited();
subType = HandItemTypes.Melee;

name = "Club";
baseName = "Club";
spriteName = "club";
itemSprite = spr_item_club;
baseValue = 200;

// for each attack in chain
numberOfTargets = [2,2,3];

charges = 10;
chargesMax = 10;

range = 45;

//ds_map_set(damages,SLASH,[10,20,10,20,0,0]);
//ds_map_set(damages,PIERCE,[0,0,0,0,25,30]);
ds_map_set(damages,CRUSH,[4,25,4,30,1,40]);
//staminaCostArray=[15,15,25];

act = 1;

//numberOfSockets = 3;