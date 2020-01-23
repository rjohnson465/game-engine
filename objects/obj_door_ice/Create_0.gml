event_inherited();
angle = image_angle; // decided by placement in room
xscale = image_xscale; yscale = image_yscale;
opensFrom = "l" // l | r | a | b | e
closedSprite = sprite_index; // this can be changed
openSprite = sprite_index;
spriteTurnsWhenOpen = true;
keyNeeded = noone; // or string name
isOpen = false;
material = ICE;
openingSound = snd_door_open;
isOneSided = false; // only opens from its "opensFrom" direction
//light_create_caster();

//openingFrames = 30;
keyRequired = noone; // this is either the string name of the required key, or noone
isNonPriorityInteractable = true;

ds_map_replace(properties, "isOpen", false);

var pointsx = ds_list_create();
var pointsy = ds_list_create();
var bl = sprite_get_bbox_left(sprite_index); var br = sprite_get_bbox_right(sprite_index);
var bb = sprite_get_bbox_bottom(sprite_index)-(.5*sprite_get_height(sprite_index)); var bt = 0;//sprite_get_bbox_top(sprite_index);
ds_list_add(pointsx, bl); ds_list_add(pointsx, br);
ds_list_add(pointsx, br); ds_list_add(pointsx, bl);
ds_list_add(pointsy, bt); ds_list_add(pointsy, bt);
ds_list_add(pointsy, bb); ds_list_add(pointsy, bb);
light_create_caster_from_points_layer(pointsx, pointsy);
