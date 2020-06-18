event_inherited();
spriteName = "spr_enemy_icecursedfairy_hatchet";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 3;
limbKey = "r"; 
ds_map_add(damages,CRUSH,[10,10]);
isRanged = false;
staminaCost = 10;
staggerDuration = 25;

type = AttackTypes.Charge;

attackSound = snd_sword1h_attack_1;
hitSound = snd_hit1;

minRange = 30;