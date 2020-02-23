/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

status = QuestStepStatus.Unstarted;

description = "Fetch David's Star (in Clayfields). Fetch Santa's Star (in Krampus Campus)";

eventListeners = ds_map_create();
ds_map_add(eventListeners, EV_ITEM_PICKEDUP, scr_evl_sth_stars);

activationScript = scr_sth_stars_activation;