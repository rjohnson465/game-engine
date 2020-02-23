/// scr_evl_golemking_killed(arr)
/// @param arr

// must be called the quest step of the kill golemking quest that watches if krampus has been killed yet

var arr = argument[0];

var enemyId = arr[0];

if enemyId.object_index == obj_enemy_dybukkboss {
	status = QuestStepStatus.Completed;
}