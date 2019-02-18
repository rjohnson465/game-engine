/// ei_unfairy_warhammer
/// initialize this unfairy to have a warhammer and no ranged
var unarmed = makeEnemyWeapon(obj_hand_item_unarmed);
var warhammer = makeEnemyWeapon(obj_hand_item_warhammer);
ds_map_replace(handItems,"lm1",warhammer);
ds_map_replace(handItems,"rm1",unarmed);
ds_map_replace(handItems,"lr1",noone);
ds_map_replace(handItems,"rr1",noone);
rangedRangeArray = []; rangedAttacks = [];
ds_map_replace(equippedLimbItems,"l",warhammer);
ds_map_replace(equippedLimbItems,"r",unarmed);

var warhammerSwing = makeEnemyAttackObj(obj_attack_unfairy_warhammer_1_1);
//spearStab.limbKey = "l";
//var spearStab2 = instance_create_depth(x,y,1,obj_attack_unfairy_spear_1_2);

var meleeChain1 = [warhammerSwing];
//var meleeChain2 = [spearStab,spearStab2];
meleeAttacks = [meleeChain1];
meleeRangeArray = [60];

attackFrequencyTotalFramesMelee = [45,60];