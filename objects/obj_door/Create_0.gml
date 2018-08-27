event_inherited();
angle = image_angle; // decided by placement in room
xscale = image_xscale; yscale = image_yscale;
opensFrom = "l" // l | r | a | b | e
closedSprite = spr_door; // this can be changed
openSprite = spr_door;
spriteTurnsWhenOpen = true;
keyNeeded = noone; // or string name
isOpen = false;
material = WOOD;
openingSound = snd_door_open;
isOneSided = false; // only opens from its "opensFrom" direction

//openingFrames = 30;
keyRequired = noone; // this is either the string name of the required key, or noone