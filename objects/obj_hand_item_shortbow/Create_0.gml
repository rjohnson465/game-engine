event_inherited();
subType = HandItemTypes.Ranged;
name = "Shortbow";
baseName = "Shortbow";
spriteName = "shortbow";
itemSprite = spr_item_shortbow;

weaponType = BOW;

weaponSpeed = "Medium";
baseValue = 200;

projectileSpeed = 25;
isTwoHanded = true;
weight = 3;
staggerDuration = 5; // frames
ds_map_set(damages,PIERCE,[7,15]);
staminaCostArray=[15];
physicalDamageTypeArray = ["piercing"];
ammo = 20;
ammoMax = 20;

act = 1;
//numberOfSockets = 1;