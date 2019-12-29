if ds_exists(exerciseSteps, ds_type_list) {
	
	for (var i = 0; i < ds_list_size(exerciseSteps); i++) {
		var step = ds_list_find_value(exerciseSteps, i);
		if instance_exists(step) {
			instance_destroy(step, 1);
		}
	}
	
	ds_list_destroy(exerciseSteps); exerciseSteps = -1;
}

if part_emitter_exists(system, emitter) { 
	part_emitter_destroy(system, emitter); emitter = -1;
	part_system_destroy(system); system = -1;
}
if part_type_exists(part) {
	part_type_destroy(part); part = -1;
}