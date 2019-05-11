/// calcPathToSeenTarget()

if alarm[9] != 1 exit;



var isGridPathAvailable = mp_grid_path(personalGrid,gridPath,x,y,lockOnTarget.x,lockOnTarget.y,true);
if !isGridPathAvailable {

	var ltl = lockOnTarget.bbox_left; var ltr = lockOnTarget.bbox_right;
	var ltt = lockOnTarget.bbox_top; var ltb = lockOnTarget.bbox_bottom;
	var try_arr = [ltl, ltt, ltr, ltt, ltl, ltb, ltr, ltb];
	
	var stl = bbox_left; var str = bbox_right;
	var stt = bbox_top; var stb = bbox_bottom;
	var try_arr2 = [stl, stt, str, stt, stl, stb, str, stb];
	
	for (var i = 0; i < array_length_1d(try_arr); i+=2) {
		var xx = try_arr[i]; var yy= try_arr[i+1];
		for (var j = 0; j < array_length_1d(try_arr2); j+=2) {
			var xxx = try_arr2[j]; var yyy = try_arr2[j+1]; 
			isGridPathAvailable = mp_grid_path(personalGrid, gridPath, xxx, yyy, xx, yy, true);
			if isGridPathAvailable break;
		}
	}
}
if isGridPathAvailable {
	path_start(gridPath,functionalSpeed, path_action_stop, false);
} else {
	if !place_free(x,y) {
		jumpToNearestFreePoint(true, true);
	}

	if true {
		if mp_potential_path(path,lockOnTarget.x,lockOnTarget.y,normalSpeed,4,false) {
			path_start(path,functionalSpeed,path_action_stop,false);
		} else if canSeeLockOnTarget() {
			path_end();
			mp_potential_step(lockOnTarget.x, lockOnTarget.y, functionalSpeed, false);
		}
	}
}

