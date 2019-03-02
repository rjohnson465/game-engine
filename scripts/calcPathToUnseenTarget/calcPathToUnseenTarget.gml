/// calcPathToUnseenTarget()

if alarm[9] != 1 && path_position < .9 exit;

turnSpeed = 100; // TODO check with speyeder if turning no longer fucks up guess path
while ds_list_size(guessPathPts) > 4 {
	ds_list_delete(guessPathPts,0);
}

// also change tempTarget if it no longer exists in the guessPathPts array
var isTempTargetInPts = true;
/*for (var i = 0; i < ds_list_size(guessPathPts); i++) {
	var guessPathPt = ds_list_find_value(guessPathPts, i);
	var gx = guessPathPt[0];
	var gy = guessPathPt[1];
	
	if (gx == tempTargetX && gy == tempTargetY) {
		isTempTargetInPts = true;
	}
}*/

if distance_to_point(tempTargetX,tempTargetY) < 10 && ds_list_size(guessPathPts) > 0 {
	var pt = ds_list_find_value(guessPathPts,0);
	tempTargetX = pt[0]; tempTargetY = pt[1];
	ds_list_delete(guessPathPts,0);
}
if tempTargetX == noone {
	alarm[7] = 15;
	tempTargetX = lockOnTarget.x; tempTargetY = lockOnTarget.y;
}

/*
var isGridPathAvailable = mp_grid_path(personalGrid,gridPath,x,y,tempTargetX,tempTargetY,true);
if !isGridPathAvailable {
	var ttx = tempTargetX; var tty = tempTargetY; 
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
}*/
var isGridPathAvailable = getIsGridPathAvailable(true, tempTargetX, tempTargetY);
if isGridPathAvailable {
	/*var xx = path_get_x(gridPath,.5);
	var yy = path_get_y(gridPath,.5);
	if distance_to_point(xx,yy) < 50 {
		xx = path_get_x(gridPath,1);
		yy = path_get_y(gridPath,1);
	}
	mp_potential_path(path,xx,yy,normalSpeed,1,0);
	path_start(path,functionalSpeed,path_action_stop,false);*/
	
	path_start(gridPath,functionalSpeed, path_action_stop, false);
	//path_index = gridPath;
} else {
	
	// should never get here
	var a = 3;
	
	/*if !place_free(x,y) {
	//	jumpToNearestFreePoint(true, true);
	}
	else {
		//if true {
		if mp_potential_path(path,tempTargetX,tempTargetY,normalSpeed,5,false) {
			path_start(path,functionalSpeed,path_action_stop,false);
		} else {
			
			path_end(); turnSpeed = normalTurnSpeed;
			substate = CombatantMoveSubstates.ReturningToPost; lockOnTarget = noone;
			tempTargetX = noone; tempTargetY = noone; ds_list_clear(guessPathPts);
		}
	}*/
}

/*else if mp_potential_path(path,tempTargetX,tempTargetY,normalSpeed,4,false) {
	path_start(path,functionalSpeed,path_action_stop,false);
} else {
	path_end(); turnSpeed = normalTurnSpeed;
	substate = CombatantMoveSubstates.ReturningToPost; lockOnTarget = noone;
	tempTargetX = noone; tempTargetY = noone; ds_list_clear(guessPathPts);
}

/*
if mp_grid_astar(personalGrid, gridPath, x, y, lockOnTarget.x, lockOnTarget.y, 0, 0, room_width div 32, room_height div 32, 32, 32) {
	path_start(gridPath, functionalSpeed, path_action_stop, false);
}