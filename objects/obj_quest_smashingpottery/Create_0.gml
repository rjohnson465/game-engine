/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

questGiver = obj_npc_barry;
name = "Smashing Pottery";
description = "The once-noble Golem Lord Amir has been possessed by a terrible dybukk. I must return him to the clay he came from, for David.";

global.quest = id;
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_smashingpottery_1));

xpReward = 500;