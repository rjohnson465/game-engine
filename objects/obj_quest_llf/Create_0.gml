/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

questGiver = obj_npc_barry;
name = "Investigate the Lamplight Factory";
description = "I've tracked the unfairy invaders to our sacred Lamplight Factory. I must investigate and see what I can find.";

global.quest = id;
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_llf_1));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_llf_2));

xpReward = 800;