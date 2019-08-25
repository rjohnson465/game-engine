/// ei_krampuself_iceaxe


var unarmed = makeEnemyWeapon(obj_hand_item_unarmed);
var iceaxe = makeEnemyWeapon(obj_hand_item_iceaxe);
var iceshield = makeEnemyWeapon(obj_hand_item_iceshield);
ds_map_replace(handItems,"lm1",iceaxe);
ds_map_replace(handItems,"rm1",iceshield);
ds_map_replace(equippedLimbItems,"l",iceaxe);
ds_map_replace(equippedLimbItems,"r",iceshield);



global.owner = id;

var axeSwing1 = makeEnemyAttackObj(obj_attack_krampuself_iceaxe_1_1);
var meleeChain1 = [axeSwing1];

meleeAttacks = [
	meleeChain1
];