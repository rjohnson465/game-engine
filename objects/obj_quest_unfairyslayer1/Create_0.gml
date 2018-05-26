/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

questGiver = obj_npc_francis;
name = "Skidaddle skidoodle your dick is now a noodle and I am the one who eats cake";
//name = "Egg slayer";
description = "Those gosh darn unfairies are getting bothersome. They keep sniffing Francis' earlobes. A light bit of genocide should do the trick.";

ds_list_add(steps,instance_create_depth(x,y,1,obj_queststep_unfairyslayer_1));
ds_list_add(steps,instance_create_depth(x,y,1,obj_queststep_unfairyslayer_2));

xpReward = 1000;
ds_list_add(rewardItems,instance_create_depth(x,y,1,obj_item_revive_orb));