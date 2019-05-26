// Inherit the parent event
event_inherited();

material = METAL;

depth += 1; // hands appear over flower
stopsAttacks = false;

isActive = false;

index = image_index;

startSprite = spr_factory_cb_blue_start;
endSprite = spr_factory_cb_blue_end;
midSprite = spr_factory_cb_blue_mid;

lever = noone; // lever object that controls belt

cbKey = noone;

soundIndex = noone;