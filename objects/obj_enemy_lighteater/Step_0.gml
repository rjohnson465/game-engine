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
			// turn to the light
			turnToFacePoint(turnSpeed, lamplightToEat.x, lamplightToEat.y);
			
			lamplightEatFrame--;
			
			if lamplightEatFrame < 0 {
				// eat the light (maybe after some animation???)
				with lamplightToEat {
					isLit = false;
					extinguishSconce(snd_magic_magic_hit);
				}
			
				// reset healing counter
				randomize();
				alarm[2] = round(random_range(HUNGER_FRAME_MIN, HUNGER_FRAME_MAX));
				
				// return to normal combatant state machine
				lamplightToEat = noone;
				state = CombatantStates.AggroMelee;
			
				lamplightEatFrame = 15;
				lamplightsEatenCount++;
				hp += (maxHp / 2);
				if hp > maxHp hp = maxHp;
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
