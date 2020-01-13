event_inherited();
spriteName = "spr_enemy_golem_swing";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 2;
limbKey = noone;
ds_map_add(damages,CRUSH,[35,35]);
isRanged = false;
staminaCost = 5;
staggerDuration = 30;
limbKey = noone;
type = AttackTypes.Charge;
minRange = 50;

staggersAgainstBlocks = false;

attackSound = snd_axe2h_attack_1;
prepSound = snd_thrust_attack_1;

attackSoundsVocals = [snd_enemy_golem_attack_1];
prepSoundsVocals = [snd_enemy_golem_prep_1];