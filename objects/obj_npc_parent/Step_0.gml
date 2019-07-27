var interactInputReceived = keyboard_check_released(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_released(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus && hasReleasedInteract && !isInConversation)
}

if distance_to_object(obj_player) < 20 && layer == global.player.layer && !global.isWishing && !global.canLoot && !global.isLooting && global.player.isAlive && !global.ui.isShowingMenus && !isInConversation {
	global.canInteractWithNpc = true;
} else {
	global.canInteractWithNpc = false;
}

var canLoot = false;
with obj_item_drop {
	if distance_to_object(obj_player) < 20 && layer == global.player.layer {
		canLoot = true;
	}
}

maybeAddOrRemoveFromInteractablesList(20);

if	// distance_to_object(obj_player) < 20 
	global.player.currentInteractableObject == id &&
	layer == global.player.layer && !global.isTrading && !global.isWishing && !global.isLooting && global.player.isAlive && !global.ui.isShowingMenus && interactInputReceived && !isInConversation && !isInteractingWithPlayer {
	
	// find out if we have any urgent conversations
	// get all the urgent conversations' narrative placements,
	// then start the one earliest in the narrative
	var urgentConversationsNarrativeStates = ds_list_create();
	for (var i = 0; i < ds_list_size(conversations); i++) {
		var c = ds_list_find_value(conversations, i);
		if c.isUrgent {
			ds_list_add(urgentConversationsNarrativeStates, c.narrativeState);
		}
	}
	if ds_list_size(urgentConversationsNarrativeStates) > 0 {
		// sort urgent conversations by narrative point
		ds_list_sort(urgentConversationsNarrativeStates, true);
		var earliestNarrativeState = ds_list_find_value(urgentConversationsNarrativeStates, 0);
		
		// find the urgent conversation with "earliestNarrativeState"
		// this assumes there are never 2 urgent conversations with the same narrative state 
		var urgentConversation = noone;
		for (var i = 0; i < ds_list_size(conversations); i++) {
			var c = ds_list_find_value(conversations, i);
			if c.isUrgent && c.narrativeState == earliestNarrativeState {
				urgentConversation = c;
			}
		}
		isInteractingWithPlayer = true;
		startConversation(urgentConversation);
	}
	else if !isInteractingWithPlayer {
		// open conversations window, if this NPC has no "urgent" conversations
		isInteractingWithPlayer = true;
		global.player.state = CombatantStates.Idle;
		state = CombatantStates.Idle; speed = 0;
		var g = greeting;
		if is_array(g) {
			randomize();
			var rand = random_range(0, array_length_1d(g));
			g = g[rand];
		}
		
		// Do not play a greeting if you are already playing a greetings
		var doNotPlayGreeting = false;
		if is_array(greeting) {
			for (var i = 0; i < array_length_1d(greeting); i++) {
				var gr = greeting[i];
				if audio_is_playing(gr) {
					doNotPlayGreeting = true;
				}
			}
		} else {
			if audio_is_playing(greeting) {
				doNotPlayGreeting = true;
			}
		}
		if !doNotPlayGreeting {
			audio_play_sound_at(g,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
		}
	}
	
	ds_list_destroy(urgentConversationsNarrativeStates); urgentConversationsNarrativeStates = -1; // mem leak
	
} 


if isInteractingWithPlayer && !isInConversation {
	global.isInteractingWithNpc = true;
}

if isInteractingWithPlayer || isInConversation {
	turnToFacePoint(15,global.player.x,global.player.y);
	with global.player {
		turnToFacePoint(15,other.x,other.y);
	}
}

if gamepad_is_connected(global.player.gamePadIndex) && (selectedConversation == noone || !instance_exists(selectedConversation)) && ds_list_size(conversations) > 0 {
	selectedConversation = ds_list_find_value(conversations,0);
	
}


// wander, but only if near enough to player to be on screen
if state == CombatantStates.Moving && distance_to_object(global.player) < 1000 && !isInteractingWithPlayer && wanders {
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

if place_meeting_layer(x,y,obj_player) && wanders {
	jumpToNearestFreePoint(true);
}