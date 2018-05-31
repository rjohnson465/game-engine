/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//quest = obj_quest_unfairyslayer;
status = QuestStepStatus.InProgress;

quest.currentQuestStep = id;

//unfairiesSlain = 0;
ds_map_replace(parameters,"unfairies_slain",0);

description = "Slain 0/3 unfairies";



