var p = global.player;

var interactInputReceived = keyboard_check_released(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_released(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}

var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

if !isFed && instance_number(obj_quest_muskoxfeeder) && !(instance_nearest(x, y, obj_quest_muskoxfeeder).isFinished) {
	maybeAddOrRemoveFromInteractablesList(20);
}

if	p.currentInteractableObject == id && instance_number(obj_quest_muskoxfeeder)
	&& origLayer == p.layer && interactInputReceived && p.isAlive && !global.isLooting && !isInConvo {
	
	if isFed {
		alert("This muskox has already been fed", c_yellow);
	} else {
		// alert("Muskox fed!", c_lime);
		isFed = true;
		// ds_map_replace(properties, "IsFed", true);
		updatePersistentElementProperty(id, "IsFed", true);
		removeFromInteractablesList();
		audio_play_sound_at(snd_muskox_moo_2, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
		with obj_queststep_muskoxfeeder_1 {
			if status == QuestStepStatus.InProgress {
				var curFedCount = ds_map_find_value(parameters, "fedCount");
				var newFedCount = curFedCount + 1;
				ds_map_replace(parameters, "fedCount", newFedCount);
				description = string(newFedCount) + "/" + string(maxFedCount) + " muskox fed";
				if (newFedCount) >= maxFedCount {
					status = QuestStepStatus.Completed;
				}
			}
		}
	}
	
} 


// wander, but only if near enough to player to be on screen
if state == CombatantStates.Moving && distance_to_object(global.player) < 1000 && wanders {
	if distance_to_point(postX, postY) < 250 {
		moveToNearestFreePoint(direction,normalSpeed,1, true);
		facingDirection = direction;
	} else {
		randomize();
		var goodDir = point_direction(x,y,postX,postY);
		direction = random_range(goodDir-20,goodDir+20);
		moveToNearestFreePoint(abs(direction),normalSpeed,1, true);
		facingDirection = direction;
		

	}
} else {
	speed = 0;
}


// if fed, burst heart particles overhead
if isFed {
	part_emitter_region(system, emitter, bbox_left, bbox_right, bbox_top, bbox_bottom, ps_shape_ellipse, ps_distr_gaussian);
	part_emitter_burst(system, emitter, particle, -8);
}