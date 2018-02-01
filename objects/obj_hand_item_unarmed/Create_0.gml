event_inherited();
type = HandItemTypes.Melee;
name = "Unarmed";
spriteName = "unarmed";

range = 20;
weaponType = WeaponTypes.Unarmed;
weight = 5;
staggerDuration = 15; // frames
staminaCostArray=[5,10];
physicalDamageTypeArray = ["crushing","crushing"];

ds_map_set(damages,PHYSICAL,[5,10,10,15]);