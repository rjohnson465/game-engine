/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

eventName = "Slay the Ice-Troll";
associatedWallKeys = ["troll_wall_1", "troll_wall_2", "troll_wall_3", "troll_wall_4", "troll_wall_5"];

global.event = id;
ds_list_add(eventSteps, instance_create_depth(x,y,1,obj_evstep_icetrollguard_1));

eventBgm = snd_bgm_ev_fight_1;