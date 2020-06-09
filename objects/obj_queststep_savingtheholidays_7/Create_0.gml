/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

status = QuestStepStatus.Unstarted;

description = "Kill the Abominable Snowman";

eventListeners = ds_map_create();
ds_map_add(eventListeners, EV_ENEMY_KILLED, scr_evl_absnowman_killed);