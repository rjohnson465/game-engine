if room == game_menu {
	exit;
}
event_inherited();
if !isMoving isSprinting = false;

// if we release the sprint button during sprinting, reset the sprintCounter and set isHoldingSprintButton to false
if gamepad_button_check_released(gamePadIndex, gp_face2) {
	sprintCounter = sprintCounterTotal;
	isHoldingSprintButton = false;
}

// exp tut first check
var hasHadExpTutFirstMessage = ds_map_find_value(tutorialFirstsMap, TutFirsts.Experience);
if !hasHadExpTutFirstMessage && xpTemp > 0 {
	showTutorialMessage("You gained experience (XP)! Fill the XP bar to level up and gain power. Fresh XP (light blue) can be lost on death -- convert it to fixed XP by wishing at fountains.",
	noone, noone, TutFirsts.Experience, noone);
}

// death
if hp < 1 && isAlive && !isDying {
	window_set_cursor(cr_none);
	isDying = true;
	hp = 0;
	speed = 0;
	totalFlinchFrames = 0;
	
	audio_play_sound(snd_death_fade,1,0);
	
	if currentSpellPrepSound != noone {
		audio_stop_sound(currentSpellPrepSound);
	}
	
	// lose combo mode
	comboModeLevel = 0;
	
	ds_map_clear(preparingLimbs);
	ds_map_clear(attackingLimbs);
	ds_map_clear(recoveringLimbs);
	if fallFrame == fallTotalFrames {
		// create death particles
		global.owner = id;
		randomize();
		var rand = random_range(0,100);
		if ds_map_find_value(conditionPercentages,ICE) > 50 && (rand > 60) {
			global.condition = "IceDeath";
			dyingFrame = dyingTotalFrames;
		} else {
			global.condition = "Death";
		}
		instance_create_depth(x,y,1,obj_condition_particles);
	} else {
		fallScaleFactor = 0;
	}
	state = CombatantStates.Idle;
	// cure any and all conditions
	var currentCondition = ds_map_find_first(conditionPercentages);
	for (var i = 0; i < ds_map_size(conditionPercentages);i++) {
		ds_map_replace(conditionPercentages,currentCondition,0);
		ds_map_replace(conditionLevels,currentCondition,0);
		currentCondition = ds_map_find_next(conditionPercentages, currentCondition);
	}
	endureConditions(); drainConditions(); lightRadiusColor = c_white;
	global.ui.isShowingMenus = false;
	lockOnTarget = noone;
}

if isDying && isAlive {
	if dyingFrame < dyingTotalFrames {
		speed = 0;
		dyingFrame++;
	} else {
		dyingFrame = 0;
		isAlive = false;
		isDying = false;
		instance_create_depth(x,y,1,obj_player_death);
	}
}

if !isAlive {
	speed = 0;
	alpha = 0;
	visible = false;
}




/*
var nearestStairs = instance_nearest(x,y,obj_stairs);
if distance_to_object(nearestStairs) < 200  {
	if !place_meeting_layer(x,y,obj_stairs) && climbingDir != noone {

		global.isUpdatingRoomLayers = true;
		climbingDir = noone;
		

	}
}
