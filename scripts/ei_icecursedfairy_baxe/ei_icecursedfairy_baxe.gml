/// ei_icecursedfairy_baxe

var hatchet = makeEnemyWeapon(obj_hand_item_hatchet);
var baxe = makeEnemyWeapon(obj_hand_item_baxe);

ds_map_replace(handItems,"lm1",baxe);
ds_map_replace(handItems,"rm1",hatchet);

rangedRangeArray = []; rangedAttacks = [];
ds_map_replace(equippedLimbItems,"l",baxe);
ds_map_replace(equippedLimbItems,"r",hatchet);

var baxe1 = makeEnemyAttackObj(obj_attack_icecursedfairy_baxe_1_1);
var baxe2 = makeEnemyAttackObj(obj_attack_icecursedfairy_baxe_1_2);


var c1 = [baxe1];
var c2 = [baxe1, baxe2];
meleeAttacks = [c1, c2];

poiseCurrent = 50;
poiseMax = 50;

attackFrequencyTotalFramesMelee = [45,55];