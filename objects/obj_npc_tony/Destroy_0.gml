/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if room == rm_boss_lighteater {
	isInteractingWithPlayer = false;
	alert("In his haste, Tony drops a strange wire...", c_white, 150);
	addItemToInventory(instance_create_depth(x, y, 1, obj_item_wire_rg));
	
	with obj_queststep_llf_2 {
		status = QuestStepStatus.Completed;
	}
	
	updateNarrativeState(NarrativeState.WinterWonderground);
	
	global.isInteractingWithNpc = false;
}