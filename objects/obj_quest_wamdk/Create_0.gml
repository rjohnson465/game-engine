/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

questGiver = obj_npc_barry;
name = "Where Are My Damn Keys?";
description = "The dreaded unfairies have invaded, murdering fairies and stealing lamplights (and possibly littering). The Elder, Barry fears they're going to the lamplight factory. I must find his Lamplight Factory key.";

global.quest = id;
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_wamdk_1));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_wamdk_2));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_wamdk_3));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_wamdk_4));

xpReward = 500;
var rd = instance_create_depth(x,y,1,obj_item_rubberducky);
rd.count = 3;
ds_list_add(rewardItems,rd);