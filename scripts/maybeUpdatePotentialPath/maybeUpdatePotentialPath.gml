/// maybeUpdatePotentialPath(xx,yy)
/// @param xx
/// @param yy

// only update the "path" if alarm[9] is 0 OR if there is no path set atm

var xx = argument[0]; 
var yy = argument[1];

var noPath =  path == noone || path == undefined || path_index == noone || path_index == -1;

if alarm[9] == 0 || noPath {
	
	populatePersonalGrid();
	if !place_free(x,y) jumpToNearestFreePoint(1);
	var isGridPathAvailable = mp_grid_path(personalGrid,gridPath,x,y,lockOnTarget.x,lockOnTarget.y,true);
	if isGridPathAvailable {
		var xx = path_get_x(gridPath,.1);
		var yy = path_get_y(gridPath,.1);
		mp_potential_path(path,xx,yy,functionalSpeed,4,0);
		path_start(path,functionalSpeed,path_action_stop,0);
	} else if mp_potential_path(path,xx,yy,functionalSpeed,4,0) {
		path_start(path,functionalSpeed,path_action_stop,0);
	} else if canSeeLockOnTarget() {
		path_end();
		mp_potential_step(lockOnTarget.x, lockOnTarget.y, functionalSpeed, false);
	}
	else {
		if postZ == layer {
			var a = mp_grid_path(personalGrid,path,x,y,postX,postY,0);
			if a {
				path_start(path,functionalSpeed,path_action_stop,false);
				currentMeleeAttack = noone;
				currentRangedAttack = noone;
				lockOnTarget = noone;
			}
		}
		// not on post layer, not on lockOnTarget layer
		else {
			if mp_grid_path(personalGrid,path,x,y,tempPostX,tempPostY,0) {
				path_start(path,functionalSpeed,path_action_stop,false);
				currentMeleeAttack = noone;
				currentRangedAttack = noone;
				lockOnTarget = noone;
			}
		}
	}
	return true;
}
return false;