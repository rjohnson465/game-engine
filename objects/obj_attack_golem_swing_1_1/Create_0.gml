event_inherited();
spriteName = "spr_enemy_golem_swing";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = noone;
ds_map_add(damages,CRUSH,[25,25]);
isRanged = false;
staminaCost = 5;
staggerDuration = 20;
limbKey = noone;
type = AttackTypes.Standard;
minRange = 50;

staggersAgainstBlocks = false;

attackSound = snd_axe2h_attack_1;
prepSound = snd_thrust_attack_1;

attackSoundsVocals = [snd_enemy_golem_attack_1];
prepSoundsVocals = [];