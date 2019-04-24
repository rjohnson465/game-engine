/// ei_unfairy_longsword_unarmed


var unarmed = makeEnemyWeapon(obj_hand_item_unarmed);
var longsword = makeEnemyWeapon(obj_hand_item_longsword);
ds_map_replace(handItems,"lm1",longsword);
ds_map_replace(handItems,"rm1",unarmed);
ds_map_replace(equippedLimbItems,"l",unarmed);
ds_map_replace(equippedLimbItems,"r",unarmed);

var unarmedHook1 = instance_create_depth(x,y,1,obj_attack_unfairy_unarmed_1_1);
unarmedHook1.limbKey = "r";

var unarmedBackSlap = instance_create_depth(x,y,1,obj_attack_unfairy_unarmed_1_2);
unarmedBackSlap.limbKey = "r";

var longswordSwing = makeEnemyAttackObj(obj_attack_unfairy_longsword_1_1);
var longswordStab1 = makeEnemyAttackObj(obj_attack_unfairy_longsword_2_1);
var longswordStab2 = makeEnemyAttackObj(obj_attack_unfairy_longsword_2_2);

var meleeChain1 = [unarmedHook1];
var meleeChain2 = [unarmedHook1,unarmedBackSlap];
var meleeChain3 = [unarmedHook1,unarmedBackSlap,longswordSwing];
var meleeChain4 = [longswordSwing];
var meleeChain5 = [longswordSwing, unarmedHook1];
var meleeChain6 = [longswordSwing, unarmedHook1, unarmedBackSlap];
var meleeChain7 = [longswordStab1, unarmedHook1, unarmedBackSlap];
var meleeChain8 = [longswordStab1, unarmedHook1];
var meleeChain9 = [longswordStab1];
var meleeChain10 = [longswordStab1, longswordStab2];
meleeAttacks = [
	meleeChain1, meleeChain2, meleeChain3, meleeChain4, meleeChain5,
	meleeChain6, meleeChain7, meleeChain8, meleeChain9, meleeChain10
];
meleeRangeArray = [5,5,5,15,15,15,65,65,65,65];