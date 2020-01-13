event_inherited();
spriteName = "spr_enemy_icecursedfairy_torch";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = "r"; 
ds_map_add(damages,CRUSH,[10,12]);
ds_map_add(damages,FIRE,[7,8]);
isRanged = false;
staminaCost = 10;
staggerDuration = 5;

attackSound = snd_sword1h_attack_1;
hitSound = snd_hit1;

minRange = 30;