if status != ExerciseStepStatus.InProgress exit;

if global.ui.isShowingMenus {
	with exercise {
		doNotShowParticles = true;
	}
} else {
	exercise.doNotShowParticles = false;
}

var p = global.player;
// This step is done when player switches weapon
var wl = ds_map_find_value(p.equippedLimbItems, "l");
var wr = ds_map_find_value(p.equippedLimbItems, "r");

if wl != initWeaponL || wr != initWeaponR {
	status = ExerciseStepStatus.Completed;
}

