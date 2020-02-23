quest = global.quest; // the quest this step belongs to
name = "Quest step";
description = "Quest step description";

enum QuestStepStatus {
	Unstarted,
	InProgress,
	Completed
}

status = QuestStepStatus.Unstarted;

isRewardStep = false;
persistent = true;

// key/value --> <goal_name><value>
parameters = ds_map_create(); 

canClaimRewardFromQuestLog = true;

activationScript = noone;
activationScriptParams = noone; // array