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

if p != gridPath {
	path_delete(p);
}

return isGridPathAvailable;