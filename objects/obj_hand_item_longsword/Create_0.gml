event_inherited();
type = HandItemTypes.Melee;
name = "Longsword";
spriteName = "longsword";
itemSprite = spr_item_longsword;

weaponSpeed = "Medium";
weight = 10;
staggerDuration = 25; // frames
ds_map_set(damages,PHYSICAL,[10,20,10,20,25,30]);
ds_map_set(damages,ICE,[1,2]);
//ds_map_set(damages,ICE,[50,100]);
staminaCostArray=[7,15,20];
physicalDamageTypeArray = ["slashing","slashing","piercing"];