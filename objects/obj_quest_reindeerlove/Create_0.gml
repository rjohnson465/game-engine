/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

eventListeners = ds_map_create();
ds_map_add(eventListeners, EV_ITEM_PICKEDUP, scr_evl_llfcomplete);

questGiver = obj_npc_randolph;
name = "Reindeer Love";
description = "Randolph the Red-Nosed Reindeer has asked me to help deepen his love with Vixen. This is what I do now. I help reindeer make baby reindeer. What the hell am I doing with my life.";

global.quest = id;
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_reindeerlove_1));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_reindeerlove_2));

xpReward = 1000;
ds_list_add(rewardItems,instance_create_depth(x,y,1,obj_item_randolphs_nose));