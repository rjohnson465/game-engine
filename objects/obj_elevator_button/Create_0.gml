origLayer = layer;
depth += 5;
floorNum = getLayerFloorNumber(origLayer);
isActive = false;

associatedElevatorName = noone;
associatedElevator = noone;

light_create_layer(spr_light_point, .3, c_white, .4, 0, 1);

isNonPriorityInteractable = true;
isCurrentInteractableObject = false;

key = fs_generate_key();