event_inherited();

origLayer = layer;
depth += 5;
isActive = false;

associatedBeltKeys = noone;
associatedBelts = ds_list_create();

light_create_layer(spr_light_point, .3, c_yellow, .4, 0, 1);

isNonPriorityInteractable = true;
isCurrentInteractableObject = false;

key = fs_generate_key();

sprOn = spr_factory_lever_y_on;
sprOff = spr_factory_lever_y_off;