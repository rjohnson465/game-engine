event_inherited();

origLayer = layer;
isActive = false;

onlyDrawLightOnPlayerLayer = true;

// light_create_layer(spr_light_point, .3, c_white, .4, 0, 1);

isNonPriorityInteractable = true;
isCurrentInteractableObject = false;

key = fs_generate_key();

goalX = noone; 
goalY = noone;
