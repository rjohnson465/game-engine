/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

status = QuestStepStatus.InProgress;

description = "Place the Clayheart within Hershel";

// if hershel wakes up, change description and take clayheart away
eventListeners = ds_map_create();
ds_map_replace(eventListeners, EV_EVENT_STARTED, scr_evl_helpinghershel_1);
ds_map_replace(eventListeners, EV_EVENT_FAILED, scr_evl_helpinghershel_1_fail);
ds_map_replace(eventListeners, EV_EVENT_SUCCESS, scr_evl_helpinghershel_1_success);