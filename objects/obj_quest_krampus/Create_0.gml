/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

questGiver = obj_npc_santa;
name = "The Anti-Santa";
description = "The evil, Christmas-hating Krampus lives in a lair north of Christmas Town. I will track him down and kill him for Santa.";

global.quest = id;
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_krampus_1));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_krampus_2));
ds_list_add(questSteps,instance_create_depth(x,y,1,obj_queststep_krampus_3));
xpReward = 500;
