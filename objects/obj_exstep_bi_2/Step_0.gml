if status != ExerciseStepStatus.InProgress exit;

var p = global.player;
var beltHasFlask = false;
for (var i = 0; i < array_length_1d(p.beltItems); i++) {
	var it = p.beltItems[i];
	if !instance_exists(it) continue;
	if it.object_index == obj_item_health_flask {
		beltHasFlask = true;
	}
}

if beltHasFlask && !global.ui.isShowingMenus {
	p.hp = .5 * p.maxHp;
	status = ExerciseStepStatus.Completed;
}

