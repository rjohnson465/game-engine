if isSpell || isRanged {
	
	var idd = id;
	with obj_light_radius {
		if owner == idd {
			instance_destroy(id);
		}
	}
	instance_destroy(id);
}