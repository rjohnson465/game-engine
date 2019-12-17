/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

questGiver = obj_npc_elon;
name = "Muskox Feeder";
description = "Elon has asked me to find and feed his muskoxes. Muskoxi. Er... What's the plural of muskox?";

global.quest = id;
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_muskoxfeeder_1));

xpReward = 400;