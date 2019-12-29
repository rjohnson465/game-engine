if status != ExerciseStepStatus.InProgress exit;

// This step is done when player watches quest
if global.questLog.watchedQuest != noone && !global.ui.isShowingMenus {
	status = ExerciseStepStatus.Completed;
}

