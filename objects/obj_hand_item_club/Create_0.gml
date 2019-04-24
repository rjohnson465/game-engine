event_inherited();
subType = HandItemTypes.Melee;

name = "Club";
baseName = "Club";
spriteName = "club";
itemSprite = spr_item_club;
baseValue = 200;

// for each attack in chain
numberOfTargets = [2,2,3];


range = 45;

ds_map_set(damages,SLASH,[0,0,0,0,0,0]);
ds_map_set(damages,PIERCE,[0,0,0,0,0,0]);
ds_map_set(damages,CRUSH,[4,25,4,30,1,40]);
//staminaCostArray=[15,15,25];

act = 1;

//numberOfSockets = 3;