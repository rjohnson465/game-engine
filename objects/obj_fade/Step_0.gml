if frame < fadeDuration {
	frame++;
}
else if !hasSetAlarm {
	hasSetAlarm = true;
	alarm[0] = 15;
	//instance_destroy(id,true);
}

// fountain creates particles everywhere when wished at
if instance_exists(owner) {
	if owner.object_index == obj_fountain && !hasSetAlarm {
		var num = 4;
		var conditionPercent = (frame / fadeDuration*100);
		if conditionPercent > 90 {
			num = 100;
		} else if conditionPercent > 75 {
			num = 300;
		} else if conditionPercent > 50 {
			num = 1600;
		} else if conditionPercent > 25 {
			num = 800;
		} else num = 400;
		
		var vx = camera_get_view_x(view_camera[0]); var vy = camera_get_view_y(view_camera[0]);
		var vw = camera_get_view_width(view_camera[0]); var vh = camera_get_view_height(view_camera[0]);
	
		part_emitter_region(system,emitter,vx,vx+vw,vy,vy+vw,0,0);
		part_emitter_burst(system,emitter,particle, num);
	} 
}