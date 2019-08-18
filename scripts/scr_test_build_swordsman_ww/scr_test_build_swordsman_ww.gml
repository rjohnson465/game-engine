/// scr_test_build_swordsman_ww

// The swordsman build test, for start of ww map
// Expected level: 8
// Using: Longsword w/ cracked hematite, wood shield, ringed coif, ring with hp regen
// Skills (7 points)
// 4 into health
// 2 into blade master
// 1 into steroids

scr_test_set_level(8);

// Level skills
repeat(4) {
	scr_test_skill_up(obj_skill_hpmax);
}
repeat(2) {
	scr_test_skill_up(obj_skill_blade_mastery);
}
repeat(1) {
	scr_test_skill_up(obj_skill_equipload);
}

// Complete Quests 
scr_test_quest_complete(obj_quest_wamdk);
scr_test_quest_complete(obj_quest_llf);

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
equipItem(ring, EquipmentSlots.LeftRing1);