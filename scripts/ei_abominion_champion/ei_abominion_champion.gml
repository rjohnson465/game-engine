/// ei_abominion_champion

name = "The First Minion";

global.owner = id;
var frostburst = instance_create_depth(x, y, depth, obj_attack_abominion_frostburst_1_1);
var crystalshot = instance_create_depth(x, y, depth, obj_attack_abominion_crystalshot_1_1_melee);
var swing1 = instance_create_depth(x, y, depth, obj_attack_abominion_swing_1_1);
var swing2 = instance_create_depth(x, y, depth, obj_attack_abominion_swing_1_2);

ds_map_replace(swing1.damages, ICE, [10,10]);
ds_map_replace(swing2.damages, ICE, [10,10]);
ds_map_replace(crystalshot.damages, ICE, [15,15]);

var c0 = [frostburst];
var c1 = [crystalshot];
var c2 = [swing1];
var c3 = [swing1, swing2];
meleeAttacks = [c0, c1, c2, c3];

// ranged attacks info
var crystalshot = instance_create_depth(x, y, depth, obj_attack_abominion_crystalshot_1_1);
var frostburst = instance_create_depth(x, y, depth, obj_attack_abominion_frostburst_1_1_ranged);
var c0 = [crystalshot];
var c1 = [frostburst];

ds_map_replace(crystalshot.damages, ICE, [15,15]);
rangedAttacks = [c0, c1];

hp = 250;
maxHp = 250;

attackFrequencyTotalFramesMelee = [30,45];
attackFrequencyTotalFramesRanged = [30,35];

turnSpeed = 6;
normalTurnSpeed = 6;

functionalSpeed = 8;
normalSpeed = 8;

xpReward = 300;