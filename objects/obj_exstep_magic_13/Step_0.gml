if status != ExerciseStepStatus.InProgress exit;

if exercise.enemy.hp <= 0 {
	status = ExerciseStepStatus.Completed;
}

// do allow the enemy to be killed during this step 
if exercise.enemy && exercise.enemy.hp > 200 {
	with exercise.enemy {
		hp = 100;
		maxHp = 100;
		hpRegen = 0;
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

