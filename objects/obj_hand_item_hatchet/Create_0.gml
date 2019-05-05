event_inherited();
subType = HandItemTypes.Melee;

name = "Hatchet";
baseName = "Hatchet";
spriteName = "hatchet";
itemSprite = spr_item_hatchet;
baseValue = 200;

// for each attack in chain
numberOfTargets = [3,3,1];

ds_map_set(damages,SLASH,[12,20,14,20,0,0]);
ds_map_set(damages,PIERCE,[0,0,0,0,0,0]);
ds_map_set(damages,CRUSH,[0,0,0,0,10,12]);

act = 1;

description = "Very good for chopping down trees, and other things with limbs."

//numberOfSockets = 3;