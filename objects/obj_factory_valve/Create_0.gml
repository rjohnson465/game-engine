event_inherited();

origLayer = layer;
depth += 5;
isActive = false;

associatedPipeKeys = noone;
associatedPipes = ds_list_create();

onlyDrawLightOnPlayerLayer = true;

light_create_layer(spr_light_point, .3, make_color_rgb(154,167,152), .4, 0, 1);

isNonPriorityInteractable = true;
isCurrentInteractableObject = false;

key = fs_generate_key();