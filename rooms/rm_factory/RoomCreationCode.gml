room_speed = 30;

/*
with obj_portal {
	instance_destroy(id, 1);
}

/*
with obj_molten_floor {
	instance_destroy(id, 1);
}

with obj_factory_pipe {
	instance_destroy(id, 1);
}

with obj_fallbreaker_parent {
	instance_destroy(id, 1);
}

/*
with obj_enemy_parent {
	var enemy = id;
	 with obj_limb {
		if owner == enemy {
			instance_destroy(id, 1);
		}
	 }
	 with obj_weapon {
		if owner == enemy {
			instance_destroy(id, 1);
		}
	 }
	 
	 instance_destroy(id, 1);
}

with obj_attack_data_parent {
	instance_destroy(id, 1);
}