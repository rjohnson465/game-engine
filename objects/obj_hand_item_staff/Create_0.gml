event_inherited();
subType = HandItemTypes.Melee;
weaponType = BLUNT2H;
name = "Staff";
spriteName = "staff";
itemSprite = spr_item_staff;

range = 30;

weaponSpeed = "Slow";
isTwoHanded = true;
// cast stuff
charges = 200;
chargesMax = 200;

weight = 6;
staggerDuration = 20; // frames
ds_map_set(damages,PHYSICAL,[12,18]);
staminaCostArray=[10];