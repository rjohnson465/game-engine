/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

questGiver = obj_npc_barry;
name = "Saving the Holidays";
description = "I tracked Tony to Winter Wonderground, where he escaped into his Olive Branch Casino. I must find someone to vouch for me so I can follow him.";

global.quest = id;
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_savingtheholidays_1));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_savingtheholidays_2));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_savingtheholidays_3));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_savingtheholidays_4));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_savingtheholidays_5));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_savingtheholidays_6));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_savingtheholidays_7));

xpReward = 1000;