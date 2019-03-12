event_inherited();
angle = image_angle; // decided by placement in room
xscale = image_xscale; yscale = image_yscale;
isFallen = false;
material = WOOD;
fallingSound = snd_shield_hit_wood;

isNonPriorityInteractable = true;

ds_map_replace(properties, "isFallen", false);

var pointsx = ds_list_create();
var pointsy = ds_list_create();
var bl = sprite_get_bbox_left(sprite_index); var br = sprite_get_bbox_right(sprite_index);
var bb = sprite_get_bbox_bottom(sprite_index)-(.5*sprite_get_height(sprite_index)); var bt = 0;//sprite_get_bbox_top(sprite_index);
ds_list_add(pointsx, bl); ds_list_add(pointsx, br);
ds_list_add(pointsx, br); ds_list_add(pointsx, bl);
ds_list_add(pointsy, bt); ds_list_add(pointsy, bt);
ds_list_add(pointsy, bb); ds_list_add(pointsy, bb);
light_create_caster_from_points_layer(pointsx, pointsy);

origLayer = layer;
// to draw under hands
var lDepth = layer_get_depth(origLayer);
lDepth += 2;
depth = lDepth;
