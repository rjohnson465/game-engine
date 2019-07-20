if instance_number(obj_enemy_ravebot) > 0 {
	var rb = instance_nearest(x, y, obj_enemy_ravebot);
	if rb.isAlive && rb.hp > 0 {
		// move the light
		speed = lightSpeed;
		direction = lightDirection;
		floatingFrame += 1;
		if floatingFrame > 60 {
			floatingFrame = 0;
		}
		var scale = .1*cos((pi*floatingFrame)/30)+.9; // normal floating
		light_set_scale(scale);
		
		if x < 0 || y < 0 {
			randomize();
			x = random_range(0, room_width);
			y = random_range(0, room_height);
			lightDirection = random_range(0, 360);
		}
	}
	else {
		x = -1000;
		y = -1000;
		// instance_destroy(id, 1);
	}
}