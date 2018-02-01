event_inherited();
type = HandItemTypes.Melee;
name = "Longsword";
spriteName = "longsword";
itemSprite = spr_item_longsword;

numberOfTargets = 2;

range = 40;
weaponType = WeaponTypes.Sword1H;
weaponSpeed = "Medium";
weight = 10;
staggerDuration = 25; // frames
ds_map_set(damages,PHYSICAL,[10,20,10,20,25,30]);
staminaCostArray=[7,15,20];
physicalDamageTypeArray = ["slashing","slashing","piercing"];