if !ds_exists(exercise.exerciseSteps,ds_type_list) exit;
if !exercise.isActive exit;

var pos = ds_list_find_index(exercise.exerciseSteps,id);
var nextStep = ds_list_find_value(exercise.exerciseSteps,pos+1);
if status == ExerciseStepStatus.Completed && nextStep != undefined && nextStep != noone && instance_exists(nextStep) {
	
	// by default, alert player this exercise step is completed 
	if nextStep.status == ExerciseStepStatus.Unstarted {
		if !exercise.isFinished {
			// play a sound to alert player step has ended
			audio_play_sound(snd_sword_draw, 1, 0);
			
			with exercise {
				part_particles_clear(system);
			}
		}
		nextStep.status = ExerciseStepStatus.InProgress;
		exercise.currentExerciseStep = nextStep;
		exercise.currentExerciseStep = pos+1;
	}
}

if status == ExerciseStepStatus.Completed && nextStep == undefined && exercise.isActive {
	// TODO finish exercise
	with exercise {
		
		alert("Tutorial Complete: " + exerciseName, c_aqua);
		audio_play_sound(snd_ui_quest_complete_alert, 1, 0);
		
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
}