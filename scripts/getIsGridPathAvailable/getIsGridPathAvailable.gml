/// getIsGridPathAvailable(setGridPath*, goalX*, goalY*)
/// @param setGridPath boolean whether or not to set the gridPath property
/// @param goalX pixel x val for goal
/// @param goalY pixel y val for goal

/// must be called by an enemy
/// returns true or false
/// if returns true, the gridPath property of the enemy is set

// if do not set grid path, use a dummy path (destroyed at the end of this function)
var p = gridPath;
if (argument_count > 0 && argument[0] == false) {
	p = path_add();
}

// assume we use lockOnTarget as goal, but other goal could be provided as param
var goalX = lockOnTarget.x;
var goalY = lockOnTarget.y;
if (argument_count > 1) {
	goalX = argument[1];
	goalY = argument[2];
}

var gridX = goalX div cell_width;
var gridY = goalY div cell_height;

var closestCellArr = mp_grid_get_nearest_free_cell(personalGrid, gridX, gridY, cell_width, cell_height);
var closestCellGridX = closestCellArr[0];
var closestCellGridY = closestCellArr[1];

var cx = closestCellGridX * cell_width;
var cy = closestCellGridY * cell_height;

var isGridPathAvailable = mp_grid_path(personalGrid,p,x,y,cx,cy,true);

/*
if !isGridPathAvailable {
	var ttx = tempTargetX; var tty = tempTargetY; 
	var ltl = lockOnTarget.bbox_left; var ltr = lockOnTarget.bbox_right;
	var ltt = lockOnTarget.bbox_top; var ltb = lockOnTarget.bbox_bottom;
	var try_arr = [ltl, ltt, ltr, ltt, ltl, ltb, ltr, ltb];
	
	for (var i = 0; i < array_length_1d(try_arr); i+=2) {
		var xx = try_arr[i]; var yy= try_arr[i+1];
		isGridPathAvailable = mp_grid_path(personalGrid, p, x, y, xx, yy, true);
		if isGridPathAvailable break;
	}
}*/

if p != gridPath {
	path_delete(p);
}

/*
if argument_count > 0 && argument[0] == false {
	gridPath = oldGridPath;
}*/

return isGridPathAvailable;