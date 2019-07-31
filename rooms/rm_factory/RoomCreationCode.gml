/*
with obj_enemy_parent {
	
	with obj_limb {
		if owner == other {
			instance_destroy(id, 1);
		}
	}
	
	with obj_weapon {
		if owner == other {
			instance_destroy(id, 1);
		}
	}
	
	instance_destroy(id, 1);
}