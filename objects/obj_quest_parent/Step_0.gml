if !instance_exists(currentQuestStep) {
	currentQuestStep = ds_list_find_value(questSteps,0);
	currentQuestStepIndex = 0;
}

// reward items must be persistent
if ds_list_size(rewardItems) > 0 && !hasSetRewardItemPermanence {
	for (var i = 0; i < ds_list_size(rewardItems); i++) {
		var it = ds_list_find_value(rewardItems, i);
		it.persistent = true;
	}
}