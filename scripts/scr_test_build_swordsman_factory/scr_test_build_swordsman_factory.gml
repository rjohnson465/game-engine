/// scr_test_build_swordsman_factory

// The swordsman build test, for start of ww map
// Expected level: 6
// Using: Longsword w/ cracked hematite, wood shield, ringed coif, ring with hp regen
// Skills (5 points)
// 3 into health
// 2 into blade master

global.doNotDisplayTutorialMessages = true;

scr_test_set_level(6);

// Level skills
repeat(3) {
	scr_test_skill_up(obj_skill_hpmax);
}
repeat(2) {
	scr_test_skill_up(obj_skill_blade_mastery);
}

// Complete Quests 
scr_test_quest_complete(obj_quest_wamdk);
var key = makeKey("Barry's Key", "key_barry", spr_item_key_barry, "Barry's Key to the Lamplight Factory, south of Everdusk Grove.");
addItemToInventory(key);
var key = makeKey("Great-Lodge F2 Key", "key", spr_item_key, "Opens the door to the Fairy's Great-Lodge, Level 2. We really should have more than one copy of this thing.");
addItemToInventory(key);


// Build inventory / Equipment
var ls = instance_create_depth(x, y, depth, obj_hand_item_longsword);
ls.numberOfSockets = 2;
insertGemIntoItem(makeGem(obj_gem_lapis, CRACKED), ls);
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