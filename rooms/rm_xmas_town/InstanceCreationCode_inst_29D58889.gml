var in = instance_number(obj_fade);
if in > 0 exit;

scr_test_build_swordsman_ww();

/*
show_debug_message("hi");

var q = instance_nearest(x, y, obj_quest_savingtheholidays);

var q1 = ds_list_find_value(q.questSteps, 0);
q1.status = QuestStepStatus.Completed;



var q2 = ds_list_find_value(q.questSteps, 1);
q2.status = QuestStepStatus.Completed;

var q3 = ds_list_find_value(q.questSteps, 2);
q3.status = QuestStepStatus.Completed;

var q4 = ds_list_find_value(q.questSteps, 3);
q4.status = QuestStepStatus.Completed;

q.currentQuestStepIndex = 4;