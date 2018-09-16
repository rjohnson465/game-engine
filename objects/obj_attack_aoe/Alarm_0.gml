instance_destroy(id,1);
var idd = id;
with obj_light_radius {
	if owner == idd {
		instance_destroy(id);
	}
}