if status != ExerciseStepStatus.InProgress exit;


/*
// This step is done when player either moves or interacts with Barry
var pad = global.gamePadIndex;
if	(gamepad_is_connected(pad) && gamepad_button_check_pressed(pad, gp_face1) && confirmDestroyOption == "Y") || 
	(confirmDestroyOption == "Y" && mouse_check_button_pressed(mb_left)) {
	status = ExerciseStepStatus.Completed;
}

