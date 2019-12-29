/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

exerciseName = "Basic Combat";

global.exercise = id;
ds_list_add(exerciseSteps, instance_create_depth(x,y,1,obj_exstep_mc_1));
ds_list_add(exerciseSteps, instance_create_depth(x,y,1,obj_exstep_mc_2));
ds_list_add(exerciseSteps, instance_create_depth(x,y,1,obj_exstep_mc_3));
ds_list_add(exerciseSteps, instance_create_depth(x,y,1,obj_exstep_mc_4));
ds_list_add(exerciseSteps, instance_create_depth(x,y,1,obj_exstep_mc_5));
ds_list_add(exerciseSteps, instance_create_depth(x,y,1,obj_exstep_mc_6));
ds_list_add(exerciseSteps, instance_create_depth(x,y,1,obj_exstep_mc_7));
ds_list_add(exerciseSteps, instance_create_depth(x,y,1,obj_exstep_mc_8));
ds_list_add(exerciseSteps, instance_create_depth(x,y,1,obj_exstep_mc_9));


// the enemy we are learning with
enemyKey = "mc1_enemy";
enemy = noone;