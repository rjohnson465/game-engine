event_inherited();
spriteName = "spr_enemy_unfairy_longsword";
limbKey = "r"; // default value
spriteAttackNumber = 2;
spriteAttackNumberInChain = 1;
ds_map_add(damages,PIERCE,[12,20]);
isRanged = false;
staminaCost = 10;
type = AttackTypes.Charge;
minRange = 50;
staggerDuration = 25;

attackSound = snd_thrust_attack_1;
hitSound = snd_hit1;

minRange = 65;