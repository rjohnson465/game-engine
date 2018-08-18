if !instance_exists(currentQuestStep) {
	currentQuestStep = ds_list_find_value(questSteps,0);
	currentQuestStepIndex = 0;
}

//show_debug_message(steps);

if !ds_exists(questSteps,ds_type_list) {
	var a = 3;
	var b = 3;
}


// reconstruct your steps you fuckwit
if !ds_exists(questSteps,ds_type_list) {
	var foundSteps = ds_map_create();
	with obj_queststep_parent {
		
		if quest == other {
			ds_map_add(foundSteps,object_get_name(object_index),id);
		}
	}
	questSteps = ds_list_create();
	var questName = string_copy(object_get_name(other.object_index),11,100);
	for (var i = 1; i <= ds_map_size(foundSteps); i++) {
		var s = "obj_queststep_"+questName+"_"+string(i);
		var inst = ds_map_find_value(foundSteps,s);
		ds_list_add(questSteps,inst);
	}
	
	ds_map_destroy(foundSteps); foundSteps = -1;
}