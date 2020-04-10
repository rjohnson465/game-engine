/// completeQuestStep(queststepObj) 
/// @param queststepObj


var qs = argument[0];

if !instance_exists(qs) || !object_is_ancestor(qs.object_index, obj_queststep_parent) exit;

qs.status = QuestStepStatus.Completed;