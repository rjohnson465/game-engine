// Inherit the parent event
event_inherited();

material = METAL;

depth += 1; // hands appear over belt
stopsAttacks = false;

isActive = false;

index = image_index;

startSprite = spr_factory_cb_purple_start;
endSprite = spr_factory_cb_purple_end;
midSprite = spr_factory_cb_purple_mid;

lever = noone; // lever object that controls belt

cbKey = noone;

soundIndex = noone;