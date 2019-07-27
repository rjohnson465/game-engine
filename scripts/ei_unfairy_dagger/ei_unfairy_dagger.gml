/// ei_unfairy_warhammer
/// initialize this unfairy to have a dagger, shield (maybe pistol??)
// var unarmed = makeEnemyWeapon(obj_hand_item_unarmed);
var dagger = makeEnemyWeapon(obj_hand_item_dagger);
var pistol = makeEnemyWeapon(obj_hand_item_pistol);
ds_map_replace(handItems,"lm1",dagger);
ds_map_replace(handItems,"rm1",dagger);

ds_map_replace(handItems,"lr1",pistol);
ds_map_replace(handItems,"rr1",pistol);


ds_map_replace(equippedLimbItems,"r",dagger);
ds_map_replace(equippedLimbItems,"l",dagger);

var d11 = makeEnemyAttackObj(obj_attack_unfairy_dagger_1_1);
var d12 = makeEnemyAttackObj(obj_attack_unfairy_dagger_1_2);
var d13 = makeEnemyAttackObj(obj_attack_unfairy_dagger_1_3);
var d14 = makeEnemyAttackObj(obj_attack_unfairy_dagger_1_4);

var d11r = makeEnemyAttackObj(obj_attack_unfairy_dagger_1_1r);
var d12r = makeEnemyAttackObj(obj_attack_unfairy_dagger_1_2r);
var d13r = makeEnemyAttackObj(obj_attack_unfairy_dagger_1_3r);
var d14r = makeEnemyAttackObj(obj_attack_unfairy_dagger_1_4r);

var meleeChain1 = [d11, d12, d13, d14];
var meleeChain2 = [d11, d11r, d12, d12r, d13, d13r, d14, d14r];
var meleeChain3 = [d11, d11r, d12];
var meleeChain4 = [d11, d12];

meleeAttacks = [meleeChain2, meleeChain1, meleeChain3, meleeChain4];
//meleeAttacks = [];

attackFrequencyTotalFramesMelee = [45,70];

var p11l = makeEnemyAttackObj(obj_attack_unfairy_pistol_1_1l);
var p11r = makeEnemyAttackObj(obj_attack_unfairy_pistol_1_1r);

var r1 = [p11l];

var r2 = [p11l, p11r];

rangedAttacks = [r1, r2];

agility = 100;
skittishness = 85;

// rangedAggroRange = 1000;