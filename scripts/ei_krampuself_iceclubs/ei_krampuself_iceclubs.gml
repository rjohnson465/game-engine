/// ei_krampuself_iceaxe


// var unarmed = makeEnemyWeapon(obj_hand_item_unarmed);
var iceclub = makeEnemyWeapon(obj_hand_item_iceclub);
// var iceclub = makeEnemyWeapon(obj_hand_item_iceshield);
ds_map_replace(handItems,"lm1",iceclub);
ds_map_replace(handItems,"rm1",iceclub);
ds_map_replace(equippedLimbItems,"l",iceclub);
ds_map_replace(equippedLimbItems,"r",iceclub);



global.owner = id;

var clubSwing1 = makeEnemyAttackObj(obj_attack_krampuself_iceclub_1_1);
var clubSwing2 = makeEnemyAttackObj(obj_attack_krampuself_iceclub_1_2);

var cs1r = instance_create_depth(x,y,1,obj_attack_krampuself_iceclub_1_1);
cs1r.limbKey = "r";
var cs2r = instance_create_depth(x,y,1,obj_attack_krampuself_iceclub_1_2);
// cs2r.limbKey = "r";

var c0 = [clubSwing1];
var c1 = [clubSwing1, clubSwing2];
var c2 = [clubSwing1, cs1r];
var c3 = [clubSwing1, cs1r, cs2r];
var c4 = [clubSwing1, clubSwing2, cs1r];
var ct = [cs1r];
meleeAttacks = [
	c0, c1, c2, c3, c4
];
meleeAttacks = [ct];