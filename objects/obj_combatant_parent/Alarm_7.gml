if type == CombatantTypes.Player || lockOnTarget == noone || !instance_exists(lockOnTarget) exit;
// if we can't see the lockOnTarget (but we're still chasing and on its layer)
// every 15 frames we add a point to a path we're building to follow vaguely in lockOnTarget's footsteps
// this helps so we don't randomly change course while pursuing lockOnTarget when we can't see them
// these random changes of course happen when using mp_grid path functions, which is bad since the enemy
// shouldn't be able to see / know where target is going so well they alter course because of it
//tempTargetX = lockOnTarget.x; tempTargetY = lockOnTarget.y;

// do not add duplicate points to guessPath pts
var proposedEntryX = lockOnTarget.x;
var proposedEntryY = lockOnTarget.y;

// need to make sure the proposed pt is within a free cell for the combatant
// get the proposed entry point in grid coords
var gpx = proposedEntryX div cell_width;
var gpy = proposedEntryY div cell_height;

// get closest grid cell to that proposed pt
var closestCell = mp_grid_get_nearest_free_cell(personalGrid, gpx, gpy, cell_width, cell_height);
gpx = closestCell[0]; 
gpy = closestCell[1];

// convert back to pixel coords
proposedEntryX = gpx * cell_width;
proposedEntryY = gpy * cell_height;

if (ds_list_size(guessPathPts) > 0) {
	

	var lastEntry = ds_list_find_value(guessPathPts, ds_list_size(guessPathPts) - 1);
	var lastEntryX = lastEntry[0];
	var lastEntryY = lastEntry[1];
	
	if (lastEntryX != proposedEntryX && lastEntryY != proposedEntryY) {
		ds_list_add(guessPathPts, [proposedEntryX, proposedEntryY]);
	}
} 
else {
	ds_list_add(guessPathPts,[proposedEntryX,proposedEntryY]);
}
alarm[7] = 15;
//path_add_point(gridPath,,lockOnTarget.y,100);