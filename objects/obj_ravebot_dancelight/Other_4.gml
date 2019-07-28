if room == rm_boss_ravebot {
	x = random_range(0, room_width);
	y = random_range(0, room_height);
}

lightDirection = random_range(0, 360);

var doesShadows = room == rm_boss_ravebot ? false : true;
light_create_layer(spr_light_point, 1, lightColor, .7, 0, doesShadows);