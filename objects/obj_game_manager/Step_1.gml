if global.activateAll {
	instance_activate_all();
}

if global.isPopulatingGrids {
	// must activate all instances on step 1,
	if !hasReactivatedObjectsForGrids {
		instance_activate_all();
		hasReactivatedObjectsForGrids = true;
	}
	// then when next step happens, actually populate grids
	else {
		populateGrids();
		if global.respawnEnemiesAfterGridsPopulate {
			respawnEnemies();
			with global.player {
				jumpToNearestFreePoint(false, true);
			}
		}
		hasReactivatedObjectsForGrids = false;
		global.isPopulatingGrids = false;
		global.respawnEnemiesAfterGridsPopulate = false;
	}
}

if global.isUpdatingRoomLayers {
	// must activate all instances on step 1,
	if !hasReactivatedObjectsForLayers {
		instance_activate_all();
		hasReactivatedObjectsForLayers = true;
	}
	// then when next step happens, actually update layer elements visibility
	else {
		updateRoomLayers();
		hasReactivatedObjectsForLayers = false;
		global.isUpdatingRoomLayers = false;
	}
}

if global.isReturningToMainMenu {
	// must activate all instances on step 1,
	if !hasReactivatedObjectsForLayers {
		instance_activate_all();
		hasReactivatedObjectsForLayers = true;
	}
	// then when next step happens, actually go back to menu
	else {
		room_goto(game_menu);
		hasReactivatedObjectsForLayers = false;
		global.isReturningToMainMenu = false;
	}
}


var p = global.player;
audio_emitter_position(ambEmitter, p.x, p.y, p.depth);
// amb periodicals stuff
if ds_map_size(ambPeriodicalsMap) > 0 {
	// iterate over every snd in ambPeriodicals
	// if the snd is not playing and the frames are not set, set them
	// else, decrement them
	var ck = ds_map_find_first(ambPeriodicalsMap);
	var entryArr = ds_map_find_value(ambPeriodicalsMap, ck);
	for (var i = 0; i < ds_map_size(ambPeriodicalsMap); i++) {
		var snd = ck;
		var emitter = ds_map_find_value(ambpEmitters, snd);
		if audio_emitter_get_gain(emitter) == 0 {
			var frame = ds_map_find_value(ambpFrames, snd);
			// reset frame
			if frame < 0 {
				var freq = entryArr[0];
				ds_map_replace(ambpFrames, snd, freq);
			}
			// maybe play sound
			else if frame == 0 {
				
				// roll 
				var chance = entryArr[1];
				randomize();
				var r = random_range(0,1);
				// play sound
				if r < chance {
					var durArr = entryArr[2];
					var minDur = durArr[0];
					var maxDur = durArr[1];
					randomize();
					var rand = random_range(minDur, maxDur);
					ds_map_replace(ambpFrames, snd, rand); // this how many frames to play the sound now
					ds_map_replace(ambpFrameStarts, snd, rand);
					audio_emitter_gain(emitter, .01);
				} else {
					var val = ds_map_find_value(ambpFrames, snd);
					ds_map_replace(ambpFrames, snd, val - 1);
				}
			}
			else {
				var val = ds_map_find_value(ambpFrames, snd);
				ds_map_replace(ambpFrames, snd, val - 1);
			}
		}
		// sound is playing on emitter, play it for <frames> duration
		else {
			var fadeInFrames = entryArr[3];
			var fadeOutFrames = entryArr[4];
			var startFrame = ds_map_find_value(ambpFrameStarts, snd);
			var frame = ds_map_find_value(ambpFrames, snd);
			
			var emitterGain = 1;
			// maybe fade in, if we're within fadeInFrames of the startFrame
			if frame + fadeInFrames >= startFrame {
				var framesFromStart = startFrame - frame;
				emitterGain = framesFromStart / fadeInFrames;
			}
			// maybe fade out
			if frame <= fadeOutFrames {
				emitterGain = frame / fadeOutFrames;
			}
			if emitterGain == 0 emitterGain = .01;
			
			audio_emitter_gain(emitter, emitterGain);
			ds_map_replace(ambpFrames, snd, frame - 1); // decrement frame
			if frame <= 0 {
				audio_emitter_gain(emitter, 0);
			}
		}
		
		ck = ds_map_find_next(ambPeriodicalsMap, ck);
	}
}

selectedItemFilterAlpha = .5*cos((pi*selectedItemFilterAlphaFrame)/30)+.6; // fluctuate alpha for selected item filter
selectedItemFilterAlphaFrame--;
if selectedItemFilterAlphaFrame <= 0 {
	selectedItemFilterAlphaFrame = 60;
}

/*
var vx = camera_get_view_x(view_camera[0]); var vy = camera_get_view_y(view_camera[0]);
var vw = camera_get_view_width(view_camera[0]); var vh = camera_get_view_height(view_camera[0]);

instance_activate_object(obj_solid_environment);
with obj_solid_environment {
	if !point_in_rectangle(x,y,vx-500,vy-500,vx+vw+500,vy+vh+500) {
		instance_deactivate_object(id);
	}
}


instance_activate_object(obj_enemy_parent);
with obj_enemy_parent {
	if  state == CombatantStates.Idle &&
		(!point_in_rectangle(x,y,vx-500,vy-500,vx+vw+500,vy+vh+500) ||
			layer != global.player.layer
		)
		{
			hp = maxHp;
			instance_deactivate_object(id);
		}
}