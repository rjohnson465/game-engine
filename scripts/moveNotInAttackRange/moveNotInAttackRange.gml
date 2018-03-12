// Movement for AI combatants not in attack range
if layer == lockOnTarget.layer && mp_potential_path(path,lockOnTarget.x,lockOnTarget.y,normalSpeed,7,false) {
	mp_potential_path(path,lockOnTarget.x,lockOnTarget.y,normalSpeed,7,false)
	path_start(path,functionalSpeed,path_action_stop,false);
} 
// return to post if no path to target can be found
else if postZ == layer {
	if mp_grid_path(personalGrid,path,x,y,postX,postY,0) {
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