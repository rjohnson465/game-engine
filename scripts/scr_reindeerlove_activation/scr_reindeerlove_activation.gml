/// scr_reindeerlove_activation

with obj_queststep_reindeerlove_1 {
	if status != QuestStepStatus.InProgress exit;

	// check if player already has carrots
	if inventoryContainsItem(obj_item_carrots) {
		status = QuestStepStatus.Completed;
	
		with obj_npc_randolph {
			isInteractingWithPlayer = false;
			global.isInteractingWithNpc = false;
		}
	}
}