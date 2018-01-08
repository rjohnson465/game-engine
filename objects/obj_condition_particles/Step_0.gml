var conditionLevel = ds_map_find_value(owner.conditionLevels,condition);
if conditionLevel == 0 {
	instance_destroy(id,false);
	part_emitter_destroy(system,emitter);
} else {
	var x1 = owner.x - (.5*owner.sprite_width);
	var y1 = owner.y - (.5*owner.sprite_height);
	var x2 = owner.x + (.5*owner.sprite_width);
	var y2 = owner.y + (.5*owner.sprite_height);
	part_emitter_region(system,emitter,x1,x2,y1,y2,ps_shape_ellipse,0);
	var num = 1;
	var num2 = -10;
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
			part_emitter_region(system,emitter,owner.x,owner.x,owner.y,owner.y,0,0);
			
			// cinders
			num2 = -10;
			break;
		}
		case POISON: {
			num = 3;
		}
	}
	part_emitter_burst(system,emitter,particle, num);
	if particle2 {
		part_emitter_burst(system,emitter,particle2, num2);
	}
}
