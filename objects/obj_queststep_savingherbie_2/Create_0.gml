/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

status = QuestStepStatus.Unstarted;

description = "Escort Herbie to Mrs. Claus";

// if hershel wakes up, change description and take clayheart away
eventListeners = ds_map_create();
ds_map_replace(eventListeners, EV_EVENT_STARTED, scr_evl_savingherbie_start);
ds_map_replace(eventListeners, EV_EVENT_FAILED, scr_evl_savingherbie_failed);

