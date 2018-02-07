event_inherited();
subType = HandItemTypes.Melee;
weaponType = WeaponTypes.Sword1H;

name = "Longsword";
spriteName = "longsword";
itemSprite = spr_item_longsword;

numberOfTargets = 2;

range = 40;

weaponSpeed = "Medium";
weight = 10;
staggerDuration = 25; // frames
ds_map_set(damages,PHYSICAL,[10,20,10,20,25,30]);
staminaCostArray=[10,10,20];
physicalDamageTypeArray = ["slashing","slashing","piercing"];