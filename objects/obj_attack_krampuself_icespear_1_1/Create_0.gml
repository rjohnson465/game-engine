event_inherited();
spriteName = "spr_enemy_krampuself_icespear";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = "l"; // default value
ds_map_add(damages,PIERCE,[15,20]);
ds_map_add(damages, ICE, [10, 10]);
isRanged = false;
staminaCost = 10;
staggerDuration = 10;

attackSound = snd_thrust_attack_1;
hitSound = snd_hit1;
minRange = 80;