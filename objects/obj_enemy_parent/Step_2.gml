/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// the grid resetting happens in Begin Step
// this is a failsafe, if the enemy is in Move state but can't path
if state == CombatantStates.Moving && gridTempFreeX < 0 {
	
	// check if the cell we're in is not free, if so, jump to nearest free place
	var gridX = x div cell_width;
	var gridY = y div cell_height;
	if mp_grid_get_cell(personalGrid, gridX, gridY) == -1 {
		var a = 3;
		// jumpToNearestFreeCell(personalGrid);
	}
	
}