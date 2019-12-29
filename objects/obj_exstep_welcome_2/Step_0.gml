if status != ExerciseStepStatus.InProgress exit;

// This step is done when player gets first weapon from barry
var p = global.player;

var hasWeapon = false;
for (var i = 0; i < ds_list_size(p.inventory); i++) {
	var it = ds_list_find_value(p.inventory, i);
	if it.type == ItemTypes.HandItem {
		hasWeapon = true;
	}
}

if hasWeapon {
	status = ExerciseStepStatus.Completed;
}
