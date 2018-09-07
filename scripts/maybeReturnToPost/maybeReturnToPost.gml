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
if path_get_length(p) > farthestAllowedFromPost /*|| global.player.layer != layer*/ {
	//currentMeleeAttack = noone;
	//currentRangedAttack = noone;
	//lockOnTarget = noone;
	substate = CombatantMoveSubstates.ReturningToPost;
}


path_delete(p);