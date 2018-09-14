// account for any currently active conditions (slowed/frozen, burning, poisoned, electrified)
var currentCondition = ds_map_find_first(conditionLevels);
var size = ds_map_size(conditionLevels);
for (var i = 0; i < size; i++) {
	if !arrayIncludes(global.ALL_ELEMENTS,currentCondition) exit;
	var conditionLevel = ds_map_find_value(conditionLevels,currentCondition);
	var conditionPercent = ds_map_find_value(conditionPercentages,currentCondition);
	var defense = ds_map_find_value(defenses,currentCondition);
	
	// play condition sound, if not already
	var snd = asset_get_index("snd_magic_"+currentCondition+"_condition");
	var emitter = ds_map_find_value(conditionsEmittersMap, currentCondition);
	audio_emitter_position(emitter,x,y,depth);
	audio_emitter_gain(emitter,conditionPercent/100);
	
	/*if id != global.player && conditionLevel > 0 {
		show_debug_message("emitter pos: " + string(audio_emitter_get_x(emitter)) + ", " + string(audio_emitter_get_y(emitter)));
		var ld = audio_listener_get_data(0); var lx = ds_map_find_value(ld,"x"); var ly = ds_map_find_value(ld,"y");
		show_debug_message("listener pos: " + string(lx) + "," + string(ly));
		var distanceToListener = point_distance(x,y,lx,ly);
		show_debug_message("distance to listener: " + string(distanceToListener));
	}*/
	
	// particle effects for conditions
	if conditionLevel > 0 && currentCondition != PHYSICAL {
		var condParticlesExist = false;
		var c = currentCondition;
		var o = id;
		with (obj_condition_particles) {
			if condition == c && owner == o {
				condParticlesExist = true;
			}
		}
		if !condParticlesExist {
			global.condition = currentCondition;
			global.owner = id;
			instance_create_depth(x,y,1,obj_condition_particles);
		}
	}
	
	// set back old properties when conditions expire
	if conditionLevel <= 0 {
		switch currentCondition {
			case ICE: {
				slowedSpeedModifier = 1; break;
			}
			case FIRE: {
				light_set_scale(lightRadiusScale);
				break;
			}
		}
	}
	else {
		switch currentCondition {
			case ICE: {
				// slowed
				if conditionLevel == 1 {
					if conditionPercent > 0 && conditionPercent < 25 {
						slowedSpeedModifier = .7;
					} else if conditionPercent > 25 && conditionPercent < 50 {
						slowedSpeedModifier = .5;
					} else slowedSpeedModifier = .25;
				}
				// frozen
				else if conditionLevel == 2 {
					slowedSpeedModifier = 0;
				}
				break;
			}
			case MAGIC: {
				hexedDamageModifier = .75-(.005*conditionPercent);
				break;
			}
			// burning
			case FIRE: {
				
				// light radius should flicker
				randomize();
				var lrMin = .75*normalLightRadiusScale;
				var rand = random_range(lrMin, normalLightRadiusScale);
				lightRadiusScale = rand;
				
				// burn damage taken every 2 seconds by default
				// if fire defense is positive, defense% of 60 is added to burn frames
				burnFrames = (defense >= 0) ? 30 + 30*(defense/100) : 30 - 30*(defense/100);
				if burnFrame >= burnFrames {

					var originalBurnDamage = burnDamage;
					if burnDamage <= 1 burnDamage = 1;
					if burnDamage > hp {
						burnDamage = hp;
					}
					hp -= burnDamage;
					//if type != CombatantTypes.Player {
						global.damageAmount = burnDamage;
						global.victim = id;
						global.healingSustained = 0;
						global.isCriticalHit = false;
						instance_create_depth(x,y,1,obj_damage);
					//}
					// diminishes every pulse
					// TODO math major DEVIN
					burnDamage = originalBurnDamage;
					burnDamage = defense >= 0 ? 
						burnDamage - ((.25*burnDamage)-((.25*burnDamage)*(defense/100))) : 
						burnDamage - ((.25*burnDamage)+((.25*burnDamage)*(defense/100)));
					if burnDamage < 1 {
						burnDamage = 1;
					}
					burnFrame = 0;
				}
				burnFrame++;
				break;
			}
			// poisoned
			case POISON: {
				// poison damage taken every 2 seconds by default 
				// if poison defense is poistive, defense% of 60 is added to burn frames. if less, it is subtracted
				poisonFrames = (defense >= 0) ? 30 + 30*(defense/100) : 30 - 30*(defense/100);
				if poisonFrame >= poisonFrames {
					poisonDamage = defense >= 0 ? (poisonDamage - poisonDamage*(defense/100)) : (poisonDamage + poisonDamage*(defense/100));
					var originalPoisonDamage = poisonDamage;
					if poisonDamage > hp {
						poisonDamage = hp;
					}
					if poisonDamage <= 1 poisonDamage = 1;
					hp -= poisonDamage;

					global.damageAmount = poisonDamage;
					global.victim = id;
					global.healingSustained = 0;
					global.isCriticalHit = false;
					instance_create_depth(x,y,1,obj_damage);
					// builds every pulse
					// TODO math major DEVIN
					poisonDamage = originalPoisonDamage;
					poisonDamage = defense >= 0 ? 
						poisonDamage + ((.1*poisonDamage)-((.1*poisonDamage)*(defense/100))) : 
						poisonDamage + ((.1*poisonDamage)+((.1*poisonDamage)*(defense/100)));
					poisonFrame = 0;
				}
				poisonFrame++;
				break;
			}
			case LIGHTNING: {
				// shock lowers defenses; this is handled just once, when lightning percent is set to 100; i.e. not here
			}
		}
	}
	
	currentCondition = ds_map_find_next(conditionPercentages, currentCondition);
}
