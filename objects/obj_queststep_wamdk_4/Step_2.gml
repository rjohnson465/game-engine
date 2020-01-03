/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if status = QuestStepStatus.Completed && instance_number(obj_quest_llf) == 0 {
	questStart(obj_quest_llf);
}