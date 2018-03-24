event_inherited();
subType = HandItemTypes.Melee;
weaponType = SWORD1H;

name = "Longsword";
spriteName = "longsword";
itemSprite = spr_item_longsword;

// for each attack in chain
numberOfTargets = [3];

charges = 200;
totalCharges = 200;

range = 50;

weaponSpeed = "Medium";
weight = 10;
staggerDuration = 25; // frames
ds_map_set(damages,SLASH,[10,20,10,20,0,0]);
ds_map_set(damages,PIERCE,[0,0,0,0,25,30]);
staminaCostArray=[20,20,25];
//physicalDamageTypeArray = ["slashing","slashing","piercing"];

//ds_map_replace(damages,POISON,[5,10]);
//ds_map_replace(damages,ICE,[1,2]);
//ds_map_replace(damages,MAGIC,[1,2]);