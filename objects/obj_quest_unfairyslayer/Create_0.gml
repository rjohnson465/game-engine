/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

questGiver = obj_npc_francis;
name = "Unfairy Slayer";
//name = "Literally wtf am i doing with my life. i am 23 and very lonely. oh well lets make pixels light up in a certain order forever now.";
description = "Those gosh darn unfairies are getting bothersome. They keep sniffing Francis' earlobes. A light bit of genocide should do the trick.";

global.quest = id;
ds_list_add(steps,instance_create_depth(x,y,1,obj_queststep_unfairyslayer_1));
ds_list_add(steps,instance_create_depth(x,y,1,obj_queststep_unfairyslayer_2));

//currentQuestStep = s1;
xpReward = 1000;
ds_list_add(rewardItems,instance_create_depth(x,y,1,obj_item_revive_orb));

isRepeatable = true;