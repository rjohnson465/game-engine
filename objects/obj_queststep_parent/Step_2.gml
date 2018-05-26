var pos = ds_list_find_index(quest.steps,id);
var nextStep = ds_list_find_value(quest.steps,pos+1);
if status == QuestStepStatus.Completed && nextStep != undefined && nextStep != noone && instance_exists(nextStep) {
	if nextStep.status == QuestStepStatus.Unstarted nextStep.status = QuestStepStatus.InProgress;
}