var interactInputReceived = keyboard_check_released(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_released(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}

if distance_to_object(obj_player) < 20 && layer == global.player.layer && !global.isWishing && !global.canLoot && !global.isLooting && global.player.isAlive && !global.ui.isShowingMenus && !isInConversation {
	global.canInteractWithNpc = true;
} else {
	global.canInteractWithNpc = false;
}

if distance_to_object(obj_player) < 20 && layer == global.player.layer {
	//turnToFacePoint(10,global.player.x,global.player.y);
}

var canLoot = false;
with obj_item_drop {
	if distance_to_object(obj_player) < 20 && layer == global.player.layer {
		canLoot = true;
	}
}

if distance_to_object(obj_player) < 20 && layer == global.player.layer && !global.isWishing && !global.canLoot && !canLoot && !global.isLooting && global.player.isAlive && !global.ui.isShowingMenus && interactInputReceived && !isInConversation && !isInteractingWithPlayer {
	isInteractingWithPlayer = true;
	global.player.state = CombatantStates.Idle;
	state = CombatantStates.Idle; speed = 0;
	audio_play_sound_at(greeting,x,y,0,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
} else if distance_to_object(obj_player) > 20 {
	isInteractingWithPlayer = false;
	global.isInteractingWithNpc = false;
}

if isInteractingWithPlayer && !isInConversation {
	global.isInteractingWithNpc = true;
}

if isInteractingWithPlayer || isInConversation {
	turnToFacePoint(15,global.player.x,global.player.y);
}

if gamepad_is_connected(global.player.gamePadIndex) && (selectedConversation == noone || !instance_exists(selectedConversation)) && ds_list_size(conversations) > 0 {
	selectedConversation = ds_list_find_value(conversations,0);
}

// wander, but only if near enough to player to be on screen
if state == CombatantStates.Moving && distance_to_object(global.player) < 1000 {
	if distance_to_point(postX, postY) < 250 && !isInteractingWithPlayer && !isInConversation {
		moveToNearestFreePoint(direction,normalSpeed,1);
		facingDirection = direction;

	} else {
		randomize();
		var goodDir = point_direction(x,y,postX,postY);
		direction = random_range(goodDir-20,goodDir+20);
		moveToNearestFreePoint(abs(direction),normalSpeed,1);
		facingDirection = direction;

	}
	if isInConversation || isInteractingWithPlayer {
		state = CombatantStates.Idle;
		speed = 0;
	}
} else {
	speed = 0;
}

if place_meeting_layer(x,y,obj_player) {
	jumpToNearestFreePoint(true);
}