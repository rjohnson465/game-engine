event_inherited();
spriteName = "spr_enemy_golem_ball";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = noone;
ds_map_add(damages,CRUSH,[22,22]);
isRanged = false;
staminaCost = 5;
staggerDuration = 15;
limbKey = noone;
type = AttackTypes.Charge;
minRange = 50;

staggersAgainstBlocks = false;

attackSound = snd_golem_roll;
prepSound = snd_thrust_attack_1;

attackSoundsVocals = [snd_enemy_golem_attack_1];
prepSoundsVocals = [];