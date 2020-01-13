if status != ExerciseStepStatus.InProgress exit;

if global.ui.isShowingMenus {
	with exercise {
		doNotShowParticles = true;
	}
} else {
	exercise.doNotShowParticles = false;
}

if global.player.currentSpell == "projectile" {
	status = ExerciseStepStatus.Completed;
	if !instance_exists(exercise.enemy) {
		exercise.enemy = instance_create_layer(3710, 2080, global.player.layer, obj_enemy_unfairy);
		with exercise.enemy {
			ei_unfairy_unarmed();
		}
	}
}


