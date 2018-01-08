var conditionLevel = ds_map_find_value(owner.conditionLevels,condition);
if conditionLevel == 0 {
	instance_destroy(id,false);
	part_emitter_destroy(system,emitter);
} else {
	part_emitter_region(system,emitter,owner.x,owner.x,owner.y,owner.y,0,0);
	var num = -500;
	switch condition {
		case FIRE: {
			var conditionPercent = ds_map_find_value(owner.conditionPercentages,condition);
			//num = -100;
			// linear
			//num = ((51/20)*conditionPercent)-250;
			// exponential
			// TODO get a math major DEVIN
			//num = (((conditionPercent-100)*((conditionPercent-100)*.001)) * -1)+4;
			if conditionPercent > 90 {
				num = 10;
			} else if conditionPercent > 50 {
				num = 4;
			} else if conditionPercent > 25 {
				num = 2;
			} else num = 1;
			//show_debug_message(num);
		}
	}
	part_emitter_burst(system,emitter,particle, num);
}
