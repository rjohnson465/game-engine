/// ei_krampuself_iceaxe


var unarmed = makeEnemyWeapon(obj_hand_item_unarmed);
var iceaxe = makeEnemyWeapon(obj_hand_item_iceaxe);

// for particles
ds_map_replace(iceaxe.damages,ICE,[1,2]);


var iceshield = makeEnemyWeapon(obj_hand_item_iceshield);
ds_map_replace(handItems,"lm1",iceaxe);
ds_map_replace(handItems,"rm1",iceshield);
ds_map_replace(equippedLimbItems,"l",iceaxe);
ds_map_replace(equippedLimbItems,"r",iceshield);



global.owner = id;

var axeSwing1 = makeEnemyAttackObj(obj_attack_krampuself_iceaxe_1_1);
var axeSwing2 = makeEnemyAttackObj(obj_attack_krampuself_iceaxe_1_2);

var axeCharge = makeEnemyAttackObj(obj_attack_krampuself_iceaxe_2_1);

var c0 = [axeSwing1];
var c1 = [axeSwing1, axeSwing2];
var c2 = [axeCharge];

meleeAttacks = [
	c0, c1, c2
];