/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

eventName = "Survive the Golems";
associatedWallKeys = ["golems_wall_1", "golems_wall_2", "golems_wall_3", "golems_wall_4"];

global.event = id;
ds_list_add(eventSteps, instance_create_depth(x,y,1,obj_evstep_golemattack_1));
ds_list_add(eventSteps, instance_create_depth(x,y,1,obj_evstep_golemattack_2));
