var in = instance_number(obj_fade);
if in > 0 exit;

scr_test_build_swordsman_ww();

addItemToInventory(instance_create_depth(x, y, 1, obj_hand_item_dagger));
addItemToInventory(instance_create_depth(x, y, 1, obj_hand_item_dagger));
addItemToInventory(instance_create_depth(x, y, 1, obj_hand_item_battleaxe));
addItemToInventory(instance_create_depth(x, y, 1, obj_hand_item_hatchet));
addItemToInventory(instance_create_depth(x, y, 1, obj_hand_item_greatsword));
addItemToInventory(instance_create_depth(x, y, 1, obj_hand_item_spear));
addItemToInventory(instance_create_depth(x, y, 1, obj_hand_item_warhammer));

var ac = instance_create_depth(x, y, 1, obj_item_ancient_coin);
ac.count = 11;
addItemToInventory(ac, false);

/*
layerToMoveTo = "instances_floor_2";