event_inherited();
subType = HandItemTypes.Melee;
name = "Unarmed";
spriteName = "unarmed";

range = 20;
weight = 0;

numberOfTargets = [1,2];

staggerDuration = 15; // frames
staminaCostArray=[5,10];

ds_map_set(damages,PHYSICAL,[5,10,10,15]);