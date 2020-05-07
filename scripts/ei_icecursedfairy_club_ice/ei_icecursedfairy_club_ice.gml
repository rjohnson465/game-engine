/// ei_icecursedfairy_club_ice

var club = makeEnemyWeapon(obj_hand_item_club);

ds_map_replace(handItems,"lm1",club);

ds_map_replace(equippedLimbItems,"l",club);

global.owner = id;
var torchSwing = makeEnemyAttackObj(obj_attack_icecursedfairy_torch_1_1);
var club11 = instance_create_depth(x, y, 1, obj_attack_icecursedfairy_club_1_1);
var club12 = instance_create_depth(x, y, 1, obj_attack_icecursedfairy_club_1_2);
var club13 = instance_create_depth(x, y, 1, obj_attack_icecursedfairy_club_1_3);

// for particle effects
ds_map_replace(club.damages,ICE,[1,2]);

ds_map_replace(club11.damages, ICE, [6,6]);
ds_map_replace(club12.damages, ICE, [6,6]);
ds_map_replace(club13.damages, ICE, [6,6]);

var c0 = [torchSwing];
var c1 = [club11, torchSwing];
var c2 = [club11];
var c3 = [club11, club12];
var c4 = [club11, club12, club13];

meleeAttacks = [c0, c1, c2, c3, c4];

poiseCurrent = 50;
poiseMax = 50;

attackFrequencyTotalFramesMelee = [60,75];