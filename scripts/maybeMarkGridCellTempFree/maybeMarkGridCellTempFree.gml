/// maybeMarkGridCellTempFree(x, y) 
/// @param x the x pixel coordinate of a combatant
/// @param y the y pixel coordinate of a combatant
// must be called by a combatant

// If the combatant currently stands on a grid space in its personalGrid that is occupied,
// it becomes "free" 
// It will stop being falsely "free" once the combatant no longer occupies this space
// This is done so pathfinding can work 
// (i.e. the combatnat must always start in a free grid space, but this could be untrue if 
// staggered or flinched into a space marked as occupied, since stagger/flinch is pixel perfect)

if id == global.player exit;

var xx = argument[0];
var yy = argument[1];

var gridX = floor(xx div cell_width);
var gridY = floor(yy div cell_height);

// iff that cell is marked as occupied, free it
if mp_grid_get_cell(personalGrid, gridX, gridY) == -1 {
	mp_grid_clear_cell(personalGrid, gridX, gridY);
	gridTempFreeX = gridX;
	gridTempFreeY = gridY;
}