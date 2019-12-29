if status != ExerciseStepStatus.InProgress exit;

var p = global.player;
if !hasCheckedInitialWeapons {
	initWeaponL = ds_map_find_value(p.equippedLimbItems, "l");
	initWeaponR = ds_map_find_value(p.equippedLimbItems, "r");
	hasCheckedInitialWeapons = true;
}