if status != ExerciseStepStatus.InProgress exit;

if exercise.enemy.hp <= 0 {
	with exercise {
		instance_destroy(fallenTree1, true);
		instance_destroy(fallenTree2, true);
	}
	status = ExerciseStepStatus.Completed;
}

// if player runs out of ammo, just give them more
var bow = noone;
with obj_hand_item_shortbow {
	if owner == global.player {
		bow = id;
	}
}

if bow != noone && bow.ammo == 0 {
	bow.ammo = bow.ammoMax;
	alert("Your bow's ammo has been refilled, as part of this tutorial", c_aqua);
}

// do allow the enemy to be killed during this step 
if exercise.enemy && exercise.enemy.hpRegen > 1 {
	with exercise.enemy {
		hp = 50;
		maxHp = 50;
		hpRegen = 0;
	}
}


