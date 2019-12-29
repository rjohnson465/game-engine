/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// activate exercise on touch
var p = global.player;

if rectangle_in_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, p.bbox_left, p.bbox_top, p.bbox_right, p.bbox_bottom) 
	&& !isActive && !isFinished {
		
	isActive = true;
	sprite_index = noone;
	alert("Tutorial Started: " + exerciseName, c_aqua);
	audio_play_sound(snd_sword_draw, 1, 0);
	
	// set all steps to inactive, except the first one
	for (var i = 0; i < ds_list_size(exerciseSteps); i++) {
		var step = ds_list_find_value(exerciseSteps, i);
		step.status = ExerciseStepStatus.Unstarted;
	}
	
	currentExerciseStep = ds_list_find_value(exerciseSteps,0);
	currentQuestStepIndex = 0;
	currentExerciseStep.status = ExerciseStepStatus.InProgress;
}

// activate associated walls when active
if isActive && !hasActivatedWalls {
	for (var i = 0; i < array_length_1d(associatedWallKeys); i++) {
		var wKey = associatedWallKeys[i];
		var w = noone;
		with obj_tutorial_exercise_wall {
			if key == wKey {
				w = id;
			}
		}
		
		if w != noone {
			w.isUntraversable = true;
		}
	}
	
	hasActivatedWalls = true;
	
	global.isTutorialInProgress = true;
}

if isActive {
	part_emitter_burst(system, emitter, part, 25);
}
