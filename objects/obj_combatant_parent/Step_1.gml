// death
if hp <= 0 {
	isAlive = false;
	speed = 0;
	if type == CombatantTypes.Enemy {
		global.owner = id;
		instance_create_depth(x,y,1,obj_enemy_dead);
		x = -10;
		y = -10;
				
		var idd = id;
		with obj_light_radius {
			if owner == idd {
				x = -1000;
				y = -1000;
			}
		}
	}
}

if !canSeePlayer(id) && state == CombatantStates.Idle {
	visible = false;
} else visible = true;