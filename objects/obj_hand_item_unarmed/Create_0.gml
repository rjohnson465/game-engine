event_inherited();
subType = HandItemTypes.Melee;
name = "Unarmed";
spriteName = "unarmed";

range = 20;
weight = 0;
act = 0;

numberOfTargets = [1,2];

staggerDuration = [10,15]; // frames
staminaCostArray=[7,15];

ds_map_set(damages,CRUSH,[2,5,4,7]);