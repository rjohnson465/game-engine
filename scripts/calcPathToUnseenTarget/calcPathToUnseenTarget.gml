/// calcPathToUnseenTarget()

if alarm[9] != 1 && path_position < .9 exit;

// turnSpeed = 100; // TODO check with speyeder if turning no longer fucks up guess path
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

var isGridPathAvailable = getIsGridPathAvailable(true, tempTargetX, tempTargetY);
if isGridPathAvailable {
	
	path_start(gridPath,functionalSpeed, path_action_stop, false);
} 

