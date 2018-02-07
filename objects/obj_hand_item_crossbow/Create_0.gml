event_inherited();
subType = HandItemTypes.Ranged;
name = "Crossbow";
spriteName = "crossbow";
itemSprite = spr_item_crossbow;

weaponSpeed = "Medium";
projectileSpeed = 25;
weight = 4;
staggerDuration = 2; // frames
ds_map_set(damages,PHYSICAL,[5,10]);
staminaCostArray=[10];
physicalDamageTypeArray = ["piercing"];