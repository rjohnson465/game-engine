/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

questGiver = obj_npc_ari;
name = "Helping Hershel";
description = "Ari, who admires my physique a completely normal amount, has asked me to save his golem, Hershel, from being possessed.";

global.quest = id;
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_helpinghershel_1));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_helpinghershel_2));

xpReward = 500;

var ring = instance_create_depth(x,y,1,obj_item_ring_clayring);
ds_list_add(rewardItems,ring);