/// calcPathToUnseenTarget()
if alarm[9] != 1 exit;
turnSpeed = 100; // TODO check with speyeder if turning no longer fucks up guess path
while ds_list_size(guessPathPts) > 4 {
	ds_list_delete(guessPathPts,0);
}
if distance_to_point(tempTargetX,tempTargetY) < 10 && ds_list_size(guessPathPts) > 0 {
	var pt = ds_list_find_value(guessPathPts,0);
	tempTargetX = pt[0]; tempTargetY = pt[1];
	ds_list_delete(guessPathPts,0);
}
if tempTargetX == noone /*|| ds_list_size(guessPathPts) < 1*/ {
	alarm[7] = 15;
	tempTargetX = lockOnTarget.x; tempTargetY = lockOnTarget.y;
}
//populatePersonalGrid();
var isGridPathAvailable = mp_grid_path(personalGrid,gridPath,x,y,tempTargetX,tempTargetY,true);
if isGridPathAvailable {
	var xx = path_get_x(gridPath,.5);
	var yy = path_get_y(gridPath,.5);
	if distance_to_point(xx,yy) < 50 {
		xx = path_get_x(gridPath,1);
		yy = path_get_y(gridPath,1);
	}
	mp_potential_path(path,xx,yy,normalSpeed,1,0);
	path_start(path,functionalSpeed,path_action_stop,false);
	//direction = point_direction(x,y,xx,yy);
	/*mp_potential_step(xx,yy,functionalSpeed,0);
	path_delete(path);
	path = path_add();
	path_add_point(path,x,y,functionalSpeed);
	path_add_point(path,xx,yy,functionalSpeed);*/
} else {
	if place_meeting_layer(x,y,obj_fallzone) {
		jumpToNearestFreePoint(1);
	} else {
		if mp_potential_path(path,tempTargetX,tempTargetY,normalSpeed,4,false) {
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