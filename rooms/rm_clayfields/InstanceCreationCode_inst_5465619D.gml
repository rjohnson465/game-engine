var in = instance_number(obj_fade);
if in > 0 exit;

scr_test_build_swordsman_ww();


var ac = instance_create_depth(x, y, 1, obj_item_ancient_coin);
ac.count = 11;
addItemToInventory(ac, false);


layerToMoveTo = "instances_floor_2";