event_inherited();
subType = HandItemTypes.Melee;

name = "Longsword";
baseName = "Longsword";
spriteName = "longsword";
itemSprite = spr_item_longsword;

// for each attack in chain
numberOfTargets = [3,3,1];

charges = 200;
totalCharges = 200;

range = 50;

weaponSpeed = "Medium";
weight = 10;
staggerDuration = 25; // frames
ds_map_set(damages,SLASH,[10,20,10,20,0,0]);
ds_map_set(damages,PIERCE,[0,0,0,0,25,30]);
//ds_map_set(damages,CRUSH,[0,0,0,0,0,0]);
staminaCostArray=[10,10,25];