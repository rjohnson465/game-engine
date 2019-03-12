// can only occur after longsword_2_1
event_inherited();
spriteName = "spr_enemy_unfairy_longsword";
limbKey = "l"; // default value
spriteAttackNumber = 2;
spriteAttackNumberInChain = 1;
ds_map_add(damages,PIERCE,[10,20]);
isRanged = false;
staminaCost = 10;
type = AttackTypes.Standard;
minRange = 30;
staggerDuration = 25;
turnSpeed = 5;

attackSound = snd_thrust_attack_1;
hitSound = snd_hit1;