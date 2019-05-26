// Inherit the parent event
event_inherited();

material = METAL;

depth += 1; // hands appear over flower
stopsAttacks = false;

isActive = false;

index = image_index;

startSprite = spr_factory_cb_yellow_start;
endSprite = spr_factory_cb_yellow_end;
midSprite = spr_factory_cb_yellow_mid;

lever = noone; // lever object that controls belt

cbKey = noone;

soundIndex = noone;