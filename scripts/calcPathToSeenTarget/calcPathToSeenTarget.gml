/// calcPathToSeenTarget()
if alarm[9] != 1 exit;
//populatePersonalGrid();
//if !place_free(x,y) jumpToNearestFreePoint(1);

var isGridPathAvailable = mp_grid_path(personalGrid,gridPath,x,y,lockOnTarget.x,lockOnTarget.y,true);
if isGridPathAvailable {
	var xx = path_get_x(gridPath,.5);
	var yy = path_get_y(gridPath,.5);
	mp_potential_path(path,xx,yy,functionalSpeed,1,0);
	path_start(path,functionalSpeed,path_action_stop,false);
} else {
	if place_meeting_layer(x,y,obj_fallzone) {
		jumpToNearestFreePoint(1,1);
		alarm[9] = 1;
	} else {
		if mp_potential_path(path,lockOnTarget.x,lockOnTarget.y,normalSpeed,4,false) {
			path_start(path,functionalSpeed,path_action_stop,false);
		} else if canSeeLockOnTarget() {
			path_end();
			mp_potential_step(lockOnTarget.x, lockOnTarget.y, functionalSpeed, false);
		}
	}
}