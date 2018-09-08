if type == CombatantTypes.Player || lockOnTarget == noone || !instance_exists(lockOnTarget) exit;
// if we can't see the lockOnTarget (but we're still chasing and on its layer)
// every 15 frames we add a point to a path we're building to follow vaguely in lockOnTarget's footsteps
// this helps so we don't randomly change course while pursuing lockOnTarget when we can't see them
// these random changes of course happen when using mp_grid path functions, which is bad since the enemy
// shouldn't be able to see / know where target is going so well they alter course because of it
tempTargetX = lockOnTarget.x; tempTargetY = lockOnTarget.y;
alarm[7] = 15;
//path_add_point(gridPath,,lockOnTarget.y,100);