/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

eventName = "Save Herbie!";
associatedWallKeys = ["herbie_wall_1"];

global.event = id;
ds_list_add(eventSteps, instance_create_depth(x,y,1,obj_evstep_saving_herbie_1));


eventListeners = ds_map_create();
ds_map_replace(eventListeners, EV_EVENT_FAILED, scr_evl_savingherbie_failed);
ds_map_replace(eventListeners, EV_EVENT_SUCCESS, scr_evl_savingherbie_success);