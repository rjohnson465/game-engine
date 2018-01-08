var conditionPercent = ds_map_find_value(owner.conditionPercentages,condition);
if conditionPercent <= 0 {
	global.conditionBarCount--;
	var barNum = conditionBarNumber;
	with (obj_condition_bar) {
		if conditionBarNumber > barNum {
			conditionBarNumber--;
		}
	}
	instance_destroy(id,false);
}

/*var conditionLevel = ds_map_find_value(owner.conditionLevels,condition);
// particles for conditions 
if conditionLevel > 0 {
	var condParticlesExist = false;
	var c = condition;
	var o = owner;
	with (obj_condition_particles) {
		if condition == c && owner == 0 {
			condParticlesExist = true;
		}
	}
	if !condParticlesExist {
		global.condition = condition;
		global.owner = owner;
		instance_create_depth(x,y,1,obj_condition_particles);
	}
}*/