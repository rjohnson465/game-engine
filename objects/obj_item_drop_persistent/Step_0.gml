// particles
if layer >= global.player.layer {
	part_emitter_region(system,emitter,bbox_left,bbox_right,bbox_top,bbox_bottom,ps_shape_ellipse,ps_distr_gaussian);
	part_emitter_burst(system,emitter,particle, 2);
}
if global.isReadingTutorial exit;
global.isLooting = false;
var interactInputReceived = keyboard_check_pressed(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_pressed(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}

var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

if distance_to_object(obj_player) < distToPickup && layer == global.player.layer && interactInputReceived && global.player.isAlive && !global.isLooting && !isInConvo {
	// only loot the closest item, if multiple items exist that are within distToPickuppx of player
	if instance_nearest(global.player.x,global.player.y,obj_item_drop_persistent) == id {
		var isDestroying = false;
		with obj_item_drop_persistent {
			if hasSetAlarm && id == other {
				isDestroying = true;
			}
		} if !isDestroying {
			if !isBeingLooted {
				audio_play_sound(snd_ui_click1,1,0);
			}
			isBeingLooted = true;
		}
	}
} 
else if distance_to_object(obj_player) < distToPickup && global.player.isAlive && !global.isLooting {
	global.canLoot = true;
}
else if distance_to_object(obj_player) >= distToPickup {
	isBeingLooted  = false;
	global.canLoot = false;
}

// ensure items are not anywhere on screen if not being looted
if (!isBeingLooted && ds_exists(items,ds_type_list)) || (distance_to_object(obj_player) > distToPickup && ds_exists(items,ds_type_list))  {
	for (var i = 0; i < ds_list_size(items); i++) {
		var item = ds_list_find_value(items,i);
		item.x1 = -100;
		item.y1 = -100;
	}
	global.isLooting = false;
} else if isBeingLooted {
	global.isLooting = true;
}

if (!ds_exists(items,ds_type_list) || ds_list_size(items) == 0) && !hasSetAlarm {
	alarm[0]=3;
	hasSetAlarm = true;
}

if global.ui.isShowingMenus isBeingLooted = false;

