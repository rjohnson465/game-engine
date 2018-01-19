var conditionLevel = 0;
if condition == "Stagger" {
	conditionLevel = owner.state == CombatantStates.Staggering;
} else {
	conditionLevel = ds_map_find_value(owner.conditionLevels,condition);
}
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
	var conditionPercent = ds_map_find_value(owner.conditionPercentages,condition);
	var num2 = -10;
	switch condition {
		case FIRE: {
			// starts with many particles but as burn fades, particles dwindle
			if conditionPercent > 90 {
				num = 10;
			} else if conditionPercent > 50 {
				num = 4;
			} else if conditionPercent > 25 {
				num = 2;
			} else num = 1;

			part_emitter_region(system,emitter,owner.x,owner.x,owner.y,owner.y,0,0);
			
			// cinders
			num2 = -10;
			break;
		}
		case POISON: {
			//num = 3;
			// poison gets worse the longer it goes
			if conditionPercent > 90 {
				num = 1;
			} else if conditionPercent > 50 {
				num = 3;
			} else if conditionPercent > 25 {
				num = 6;
			} else num = 9;
			break;
		}
		case ICE: {
			// starts with many snowflakes but as freeze fades, less
			if conditionPercent > 90 {
				num = 8;
			} else if conditionPercent > 50 {
				num = 3;
			} else if conditionPercent > 25 {
				num = 1;
			} else num = -3;
			break;
		}
		case LIGHTNING: {
			// starts with many sparks but as freeze fades, less
			if conditionPercent > 90 {
				num = 2;
			} else if conditionPercent > 50 {
				num = 1;
			} else if conditionPercent > 25 {
				num = -1;
			} else num = -3;
			break;
		}
		/*case "Stagger": {
			num = 2;
			//var x1 = owner.x + xOff;
			//var y1 = owner.y + yOff;
			//part_emitter_region(system,emitter,x1,x1,y1,y1,0,0);
			part_emitter_region(system,emitter,x1,x2,y1,y2,ps_shape_ellipse,ps_distr_invgaussian);
		}*/
	}
	part_emitter_burst(system,emitter,particle, num);
	if particle2 {
		part_emitter_burst(system,emitter,particle2, num2);
	}
}
