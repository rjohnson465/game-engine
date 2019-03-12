/// jumpToNearestFreeCell(grid)
/// @param grid

// set a combatant's x and y values to the nearest free grid cell 

var grid = argument[0];

var distanceToTry = 10;
var dir = -45;
// try going distanceToTry pixels out from current place at direction dir
// until the proposed x/y coordinates would not be in a occupied cell
var xx = x;
var yy = y;
var gx = xx div cell_width; 
var gy = yy div cell_height;
var isInOccupiedCell = mp_grid_get_cell(grid, gx, gy) == -1;

while isInOccupiedCell {
	dir = (dir + 45)%360;
	xx = x+lengthdir_x(distanceToTry,dir);
	yy = y+lengthdir_y(distanceToTry,dir);
	var gx = xx div cell_width; 
	var gy = yy div cell_height;
	if dir == 0 {
		distanceToTry += 45;
	}
	isInOccupiedCell = mp_grid_get_cell(grid, gx, gy) == -1;
}

x = xx;
y = yy;
