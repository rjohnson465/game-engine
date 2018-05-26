quest = noone; // the quest this step belongs to
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