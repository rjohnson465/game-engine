/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// check if the cell we're in is not free, if so, jump to nearest free place
var gridX = x div cell_width;
var gridY = y div cell_height;
if mp_grid_get_cell(personalGrid, gridX, gridY) == -1 {

	jumpToNearestFreeCell(personalGrid);
}