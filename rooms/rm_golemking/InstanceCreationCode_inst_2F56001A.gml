var in = instance_number(obj_fade);
if in > 0 exit;

scr_test_build_swordsman_ww();

addItemToInventory(instance_create_depth(x, y, 1, obj_hand_item_dagger));
addItemToInventory(instance_create_depth(x, y, 1, obj_hand_item_battleaxe));
addItemToInventory(instance_create_depth(x, y, 1, obj_hand_item_hatchet));
addItemToInventory(instance_create_depth(x, y, 1, obj_hand_item_greatsword));
addItemToInventory(instance_create_depth(x, y, 1, obj_hand_item_spear));