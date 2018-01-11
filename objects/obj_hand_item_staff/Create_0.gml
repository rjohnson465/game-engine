event_inherited();
type = HandItemTypes.Melee;
name = "Staff";
spriteName = "staff";
itemSprite = spr_item_staff;

range = 30;

weaponSpeed = "Slow";
isTwoHanded = true;
// cast stuff
charges = 200;
totalCharges = 200;

weight = 6;
staggerDuration = 20; // frames
ds_map_set(damages,PHYSICAL,[12,18]);
staminaCostArray=[10];