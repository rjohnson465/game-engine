/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

eventName = "Save Hershel!";
associatedWallKeys = ["hershel_wall_1"];

global.event = id;
ds_list_add(eventSteps, instance_create_depth(x,y,1,obj_evstep_saving_hershel_1));

eventBgm = snd_bgm_ev_fight_1;
