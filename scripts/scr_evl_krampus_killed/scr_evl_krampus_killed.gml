/// scr_evl_krampus_killed(arr)
/// @param arr

// must be called the quest step of the kill krampus quest that watches if krampus has been killed yet

var arr = argument[0];

var enemyId = arr[0];

if enemyId.object_index == obj_enemy_krampus {
	status = QuestStepStatus.Completed;
}