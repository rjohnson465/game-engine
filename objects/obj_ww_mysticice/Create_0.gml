event_inherited();
angle = image_angle; // decided by placement in room
xscale = image_xscale; yscale = image_yscale;

spriteTurnsWhenOpen = true;
keyNeeded = noone; // or string name
isOpen = false;
material = ICE_MAT;
openingSound = snd_door_open;
//light_create_caster();

//openingFrames = 30;
keyRequired = "Randolph's Nose"; // this is either the string name of the required key, or noone
isNonPriorityInteractable = true;

ds_map_replace(properties, "isOpen", false);

MELT_FRAMES_TOTAL = 60;
