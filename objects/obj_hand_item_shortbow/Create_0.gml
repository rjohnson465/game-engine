event_inherited();
subType = HandItemTypes.Ranged;
name = "Shortbow";
spriteName = "shortbow";
itemSprite = spr_item_shortbow;

weaponType = BOW;

weaponSpeed = "Medium";

projectileSpeed = 25;
isTwoHanded = true;
weight = 3;
staggerDuration = 2; // frames
ds_map_set(damages,PIERCE,[7,15]);
staminaCostArray=[15];
physicalDamageTypeArray = ["piercing"];