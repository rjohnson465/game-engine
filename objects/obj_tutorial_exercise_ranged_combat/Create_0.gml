/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

exerciseName = "Ranged Combat";

global.exercise = id;
ds_list_add(exerciseSteps, instance_create_depth(x,y,1,obj_exstep_rc_1));
ds_list_add(exerciseSteps, instance_create_depth(x,y,1,obj_exstep_rc_2));
ds_list_add(exerciseSteps, instance_create_depth(x,y,1,obj_exstep_rc_3));
ds_list_add(exerciseSteps, instance_create_depth(x,y,1,obj_exstep_rc_4));

// the enemy we are learning with
enemyKey = "rc1_enemy";
enemy = noone;

enemyKey2 = "rc1_enemy2";
enemy2 = noone;

enemyKey3 = "rc1_enemy3";
enemy3 = noone;

hasDroppedTrees = false;