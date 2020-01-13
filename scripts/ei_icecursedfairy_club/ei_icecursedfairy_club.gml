/// ei_icecursedfairy_club

var club = makeEnemyWeapon(obj_hand_item_club);

ds_map_replace(handItems,"lm1",club);

ds_map_replace(equippedLimbItems,"l",club);

global.owner = id;
var torchSwing = makeEnemyAttackObj(obj_attack_icecursedfairy_torch_1_1);
var club11 = makeEnemyAttackObj(obj_attack_icecursedfairy_club_1_1);
var club12 = makeEnemyAttackObj(obj_attack_icecursedfairy_club_1_2);
var club13 = makeEnemyAttackObj(obj_attack_icecursedfairy_club_1_3);

var c0 = [torchSwing];
var c1 = [club11, torchSwing];
var c2 = [club11];
var c3 = [club11, club12];
var c4 = [club11, club12, club13];

meleeAttacks = [c0, c1, c2, c3, c4];

poiseCurrent = 50;
poiseMax = 50;

attackFrequencyTotalFramesMelee = [45,55];