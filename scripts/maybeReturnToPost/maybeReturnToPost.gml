/// maybeReturnToPost()

/// check if enemy is too far from post/acting post

var actingPostX = postX;
var actingPostY = postY;
if layer != postZ {
	actingPostX = tempPostX;
	actingPostY = tempPostY;
}

var p = path_add();
mp_grid_path(personalGrid,p,x,y,actingPostX,actingPostY,true);
var _dist = path_get_length(p);
var _dist2 = distance_to_point(actingPostX, actingPostY);
if _dist > farthestAllowedFromPost || _dist2 > farthestAllowedFromPost || global.player.layer != layer {
	currentMeleeAttack = noone;
	currentRangedAttack = noone;
	lockOnTarget = noone;
	substate = CombatantMoveSubstates.ReturningToPost;
	path_end();
	path_delete(p);
	return true;
} else {
	path_delete(p);
	return false;
}


