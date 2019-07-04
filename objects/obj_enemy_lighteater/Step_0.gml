event_inherited();

if hp < 1 exit;

// handle hunger / healing

// if health is below 50%, we may attempt healing every so often
if hp < (maxHp/2) && alarm[2] == -4 {
	randomize();
	alarm[2] = round(random_range(HUNGER_FRAME_MIN, HUNGER_FRAME_MAX));
} else if hp > (maxHp/2) {
	alarm[2] = -4;
}

if state == "Eat" {
	if lamplightToEat == noone {
		path_end();
		// if there are no lit lamplights in the room, leave this state
		var litLamplights = ds_list_create();
		with obj_fairylight {
			if isLit {
				ds_list_add(litLamplights, id);
			}
		}
		if ds_list_size(litLamplights) == 0 {
			lamplightToEat = noone;
			state = CombatantStates.AggroMelee;
			lamplightEatFrame = LAMPLIGHT_EAT_FRAME_MAX;
			stopEatingDamage = 0;
			ds_list_clear(stopEatingDamageAttacksList);
		} else {
			// pick a lamplight randomly
			randomize();
			var index = round(random_range(0, ds_list_size(litLamplights)-1));
			lamplightToEat = ds_list_find_value(litLamplights, index);
		}
		ds_list_destroy(litLamplights); litLamplights = -1;
	} else {
		// we have chosen a lamplight to eat
		if distance_to_object(lamplightToEat) < 10 {
			path_end(); speed = 0;
			// turn to the light
			turnToFacePoint(turnSpeed, lamplightToEat.x, lamplightToEat.y);
			
			// play heal sound
			if lamplightEatFrame == LAMPLIGHT_EAT_FRAME_MAX {
				audio_play_sound_at(snd_enemy_lighteater_heal, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
			}
			
			lamplightEatFrame--;
			
			// heal half health gradually
			var amountToHealTotal = LAMPLIGHT_TOTAL_HEAL_AMOUNT;
			var amountToHealPerFrame = amountToHealTotal / LAMPLIGHT_EAT_FRAME_MAX;
			hp += amountToHealPerFrame;
			if hp > maxHp {
				hp = maxHp;
			}
			// gradually lower light brilliance
			with lamplightToEat.lightRadius {
				var aVal = (.75/other.LAMPLIGHT_EAT_FRAME_MAX) * other.lamplightEatFrame;
				light_set_alpha(aVal);
			}
			
			// emit some healing particles
			part_emitter_region(partSystemLighteater, partEmiLighteater, bbox_left, bbox_right, bbox_top, bbox_bottom, ps_shape_ellipse, ps_distr_gaussian);
			part_emitter_burst(partSystemLighteater, partEmiLighteater, partLamplightHeal, 3);
			
			// maybe apply an attack's damage to stopEatingDamage
			with obj_attack {
				// add an attack that's hitting the lighteater to a list
				if owner != other && distance_to_object(other) < 5 {
					if ds_list_find_index(other.stopEatingDamageAttacksList, id) == -1 {
						ds_list_add(other.stopEatingDamageAttacksList, id);
						
						// apply damage 
						if weapon {
							var dmg = 0;
							for (var i = 0; i < array_length_1d(global.ALL_DAMAGE_TYPES); i++) {
								var curEl = global.ALL_DAMAGE_TYPES[i];
								var damagesArr = ds_map_find_value(weapon.damages, curEl);
								var dmgMin = damagesArr[0];
								dmg += dmgMin;
							}

							other.stopEatingDamage += dmg;
						}
					}
				}
			}
			
			// every frame, go over the attacks we've been hit with during eating
			// if that attack no longer exists, remove it from our list
			var atksToRemove = ds_list_create();
			for(var i = 0; i < ds_list_size(stopEatingDamageAttacksList); i++) {
				var atkObj = ds_list_find_value(stopEatingDamageAttacksList, i);
				if !instance_exists(atkObj) {
					ds_list_add(atksToRemove, atkObj);
				}
			}
			
			for (var i = 0; i < ds_list_size(atksToRemove); i++) {
				var atkObj = ds_list_find_value(stopEatingDamageAttacksList, i);
				var index = ds_list_find_index(stopEatingDamageAttacksList, atkObj);
				if index != -1 {
					ds_list_delete(stopEatingDamageAttacksList, index);
				}
			}
			
			ds_list_destroy(atksToRemove); atksToRemove = -1; // mem leak
			
			// we should stop eating if lamplightEatFrame is 0
			// OR if we have taken too much damage while eating
			var takenTooMuchDamage = false;
			if stopEatingDamage >= stopEatingDamageMax {
				takenTooMuchDamage = true;
			}
			
			if lamplightEatFrame < 0 || takenTooMuchDamage {
				ds_list_clear(stopEatingDamageAttacksList); 
				stopEatingDamage = 0;
				
				lamplightEatFrame = LAMPLIGHT_EAT_FRAME_MAX;
				
				// eat the light (maybe after some animation???)
				with lamplightToEat {
					isLit = false;
					extinguishSconce(snd_magic_magic_hit, false);
				}
			
				// reset healing counter
				randomize();
				alarm[2] = round(random_range(HUNGER_FRAME_MIN, HUNGER_FRAME_MAX));
				
				// return to normal combatant state machine
				lamplightToEat = noone;
				state = CombatantStates.AggroMelee;
			
				lamplightEatFrame = LAMPLIGHT_EAT_FRAME_MAX;
				lamplightsEatenCount++;
			}
		} else {
			// go to the light
			mp_potential_path(path, lamplightToEat.x, lamplightToEat.y, functionalSpeed, 4, false);
			path_start(path, functionalSpeed, path_action_stop, false);
			turnToFacePoint(turnSpeed, lamplightToEat.x, lamplightToEat.y);
			//faceMovingDirection();
		}
	}
}
