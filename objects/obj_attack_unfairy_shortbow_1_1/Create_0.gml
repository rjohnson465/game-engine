event_inherited();
spriteName = "spr_enemy_unfairy_shortbow";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = "r";
ds_map_add(damages,PIERCE,[10,20]);
isRanged = true;
staminaCost = 5;
projectileSpeed = 11;
staggerDuration = 8;

prepSound = snd_bow_prep;
attackSound = snd_bow_attack;
hitSound = snd_hit1;

minRange = 400;