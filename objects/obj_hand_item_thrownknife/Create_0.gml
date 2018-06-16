event_inherited();
subType = HandItemTypes.Ranged;
name = "Thrown Knife";
baseName = "Thrown Knife";
spriteName = "thrownknife";
itemSprite = spr_item_thrownknife;

projectileSpeed = 20;
staggerDuration = 5; // frames
ds_map_set(damages,PIERCE,[5,11]);
staminaCostArray=[15];
ammo = 20;
ammoMax = 20;

act = 1;

//numberOfSockets = 1;