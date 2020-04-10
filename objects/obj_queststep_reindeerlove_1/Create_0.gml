/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

status = QuestStepStatus.InProgress;

eventListeners = ds_map_create();
ds_map_add(eventListeners, EV_ITEM_PICKEDUP, scr_evl_carrots);

description = "Find carrots";

// scr_reindeerlove_activation();

