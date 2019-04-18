event_inherited();
subType = HandItemTypes.Melee;

name = "Toy Hammer";
baseName = "Toy Hammer";
spriteName = "toyhammer";
itemSprite = spr_item_club;
baseValue = 200;

// for each attack in chain
numberOfTargets = [2,2,3];

charges = 10;
chargesMax = 10;

range = 45;

isTwoHanded = true;

ds_map_set(damages,SLASH,[0,0,0,0,0,0]);
ds_map_set(damages,PIERCE,[0,0,0,0,0,0]);
ds_map_set(damages,CRUSH,[4,25,4,30,1,40]);
ds_map_set(damages,MAGIC,[1,2,1,2,1,2]);
//staminaCostArray=[15,15,25];

act = 1;

//numberOfSockets = 3;