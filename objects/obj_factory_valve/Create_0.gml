event_inherited();


isActive = false;

associatedPipeKeys = noone;
associatedPipes = ds_list_create();

onlyDrawLightOnPlayerLayer = true;

// light_create_layer(spr_light_point, .3, make_color_rgb(154,167,152), .4, 0, 1);
light_create_layer(spr_light_point, .3, c_red, .4, .5, 1);

origLayer = layer;
// depth += 5;

isNonPriorityInteractable = true;
isCurrentInteractableObject = false;

key = fs_generate_key();

randomize();
floatingFrame = random_range(0, 29);
scale = .3;