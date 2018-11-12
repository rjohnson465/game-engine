/// calcPathToSeenTarget()

if alarm[9] != 1 exit;
//populatePersonalGrid();



var isGridPathAvailable = mp_grid_path(personalGrid,gridPath,x,y,lockOnTarget.x,lockOnTarget.y,true);
if !isGridPathAvailable {
	if !place_free(x,y) {
		jumpToNearestFreePoint(true, true);
	}
	var ltl = lockOnTarget.bbox_left; var ltr = lockOnTarget.bbox_right;
	var ltt = lockOnTarget.bbox_top; var ltb = lockOnTarget.bbox_bottom;
	var try_arr = [ltl, ltt, ltr, ltt, ltl, ltb, ltr, ltb];
	for (var i = 0; i < array_length_1d(try_arr); i+=2) {
		var xx = try_arr[i]; var yy= try_arr[i+1];
		isGridPathAvailable = mp_grid_path(personalGrid, gridPath, x, y, xx, yy, true);
		if isGridPathAvailable break;
	}
}
if isGridPathAvailable {
	
	/*
	var xx = path_get_x(gridPath,.5);
	var yy = path_get_y(gridPath,.5);
	mp_potential_path(path,xx,yy,functionalSpeed,1,0);
	path_start(path,functionalSpeed,path_action_stop,false);*/
	
	path_start(gridPath,functionalSpeed, path_action_stop, false);
	//path_index = gridPath;
	
} else {
	if !place_free(x,y) {
		jumpToNearestFreePoint(true, true);
	}
	/*if place_meeting_layer(x,y,obj_fallzone) {
		jumpToNearestFreePoint(1,1);
		alarm[9] = 1;
	} */
	if true {
		if mp_potential_path(path,lockOnTarget.x,lockOnTarget.y,normalSpeed,4,false) {
			path_start(path,functionalSpeed,path_action_stop,false);
		} else if canSeeLockOnTarget() {
			path_end();
			mp_potential_step(lockOnTarget.x, lockOnTarget.y, functionalSpeed, false);
		}
	}
}

/*
if mp_grid_astar(personalGrid, gridPath, x, y, lockOnTarget.x, lockOnTarget.y, 0, 0, room_width div 32, room_height div 32, 32, 32) {
	path_start(gridPath, functionalSpeed, path_action_stop, false);
}