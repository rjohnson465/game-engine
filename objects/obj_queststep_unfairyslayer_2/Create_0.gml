/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

quest = obj_quest_unfairyslayer;
status = QuestStepStatus.Unstarted;

description = "Francis thanks you. Claim your reward.";

isRewardStep = true;

/*
var c = instance_create_depth(x,y,1,obj_conversation_parent);
c.persistent = true;

var c1 = instance_create_depth(x,y,1,obj_conversation_step_parent);
c1.persistent = true;
c1.text = "Holy heck you did it. Here, have a hat.";
c1.sound = snd_conversation_francis_unfairyslayer_3;
c1.func = questFinishUnfairySlayer;

ds_list_add(c.steps,c1);

with obj_npc_data {
	if npcName == "Francis" {
		ds_list_add(conversationsToAdd,c);
	}
}

