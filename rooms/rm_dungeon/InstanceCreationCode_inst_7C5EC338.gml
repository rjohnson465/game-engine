var in = instance_number(obj_fade);
if in > 0 exit;

var dagger = instance_create_depth(x, y, 1, obj_hand_item_dagger);
modifyWeaponPhysicalDamage(dagger, 2);
modifyWeaponElementalDamage(dagger, ICE, 2);
appraiseItem(dagger);
addItemToInventory(dagger);

// scr_test_build_swordsman_ww();