/// ei_krampuself_iceaxe


// var unarmed = makeEnemyWeapon(obj_hand_item_unarmed);
var iceclub = makeEnemyWeapon(obj_hand_item_iceclub);
var iceshield = makeEnemyWeapon(obj_hand_item_iceshield);
ds_map_replace(handItems,"lm1",iceclub);
ds_map_replace(handItems,"rm1",iceshield);
ds_map_replace(equippedLimbItems,"l",iceclub);
ds_map_replace(equippedLimbItems,"r",iceshield);



global.owner = id;

var clubSwing1 = makeEnemyAttackObj(obj_attack_krampuself_iceclub_1_1);
var clubSwing2 = makeEnemyAttackObj(obj_attack_krampuself_iceclub_1_2);

var c0 = [clubSwing1];

var c1 = [clubSwing1, clubSwing2];

meleeAttacks = [
	c0, c1
];