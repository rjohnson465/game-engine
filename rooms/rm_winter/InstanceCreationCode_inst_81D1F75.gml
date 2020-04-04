var in = instance_number(obj_fade);
if in > 0 exit;

scr_test_build_swordsman_ww();

var sth = instance_nearest(x, y, obj_quest_savingtheholidays);
if (instance_exists(sth)) {
	var q0 = ds_list_find_value(sth.questSteps, 0);
	var q1 = ds_list_find_value(sth.questSteps, 1);
	var q2 = ds_list_find_value(sth.questSteps, 2);
	var q3 = ds_list_find_value(sth.questSteps, 3);
	var q4 = ds_list_find_value(sth.questSteps, 4);
	
	q0.status = QuestStepStatus.Completed;
	q1.status = QuestStepStatus.Completed;
	q2.status = QuestStepStatus.Completed;
	q3.status = QuestStepStatus.Completed;
	q4.status = QuestStepStatus.Completed;
}