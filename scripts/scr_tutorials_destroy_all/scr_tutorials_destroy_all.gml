/// scr_tutorials_destroy_all

// kill all tutorials
with obj_tutorial_exercise_parent {
	isActive = false;
	isFinished = true;
	updatePersistentElementProperty(id, "isFinished", true);
		
	global.isTutorialInProgress = false;
				
	// make associated walls traversable
	for (var i = 0; i < array_length_1d(associatedWallKeys); i++) {
		var wKey = associatedWallKeys[i];
		var w = noone;
		with obj_tutorial_exercise_wall {
			if key == wKey {
				w = id;
			}
		}
		if w != noone {
			w.isUntraversable = false;
		}
	}
		
	// destroy exercise instance, which should destroy all its steps
	instance_destroy(id, 1);
}