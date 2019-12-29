if status != ExerciseStepStatus.InProgress exit;

if global.ui.isShowingMenus {
	with exercise {
		doNotShowParticles = true;
	}
} else {
	exercise.doNotShowParticles = false;
}

var p = global.player;
var curBeltItem = p.beltItems[p.currentBeltItemIndex];

if !gamepad_is_connected(global.gamePadIndex) || curBeltItem.object_index == obj_item_healthshard {
	status = ExerciseStepStatus.Completed;
}


