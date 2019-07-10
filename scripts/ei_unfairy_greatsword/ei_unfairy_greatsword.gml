/// ei_unfairy_warhammer
/// initialize this unfairy to have a warhammer and no ranged
var unarmed = makeEnemyWeapon(obj_hand_item_unarmed);
var greatsword = makeEnemyWeapon(obj_hand_item_greatsword);
ds_map_replace(handItems,"lm1",greatsword);
ds_map_replace(handItems,"rm1",unarmed);
ds_map_replace(handItems,"lr1",noone);
ds_map_replace(handItems,"rr1",noone);
rangedRangeArray = []; rangedAttacks = [];
ds_map_replace(equippedLimbItems,"l",greatsword);
ds_map_replace(equippedLimbItems,"r",unarmed);

var gs11 = makeEnemyAttackObj(obj_attack_unfairy_greatsword_1_1);
var gs12 = makeEnemyAttackObj(obj_attack_unfairy_greatsword_1_2);

var gs21 = makeEnemyAttackObj(obj_attack_unfairy_greatsword_2_1);


var c1 = [gs11];
var c2 = [gs11, gs12];
var c3 = [gs21];
meleeAttacks = [c2];

attackFrequencyTotalFramesMelee = [45,60];