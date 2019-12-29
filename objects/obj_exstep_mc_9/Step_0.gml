if status != ExerciseStepStatus.InProgress exit;

if exercise.enemy.hp <= 0 {
	status = ExerciseStepStatus.Completed;
}

// do allow the enemy to be killed during this step 
if exercise.enemy && exercise.enemy.hp > 55 {
	with exercise.enemy {
		hp = 50;
		maxHp = 50;
	}
}
