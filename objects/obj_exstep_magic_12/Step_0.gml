if status != ExerciseStepStatus.InProgress exit;

// listen for enemy to be hit three times with blast spell

if status == ExerciseStepStatus.InProgress && ds_map_size(eventListeners) == 0 {
	ds_map_add(eventListeners, EV_DAMAGE_TAKEN, scr_evl_exstep_magic_iceexplosion);
}

if hitsReceived >= 3 {
	status = ExerciseStepStatus.Completed;
	if ds_exists(eventListeners, ds_type_map) {
		ds_map_destroy(eventListeners); eventListeners = -1;
	}
}

// do not allow the enemy to be killed during this step 
if exercise.enemy {
	with exercise.enemy {
		hp = 10000;
		maxHp = 10000;
	}
}

// do not allow player to run out of charges during this step
var didFillCharges = false;
with obj_hand_item_wand {
	if owner == global.player {
		if charges == 0 {
			charges = chargesMax;
			didFillCharges = true;
		}
	}
}
if didFillCharges {
	alert("Your wand's charges have been refilled, as part of this tutorial", c_aqua);
}
