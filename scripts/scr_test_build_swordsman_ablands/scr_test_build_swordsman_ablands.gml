///  _build_swordsman_ablands

// The swordsman build test, for start of ablands map
// Expected level: 15
// Using: Longsword w/ cracked hematite, metal shield, ringed coif, ring with hp regen
// Skills (14 points)
// 7 into health
// 4 into blade master
// 1 into steroids
// 2 into endurance

global.doNotDisplayTutorialMessages = true;

scr_test_set_level(15);

// Level skills
repeat(7) {
	scr_test_skill_up(obj_skill_hpmax);
}
repeat(4) {
	scr_test_skill_up(obj_skill_blade_mastery);
}
repeat(1) {
	scr_test_skill_up(obj_skill_equipload);
}
repeat(2) {
	scr_test_skill_up(obj_skill_staminamax);
}

// Complete Quests 
scr_test_quest_complete(obj_quest_wamdk);
scr_test_quest_complete(obj_quest_llf);
var key = makeKey("Barry's Key", "key_barry", spr_item_key_barry, "Barry's Key to the Lamplight Factory, south of Everdusk Grove.");
addItemToInventory(key);
var key = makeKey("Great-Lodge F2 Key", "key", spr_item_key, "Opens the door to the Fairy's Great-Lodge, Level 2. We really should have more than one copy of this thing.");
addItemToInventory(key);
scr_test_quest_complete(obj_quest_llf);
var key = makeKey("Mess Hall Key", "key", spr_item_key_messhall, "Opens the door to the Lamplight Factory Mess Hall. What the heck do robots eat? Toast?");
addItemToInventory(key);

// start Saving The Holidays
questStart(obj_quest_savingtheholidays, false);

var sth = instance_nearest(x, y, obj_quest_savingtheholidays);
if (instance_exists(sth)) {
	var q0 = ds_list_find_value(sth.questSteps, 0);
	var q1 = ds_list_find_value(sth.questSteps, 1);
	var q2 = ds_list_find_value(sth.questSteps, 2);
	var q3 = ds_list_find_value(sth.questSteps, 3);
	var q4 = ds_list_find_value(sth.questSteps, 4);
	var q5 = ds_list_find_value(sth.questSteps, 5);
	
	q0.status = QuestStepStatus.Completed;
	q1.status = QuestStepStatus.Completed;
	q2.status = QuestStepStatus.Completed;
	q3.status = QuestStepStatus.Completed;
	q4.status = QuestStepStatus.Completed;
	q5.status = QuestStepStatus.InProgress;
	
	sth.currentQuestStep = ds_list_find_value(sth.questSteps, 5);
	sth.currentQuestStepIndex = 5;
	
}

// Build inventory / Equipment

// health flask 
var hf = instance_create_depth(x, y, 1, obj_item_health_flask);
addItemToInventory(hf);
equipItem(hf, EquipmentSlots.BeltItem1);
// 5 charges, 60 health per charge
with hf {
	var currentMaxCharges = ds_map_find_value(customItemProperties, hfs_max_charges);
	ds_map_replace(customItemProperties, hfs_max_charges, currentMaxCharges + 2);
	ds_map_replace(customItemProperties, hfs_charge_strength, 60);
	updateHealthFlaskDescription();
}
fillHealthFlask();

var ls = instance_create_depth(x, y, depth, obj_hand_item_longsword);
ls.numberOfSockets = 2;
// insertGemIntoItem(makeGem(obj_gem_hematite, CRACKED), ls);
addItemToInventory(ls);
equipItem(ls, EquipmentSlots.RightHand1);
var ks = instance_create_depth(x, y, depth, obj_hand_item_kiteshield);
addItemToInventory(ks);
equipItem(ks, EquipmentSlots.LeftHand1);

var bow = instance_create_depth(x, y, depth, obj_hand_item_shortbow);
var torch = instance_create_depth(x, y, depth, obj_hand_item_torch);
var wand = instance_create_depth(x, y, depth, obj_hand_item_wand);
addItemToInventory(bow);
addItemToInventory(instance_create_depth(x, y, 1, obj_hand_item_thrownknife));
addItemToInventory(instance_create_depth(x, y, 1, obj_hand_item_dagger));
addItemToInventory(torch);
addItemToInventory(wand);


var rc = instance_create_depth(x, y, depth, obj_hat_ringed_coif);
addItemToInventory(rc);
equipItem(rc, EquipmentSlots.Head);

addItemToInventory(instance_create_depth(x, y, 1, obj_hat_construction_hat));
addItemToInventory(instance_create_depth(x, y, 1, obj_hat_bike_helmet));
addItemToInventory(instance_create_depth(x, y, 1, obj_hat_leathercap));
addItemToInventory(instance_create_depth(x, y, 1, obj_hat_plated_cap));

var ring = instance_create_depth(x,y,1,obj_item_ring);
addItemProperty(ring, ModifiableProperties.HpRegen, 1);
addItemToInventory(ring);
equipItem(ring, EquipmentSlots.LeftRing1);

addItemToInventory(makeGem(obj_gem_hematite, CRACKED));
addItemToInventory(makeGem(obj_gem_ruby, CRACKED));
addItemToInventory(makeGem(obj_gem_aquamarine, CRACKED));

var peppers = instance_create_depth(x, y, 1, obj_item_jalapeno);
peppers.count = 3;
addItemToInventory(peppers);
var blessings = instance_create_depth(x, y, 1, obj_item_blessing);
blessings.count = 3;
addItemToInventory(blessings);
addItemToInventory(instance_create_depth(x, y, 1, obj_hat_plated_cap));
addItemToInventory(makeGemPieces(obj_gempieces_ruby, GRAINS));
addItemToInventory(makeGemPieces(obj_gempieces_amethyst, GRAINS));

addItemToInventory(makeGold(3500));