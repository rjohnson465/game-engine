/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

status = QuestStepStatus.InProgress;

description = "0/10 muskox fed";
ds_map_replace(parameters,"fedCount",0);
maxFedCount = 10;
hasDoneInitialCheck = false;