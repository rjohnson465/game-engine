event_inherited();
subType = HandItemTypes.Melee;
weaponType = WeaponTypes.Sword1H;

name = "Longsword";
spriteName = "longsword";
itemSprite = spr_item_longsword;

numberOfTargets = 2;

charges = 200;
totalCharges = 200;

range = 40;

weaponSpeed = "Medium";
weight = 10;
staggerDuration = 25; // frames
ds_map_set(damages,PHYSICAL,[10,20,10,20,25,30]);
staminaCostArray=[10,10,20];
physicalDamageTypeArray = ["slashing","slashing","piercing"];

//ds_map_replace(damages,POISON,[5,10]);
ds_map_replace(damages,ICE,[1,2]);
ds_map_replace(damages,MAGIC,[1,2]);