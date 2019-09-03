event_inherited();
subType = HandItemTypes.Melee;

name = "Ice Club";
baseName = "Ice Club";
spriteName = "iceclub";
itemSprite = spr_item_club;
baseValue = 200;

// for each attack in chain
numberOfTargets = [2,2,3];

range = 45;

ds_map_set(damages,SLASH,[0,0,0,0,0,0]);
ds_map_set(damages,PIERCE,[0,0,0,0,0,0]);
ds_map_set(damages,CRUSH,[15,20,15,20,15,20]);
//staminaCostArray=[15,15,25];

act = 1;

//numberOfSockets = 3;