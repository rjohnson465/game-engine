/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

eventListeners = ds_map_create();
ds_map_add(eventListeners, EV_ITEM_PICKEDUP, scr_evl_llfcomplete);

questGiver = obj_npc_barry;
name = "Investigate the Lamplight Factory";
description = "I've tracked the unfairy invaders to our sacred Lamplight Factory. I must investigate and see what I can find.";



global.quest = id;
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_llf_0));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_llf_1));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_llf_2));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_llf_3));

xpReward = 800;
var cp = instance_create_depth(x,y,1,obj_item_jalapeno);
cp.count = 3;
ds_list_add(rewardItems,cp);