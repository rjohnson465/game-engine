event_inherited();
spriteName = "spr_enemy_krampuself_icespear";
spriteAttackNumber = 2;
spriteAttackNumberInChain = 1;
limbKey = "l"; // default value
ds_map_add(damages,PIERCE,[18,20]);
ds_map_add(damages, ICE, [10, 10]);
isRanged = false;
staminaCost = 10;
staggerDuration = 10;

type = AttackTypes.Charge;

attackSound = snd_thrust_attack_1;
hitSound = snd_hit1;
minRange = 100;

attackSoundsVocals = [snd_enemy_krampuself_snarl_1, snd_enemy_krampuself_snarl_2];