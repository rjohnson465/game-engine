x = random_range(0, room_width);
y = random_range(0, room_height);
lightDirection = random_range(0, 360);

light_create_layer(spr_light_point, 1, lightColor, .7, 0, false);