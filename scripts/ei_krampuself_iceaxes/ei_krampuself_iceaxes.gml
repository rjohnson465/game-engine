/// ei_krampuself_iceaxe

var iceaxe = makeEnemyWeapon(obj_hand_item_iceaxe);

// for particles
ds_map_replace(iceaxe.damages,ICE,[1,2]);

// var iceshield = makeEnemyWeapon(obj_hand_item_iceshield);
ds_map_replace(handItems,"lm1",iceaxe);
ds_map_replace(handItems,"rm1",iceaxe);
ds_map_replace(equippedLimbItems,"l",iceaxe);
ds_map_replace(equippedLimbItems,"r",iceaxe);



global.owner = id;

var axeSwing1 = makeEnemyAttackObj(obj_attack_krampuself_iceaxe_1_1);
var axeSwing2 = makeEnemyAttackObj(obj_attack_krampuself_iceaxe_1_2);

var axeCharge = makeEnemyAttackObj(obj_attack_krampuself_iceaxe_2_1);

var axeSwing1r = instance_create_depth(x, y, 1, obj_attack_krampuself_iceaxe_1_1);
axeSwing1r.limbKey = "r";
var axeSwing2r = instance_create_depth(x, y, 1, obj_attack_krampuself_iceaxe_1_2);
axeSwing2r.limbKey = "r";

var c0 = [axeSwing1];
var c1 = [axeSwing1, axeSwing2];
var c2 = [axeCharge];
var c3 = [axeSwing1, axeSwing1r];
var c4 = [axeSwing1, axeSwing2, axeSwing1r];
var c5 = [axeCharge, axeSwing1r];
var c6 = [axeCharge, axeSwing1r, axeSwing2r];

meleeAttacks = [
	c0, c1, c2, c3, c4, c5, c6
];