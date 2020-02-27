name = "Arctic Direwolf";

maxHp = 100;
hp = 100;
attackFrequencyTotalFramesMeleeDefault = [30, 40];
poiseCurrent = 50;
poiseMax = 50;

global.owner = id;
var lunge = makeEnemyAttackObj(obj_attack_wolf_dire_lunge_1_1);
var bite1 = makeEnemyAttackObj(obj_attack_wolf_dire_bite_1_1);
var bite2 = makeEnemyAttackObj(obj_attack_wolf_dire_bite_1_2);

var c0 = [lunge];
var c1 = [bite1];
var c2 = [bite1, bite2];
meleeAttacks = [c0, c1, c2];

xpReward = 100;

chanceToDropHealthOrb = .2;