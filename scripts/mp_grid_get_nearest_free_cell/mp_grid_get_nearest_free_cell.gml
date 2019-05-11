/// mp_grid_get_nearest_free_cell(id, x, y, cw, ch)
///@param id
///@param x cell x
///@param y cell y
/// @param cw cell width
/// @param ch cell height

var grid = argument[0];
var gx = argument[1];
var gy = argument[2];
var cw = argument[3];
var ch = argument[4];

if mp_grid_get_cell(grid, gx, gy) == 0 {
	return [gx, gy];
}

var px = gx * cw;
var py = gy * ch;

var dir = 0;

var foundCell = false;

var distanceToTry = 0;

var xx = px;
var yy = py;
while !foundCell {
	dir = (dir + 45)%360;
	xx = px+lengthdir_x(distanceToTry,dir);
	yy = py+lengthdir_y(distanceToTry,dir);
	if dir == 0 {
		distanceToTry += 10;
	}
	gx = xx div cell_width; 
	gy = yy div cell_height;
	foundCell = mp_grid_get_cell(grid, gx, gy) == 0;
}

return [gx, gy];