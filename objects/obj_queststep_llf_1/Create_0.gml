/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

status = QuestStepStatus.InProgress;

eventListeners = ds_map_create();
ds_map_add(eventListeners, EV_ITEM_PICKEDUP, scr_evl_wires);

description = "Find the 3 elevator wires for Robort to fix the elevator.\n Found 0/3 wires.";

// check if the player has already found some or all of the wires
var wc = 0;
var pinv = global.player.inventory;
for (var i = 0; i < ds_list_size(global.player.inventory); i++) {
	var item = ds_list_find_value(pinv, i);
	if item.object_index == obj_item_wire_b || item.object_index == obj_item_wire_w || item.object_index == obj_item_wire_r {
		wc += 1;
	}
}

// if so, update the initial description
ds_map_replace(parameters,"wiresCount",wc);
description = "Find the 3 elevator wires for Robort to fix the elevator.\n Found " + string(wc) + "/3 wires.";

if wc >= 3 {
	status = QuestStepStatus.Completed;
}