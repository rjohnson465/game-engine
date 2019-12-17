if ds_exists(itemsOnBelt, ds_type_list) && ds_list_size(itemsOnBelt) > 0 {
	for (var i = 0; i < ds_list_size(itemsOnBelt); i++) {
		var it = ds_list_find_value(itemsOnBelt, i);
		if !isActive {
			it.speed = 0;
			continue;
		}
		if it.x < 0 continue; // this is a looted item drop
		
		// get rectangle that represents the mid section of the belt
		var gridWidth = sprite_width div 32;
		var totalWidth = sprite_width;
		var drawnWidth = 0;

		// no matter what, we must draw the start sprite first
		var xx = x; var yy = y;
		var x1 = xx + lengthdir_x(32, image_angle);
		var y1 = yy + lengthdir_y(32, image_angle);
		
		drawnWidth += 32;

		gridWidth -= 1; // account for start sprite

		// draw one tile of conveyer belt for each cell
		// account for the angle this belt is at
		for (var i = 0; i < gridWidth - 1; i++) {
			drawnWidth += 32;
		}

		// if there is some remainder between 32 and 64, draw part of a mid sprite before drawing the end
		// increment xx and yy only partially (remainder amount)
		if (totalWidth - drawnWidth) - 32 > 0 {
			var w = (totalWidth - drawnWidth) - 32; 
			drawnWidth += w;
		}
		
		var x2 = xx + lengthdir_x(drawnWidth, image_angle); 
		
		var x2 = xx + lengthdir_x(drawnWidth, image_angle);
		var y2 = yy + lengthdir_y(drawnWidth, image_angle);
	
		var x3 = x2 + lengthdir_x(64, image_angle - 90);
		var y3 = y2 + lengthdir_y(64, image_angle - 90);
		
		var x4 = x1 + lengthdir_x(64, image_angle - 90);
		var y4 = y1 + lengthdir_y(64, image_angle - 90);
		
		var isInRect = pointInPolygon([it.x, it.y], [[x1, y1], [x2, y2], [x3, y3], [x4, y4]]);
		
		if isInRect {
			it.speed = beltSpeed;
			it.direction = image_angle;
		} else {
			it.x = mean(x1, x4); it.y = mean(y1, y4);
			// it.speed = 0;
		}
		
		with it {
			ds_map_replace(properties, "currentX", x);
			ds_map_replace(properties, "currentY", y);
		}
		
	}
}