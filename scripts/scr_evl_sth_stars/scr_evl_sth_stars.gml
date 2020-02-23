/// scr_evl_sth_stars(arr)
/// @param arr

if status != QuestStepStatus.InProgress exit;

var arr = argument[0];

var item = arr[0];

switch item.object_index {
	case obj_item_starofdavid: {
		// if already have xmas star, finish the quest step
		if inventoryContainsItem(obj_item_xmas_star) {
			description = "Fetch Stars";
			status = QuestStepStatus.Completed;
		} else {
			// if not already have xmas start, update quest step description
			description = "Fetch Santa's Star (in Krampus Campus)";
		}
		break;
	}
	case obj_item_xmas_star: {
		// if already have david star, finish the quest step
		if inventoryContainsItem(obj_item_starofdavid) {
			description = "Fetch Stars";
			status = QuestStepStatus.Completed;
		} else {
			// if not already have david start, update quest step description
			description = "Fetch David's Star (in Clayfields)";
		}
		break;
	}
}