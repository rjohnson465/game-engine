exercise = global.exercise;
name = "Exercise step";
messageController = "Exercise step description (controller)";
messageMk = "Exercise step description (mk)";
promptSpritesController = [];
promptSpritesMk = [];
promptSpritesSeparators = [];

enum ExerciseStepStatus {
	Unstarted,
	InProgress,
	Completed
}

status = ExerciseStepStatus.Unstarted;

// key/value --> <goal_name><value>
parameters = ds_map_create(); 

isFinalStep = false;