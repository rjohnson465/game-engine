layerToMoveTo = "instances_floor_4";


var in = instance_number(obj_fade);
if in > 0 exit;

scr_test_build_swordsman_factory();


questStart(obj_quest_llf);


var q = instance_nearest(x,y, obj_quest_llf);

var q1 = ds_list_find_value(q.questSteps, 0);
q1.status = QuestStepStatus.Completed;

/*
// Build inventory / Equipment
var ls = instance_create_depth(x, y, depth, obj_hand_item_longsword);
ls.numberOfSockets = 2;
insertGemIntoItem(makeGem(obj_gem_hematite, CRACKED), ls);
addItemToInventory(ls);
equipItem(ls, EquipmentSlots.LeftHand1);
var ws = instance_create_depth(x, y, depth, obj_hand_item_woodshield);
addItemToInventory(ws);
equipItem(ws, EquipmentSlots.RightHand1);
var rc = instance_create_depth(x, y, depth, obj_hat_ringed_coif);
addItemToInventory(rc);
equipItem(rc, EquipmentSlots.Head);
var ring = instance_create_depth(x,y,1,obj_item_ring);
addItemProperty(ring, ModifiableProperties.HpRegen, 1);
addItemToInventory(ring);
equipItem(ring, EquipmentSlots.LeftRing1);

var bow = instance_create_depth(x, y, 1, obj_hand_item_shortbow);
bow.numberOfSockets = 2;
insertGemIntoItem(makeGem(obj_gem_ruby, CRACKED), bow);
addItemToInventory(bow);
equipItem(bow, EquipmentSlots.LeftHand2);