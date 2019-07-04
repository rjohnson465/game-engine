// fountain interaction
var interactInputReceived = keyboard_check_released(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_released(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}


// to draw under hands
var lDepth = layer_get_depth(origLayer);
lDepth += 2;
depth = lDepth;

var fade = noone;
with obj_fade {
	if owner == other.id {
		fade = id;
	}
}

var areActiveEnemiesNearby = false;
if instance_exists(obj_enemy_parent) {
	var nearbyEnemies = scr_get_ids_region(obj_enemy_parent,x-400,y+-400,x+400,y+400);
	for (var i = 0; i < ds_list_size(nearbyEnemies); i++) {
		var enemy = ds_list_find_value(nearbyEnemies,i);
		if enemy.layer == global.player.layer && enemy.lockOnTarget != noone {
			areActiveEnemiesNearby = true;
		}
	}
	if nearbyEnemies != noone {
		ds_list_destroy(nearbyEnemies); nearbyEnemies = -1;
	}
}

var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

if origLayer != global.player.layer exit;

maybeAddOrRemoveFromInteractablesList(20);

if	// distance_to_object(obj_player) < 20 && 
	global.player.currentInteractableObject == id &&
	origLayer == global.player.layer && interactInputReceived && fade == noone && !areActiveEnemiesNearby && global.player.isAlive && !inUse && !global.ui.isShowingMenus && !isInConvo {
	// begin revive dead enemies
	global.fadeDuration = 30;
	global.owner = id;
	instance_create_depth(x,y,-100000,obj_fade);
} 
else if fade != noone {
	if fade.frame == .5*fade.fadeDuration {
		wishAtDarkFountain();
	} 
} else if distance_to_object(obj_player) < 20 && interactInputReceived && areActiveEnemiesNearby && !global.isWishing {
	alert("Cannot use fountains when enemies are nearby",c_red);
}

