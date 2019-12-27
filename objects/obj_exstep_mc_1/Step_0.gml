// This step is marked as done when the player's lock on target is a valid enemy
var p = global.player;

if instance_exists(p.lockOnTarget) {
	status = ExerciseStepStatus.Completed;
}

if status != ExerciseStepStatus.InProgress exit;
// do not allow the enemy to be killed during this step 
if exercise.enemy {
	with exercise.enemy {
		hp = 1000;
		maxHp = 1000;
	}
}
