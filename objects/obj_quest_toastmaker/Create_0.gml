/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

questGiver = obj_npc_barry;
name = "Toastmaker";
description = "Terri the Toaster has asked me to find and bring her bread. Great, I'm taking orders from a toaster now.";

global.quest = id;
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_toastmaker_1));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_toastmaker_2));

xpReward = 400;
var toast = instance_create_depth(x,y,1,obj_item_toast);
toast.count = 4;
ds_list_add(rewardItems,toast);