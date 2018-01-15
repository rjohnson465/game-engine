if isMelee {
	owner.staggerFrame = 0;
	// stagger duration is 10 frames + damage% of of total hp frames
	owner.staggerDuration = 5;
	staggerDirection = owner.facingDirection;
	path_end();
	// run to get __x and __y (collision point where attack meet this combatant)
	script_execute(scr_collision_point,id,other.id);
	// create stagger condi particles
	global.damageType = "Block";
	global.x1 = __x;
	global.y1 = __y;
	global.shieldDirection = facingDirection;
	instance_create_depth(0,0,1,obj_hit_particles);
	owner.state = CombatantStates.Staggering;
}

if isSpell || isRanged {
	instance_destroy(id,false);
}