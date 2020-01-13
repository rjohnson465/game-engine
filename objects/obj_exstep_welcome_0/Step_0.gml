if status != ExerciseStepStatus.InProgress exit;

if !hasStunnedPlayer {
	global.isTrading = true;
	hasStunnedPlayer = true;
}
