///  _build_swordsman_ww

// The swordsman build test, for start of ww map
// Expected level: 10
// Using: Longsword w/ cracked hematite, wood shield, ringed coif, ring with hp regen
// Skills (7 points)
// 5 into health
// 3 into blade master
// 1 into steroids

global.doNotDisplayTutorialMessages = true;

scr_test_set_level(10);

// Level skills
repeat(5) {
	scr_test_skill_up(obj_skill_hpmax);
}
repeat(3) {
	scr_test_skill_up(obj_skill_blade_mastery);
}
repeat(1) {
	scr_test_skill_up(obj_skill_equipload);
}

// Complete Quests 
scr_test_quest_complete(obj_quest_wamdk);
var key = makeKey("Barry's Key", "key_barry", spr_item_key_barry, "Barry's Key to the Lamplight Factory, south of Everdusk Grove.");
addItemToInventory(key);
var key = makeKey("Great-Lodge F2 Key", "key", spr_item_key, "Opens the door to the Fairy's Great-Lodge, Level 2. We really should have more than one copy of this thing.");
addItemToInventory(key);
scr_test_quest_complete(obj_quest_llf);
var key = makeKey("Mess Hall Key", "key", spr_item_key_messhall, "Opens the door to the Lamplight Factory Mess Hall. What the heck do robots eat? Toast?");
addItemToInventory(key);

// start Saving The Holidays???
// questStart(obj_quest_savingtheholidays);

// Build inventory / Equipment

// health flask 
var hf = instance_create_depth(x, y, 1, obj_item_health_flask);
addItemToInventory(hf);
equipItem(hf, EquipmentSlots.BeltItem1);
// 4 charges
with hf {
	var currentMaxCharges = ds_map_find_value(customItemProperties, hfs_max_charges);
	ds_map_replace(customItemProperties, hfs_max_charges, currentMaxCharges + 1);
	updateHealthFlaskDescription();
}
fillHealthFlask();

var ls = instance_create_depth(x, y, depth, obj_hand_item_longsword);
ls.numberOfSockets = 2;
insertGemIntoItem(makeGem(obj_gem_hematite, CRACKED), ls);
addItemToInventory(ls);
equipItem(ls, EquipmentSlots.LeftHand1);
var ws = instance_create_depth(x, y, depth, obj_hand_item_woodshield);
addItemToInventory(ws);

var bow = instance_create_depth(x, y, depth, obj_hand_item_shortbow);
var torch = instance_create_depth(x, y, depth, obj_hand_item_torch);
var wand = instance_create_depth(x, y, depth, obj_hand_item_wand);
addItemToInventory(bow);
addItemToInventory(torch);
addItemToInventory(wand);

equipItem(ws, EquipmentSlots.RightHand1);
var rc = instance_create_depth(x, y, depth, obj_hat_ringed_coif);
addItemToInventory(rc);
equipItem(rc, EquipmentSlots.Head);
var ring = instance_create_depth(x,y,1,obj_item_ring);
addItemProperty(ring, ModifiableProperties.HpRegen, 1);
addItemToInventory(ring);
equipItem(ring, EquipmentSlots.LeftRing1);