/// ei_krampuself_iceaxe

var icespear = makeEnemyWeapon(obj_hand_item_icespear);
// var iceshield = makeEnemyWeapon(obj_hand_item_iceshield);
ds_map_replace(handItems,"lm1",icespear);
ds_map_replace(handItems,"rm1",icespear);
ds_map_replace(equippedLimbItems,"l",icespear);
ds_map_replace(equippedLimbItems,"r",icespear);



global.owner = id;

var heavyStab = makeEnemyAttackObj(obj_attack_krampuself_icespear_1_1);

var heavyStabr = instance_create_depth(x, y, 1, obj_attack_krampuself_icespear_1_1);
heavyStabr.limbKey = "r";

var spearCharge = makeEnemyAttackObj(obj_attack_krampuself_icespear_2_1);

var jab1 = makeEnemyAttackObj(obj_attack_krampuself_icespear_3_1);
var jab2 = makeEnemyAttackObj(obj_attack_krampuself_icespear_3_2);
var jab3 = makeEnemyAttackObj(obj_attack_krampuself_icespear_3_3);

var jab1r = instance_create_depth(x, y, 1, obj_attack_krampuself_icespear_3_1);
jab1r.limbKey = "r";
var jab2r = instance_create_depth(x, y, 1, obj_attack_krampuself_icespear_3_2);
jab2r.limbKey = "r";
var jab3r = instance_create_depth(x, y, 1, obj_attack_krampuself_icespear_3_3);
jab3r.limbKey = "r";

var c0 = [heavyStab];
var c1 = [spearCharge];
var c2 = [jab1, jab2, jab3];
var c3 = [heavyStab, heavyStabr];
var c4 = [heavyStab, jab1r, jab2r];
var c5 = [jab1, jab1r, jab2r, jab3r];
meleeAttacks = [c0, c1, c2, c3, c4, c5];