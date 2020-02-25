if ds_exists(eventSteps, ds_type_list) {
	
	for (var i = 0; i < ds_list_size(eventSteps); i++) {
		var step = ds_list_find_value(eventSteps, i);
		if instance_exists(step) {
			instance_destroy(step, 1);
		}
	}
	
	ds_list_destroy(eventSteps); eventSteps = -1;
}

if part_emitter_exists(system, emitter) { 
	part_emitter_destroy(system, emitter); emitter = -1;
	part_system_destroy(system); system = -1;
}
if part_type_exists(part) {
	part_type_destroy(part); part = -1;
}

// make associated walls traversable
for (var i = 0; i < array_length_1d(associatedWallKeys); i++) {
	var wKey = associatedWallKeys[i];
	var w = noone;
	with obj_event_wall {
		if key == wKey {
			w = id;
		}
	}
	if w != noone {
		w.isUntraversable = false;
	}
}