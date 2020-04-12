/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

questGiver = obj_npc_ari;
name = "Rescue Herbie";
description = "Mrs. Claus wants me to track down the elf Herbie, and escort him safely back to her. She thinks he went to the wolf den, far to the west of her tavern.";

global.quest = id;
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_savingherbie_1));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_savingherbie_2));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_savingherbie_3));

xpReward = 500;
ds_list_add(rewardItems,instance_create_depth(x,y,1,obj_item_ring_wolftoothring));