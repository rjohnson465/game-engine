event_inherited();
angle = image_angle; // decided by placement in room
xscale = image_xscale; yscale = image_yscale;
isFallen = false;
material = WOOD;
fallingSound = snd_hit_ice_1;

isNonPriorityInteractable = true;

ds_map_replace(properties, "isFallen", false);

// Make a circle with 16 points.
var n = 16
var gap = 360 / n;
var pointsx = ds_list_create()
var pointsy = ds_list_create()
var sw = sprite_get_bbox_right(sprite_index) - sprite_get_bbox_left(sprite_index);
var sh = sprite_get_bbox_bottom(sprite_index) - sprite_get_bbox_top(sprite_index);
for (var i = 0; i < n; i++) {
	ds_list_add(pointsx, lengthdir_x((sw/2) + 1, i * gap))
	ds_list_add(pointsy, lengthdir_y((sh/2) + 1, i * gap))
}
light_create_caster_from_points_layer(pointsx, pointsy)

origLayer = layer;
// to draw under hands
var lDepth = layer_get_depth(origLayer);
lDepth += 2;
depth = lDepth;
