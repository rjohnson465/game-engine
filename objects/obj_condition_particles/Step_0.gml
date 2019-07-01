if !instance_exists(owner) exit;
part_system_depth(system,layer_get_depth(owner.layer)-1);
if owner.depth < global.player.depth exit;
if (condition == "Death" || condition == "IceDeath") && (!owner.isAlive || owner.hp > 0) && !hasSetAlarm {
	//instance_destroy(id);
	alarm[0] = 60;
	hasSetAlarm = true;
}

if condition == "FairyDodge" && owner.state != CombatantStates.Dodging && !hasSetAlarm {
	alarm[0] = 10;
	hasSetAlarm = true;
}

if hasSetAlarm exit;

var conditionLevel = 0;
if condition == "FairyDodge" {
	conditionLevel = owner.state == CombatantStates.Dodging;
} 
else {
	conditionLevel = ds_map_find_value(owner.conditionLevels,condition);
}

if conditionLevel == 0 {
	instance_destroy(id,false);
	part_emitter_destroy(system,emitter);
} else {
	if owner.object_index == obj_fountain {
		part_emitter_region(system,emitter,0,room_width,0,room_height,0,0);
	} else {
		var sw = sprite_get_bbox_right(owner.sprite_index) - sprite_get_bbox_left(owner.sprite_index);
		var sh = sprite_get_bbox_bottom(owner.sprite_index) - sprite_get_bbox_top(owner.sprite_index);
		var x1 = owner.x - (.5*sw);
		var y1 = owner.y - (.5*sh);
		var x2 = owner.x + (.5*sw);
		var y2 = owner.y + (.5*sh);
		part_emitter_region(system,emitter,x1,x2,y1,y2,ps_shape_ellipse,0);
	}
	var num = 1;
	var conditionPercent = 0;
	if condition != "Fountain" {
		conditionPercent = ds_map_find_value(owner.conditionPercentages,condition);
	}
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
			// poison gets worse the longer it goes
			if conditionPercent > 90 {
				num = -2;
			} else if conditionPercent > 50 {
				num = -1;
			} else if conditionPercent > 25 {
				num = 1;
			} else num = 2;
			break;
		}
		case ICE: {
			// starts with many snowflakes but as freeze fades, less
			if conditionPercent > 90 {
				num = 2;
			} else if conditionPercent > 50 {
				num = 1;
			} else if conditionPercent > 25 {
				num = -1;
			} else num = -3;
			break;
		}
		case MAGIC: {
			// starts with many particles, then less
			if conditionPercent > 90 {
				num = 2;
			} else if conditionPercent > 50 {
				num = 1;
			} else if conditionPercent > 25 {
				num = -1;
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
		case "Death": {
			// starts with many particles but as combatant fades, particles dwindle
			var conditionPercent = (-owner.dyingFrame/owner.dyingTotalFrames)+1;
			if conditionPercent > 90 {
				num = 1000;
			} else if conditionPercent > 50 {
				num = 400;
			} else if conditionPercent > 25 {
				num = 100;
			} else num = 20;
			break;
		}
	}
	
	// scale num for sprite size
	/*var sw = sprite_get_bbox_right(owner.sprite_index) - sprite_get_bbox_left(owner.sprite_index);
	var sh = sprite_get_bbox_bottom(owner.sprite_index) - sprite_get_bbox_top(owner.sprite_index);
	num *= ((sw*sh) / 1024);
	num2 *= ((sw*sh) / 1024);
	
	// test
	num *= ((sw*sh) / 1600);
	num2 *= ((sw*sh) / 1600); */
	
	if array_length_1d(particles) == 0 {
		part_emitter_burst(system,emitter,particle, num);
		if particle2 {
			part_emitter_burst(system,emitter,particle2, num2);
		}
	} else {
		for (var i = 0; i < array_length_1d(particles); i++) {
			var part = particles[i];
			part_emitter_burst(system,emitter,part, num);
		}
	}
}
