if layer != global.player.layer {
	layer = global.player.layer;
	// Make a circle with 16 points.
	var n = 16
	var gap = 360 / n;
	var pointsx = ds_list_create()
	var pointsy = ds_list_create()
	for (var i = 0; i < n; i++) {
	    ds_list_add(pointsx, lengthdir_x(sprite_get_width(sprite_index) / 2 + 1, i * gap))
	    ds_list_add(pointsy, lengthdir_y(sprite_get_width(sprite_index) / 2 + 1, i * gap))
	}
	light_create_caster_from_points_layer(pointsx, pointsy)
}