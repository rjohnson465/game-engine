

var in = instance_number(obj_fade);
if in > 0 exit;

scr_test_build_swordsman_factory();
questStart(obj_quest_llf);


layerToMoveTo = "instances_floor_3";
/*
level = 4;
xpToNextLevel = getXpToNextLevel();

var hpSkill = instance_nearest(x,y,obj_skill_hpmax);
repeat(3) {
	levelUpSkill(hpSkill);
}
var swordSkill = instance_nearest(x, y, obj_skill_blade_mastery);
levelUpSkill(swordSkill);

var ls = instance_create_depth(x, y, depth, obj_hand_item_hatchet);
ls.numberOfSockets = 2;
insertGemIntoItem(makeGem(obj_gem_hematite, CRACKED), ls);
addItemToInventory(ls);
equipItem(ls, EquipmentSlots.LeftHand1);
var ws = instance_create_depth(x, y, depth, obj_hand_item_woodshield);
addItemToInventory(ws);
equipItem(ws, EquipmentSlots.RightHand1);
var bh = instance_create_depth(x, y, depth, obj_hat_bike_helmet);
addItemToInventory(bh);
equipItem(bh, EquipmentSlots.Head);


questStart(obj_quest_llf);
var q = instance_nearest(x,y, obj_quest_llf);

var q1 = ds_list_find_value(q.questSteps, 0);
q1.status = QuestStepStatus.Completed;


var q2 = ds_list_find_value(q.questSteps, 1);
q2.status = QuestStepStatus.Completed;


var q3 = ds_list_find_value(q.questSteps, 2);
q3.status = QuestStepStatus.InProgress;
q.currentQuestStep = q3;
q.currentQuestStepIndex = 2;
addItemToInventory(instance_create_depth(x,y,1,obj_item_wire_rg));