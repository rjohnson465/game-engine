event_inherited();
subType = HandItemTypes.Ranged;
name = "Pistol";
baseName = "Pistol";
spriteName = "pistol";
itemSprite = spr_item_pistol;

projectileSpeed = 40;
staggerDuration = 5; // frames
ds_map_set(damages,PIERCE,[10,12]);
staminaCostArray=[10];
ammo = 52;
ammoMax = 52;
numberOfSockets = 2;

act = 1;

//numberOfSockets = 1;