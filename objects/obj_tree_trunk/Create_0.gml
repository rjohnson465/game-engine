material = WOOD; 
stopsAttacks = true;
isObstacleLayerless = true;
origLayer = layer;
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