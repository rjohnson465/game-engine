/// calcPathToUnseenTarget()

if alarm[9] != 1 && path_position < .9 exit;

turnSpeed = 100; // TODO check with speyeder if turning no longer fucks up guess path
while ds_list_size(guessPathPts) > 4 {
	ds_list_delete(guessPathPts,0);
}
if distance_to_point(tempTargetX,tempTargetY) < 10 && ds_list_size(guessPathPts) > 0 {
	var pt = ds_list_find_value(guessPathPts,0);
	tempTargetX = pt[0]; tempTargetY = pt[1];
	ds_list_delete(guessPathPts,0);
}
if tempTargetX == noone {
	alarm[7] = 15;
	tempTargetX = lockOnTarget.x; tempTargetY = lockOnTarget.y;
}
//populatePersonalGrid();
var isGridPathAvailable = mp_grid_path(personalGrid,gridPath,x,y,tempTargetX,tempTargetY,true);
if !isGridPathAvailable {
	var ttx = tempTargetX; var tty = tempTargetY; 
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
	if !place_free(x,y) {
		jumpToNearestFreePoint(true, true);
	}
	/*if place_meeting_layer(x,y,obj_fallzone) {
		jumpToNearestFreePoint(1);
	}*/ 
	else {
		//if true {
		if mp_potential_path(path,tempTargetX,tempTargetY,normalSpeed,5,false) {
			path_start(path,functionalSpeed,path_action_stop,false);
		} else {
			
			path_end(); turnSpeed = normalTurnSpeed;
			substate = CombatantMoveSubstates.ReturningToPost; lockOnTarget = noone;
			tempTargetX = noone; tempTargetY = noone; ds_list_clear(guessPathPts);
		}
	}
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