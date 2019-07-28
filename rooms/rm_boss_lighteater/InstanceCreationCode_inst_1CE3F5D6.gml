layerToMoveTo = "instances_floor_4";


questStart(obj_quest_llf);


var q = instance_nearest(x,y, obj_quest_llf);

var q1 = ds_list_find_value(q.questSteps, 0);
q1.status = QuestStepStatus.Completed;

/*
var q2 = ds_list_find_value(q.questSteps, 1);
q2.status = QuestStepStatus.Completed;

var q3 = ds_list_find_value(q.questSteps, 2);
q3.status = QuestStepStatus.Completed;