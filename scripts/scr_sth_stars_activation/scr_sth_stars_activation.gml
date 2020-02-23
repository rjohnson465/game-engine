/// scr_sth_stars_activation
if status != QuestStepStatus.InProgress exit;

// check if player already has any or both of the stars

if inventoryContainsItem(obj_item_starofdavid) && inventoryContainsItem(obj_item_xmas_star) {
	description = "Fetch Stars";
	status = QuestStepStatus.Completed;
}

else if inventoryContainsItem(obj_item_starofdavid) {
	// if not already have xmas start, update quest step description
	description = "Fetch Santa's Star (in Krampus Campus)";
}

else if inventoryContainsItem(obj_item_xmas_star) {
	// if not already have david start, update quest step description
	description = "Fetch David's Star (in Clayfields)";
}