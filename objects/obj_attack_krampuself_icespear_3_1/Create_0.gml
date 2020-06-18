event_inherited();
spriteName = "spr_enemy_krampuself_icespear";
spriteAttackNumber = 3;
spriteAttackNumberInChain = 1;
limbKey = "r"; // default value
ds_map_add(damages,PIERCE,[7,8]);
ds_map_add(damages, ICE, [4, 5]);
isRanged = false;
staminaCost = 10;
staggerDuration = 6;

attackSound = snd_thrust_attack_1;
hitSound = snd_hit1;
minRange = 100;

attackSoundsVocals = [snd_enemy_krampuself_snarl_1, snd_enemy_krampuself_snarl_2];