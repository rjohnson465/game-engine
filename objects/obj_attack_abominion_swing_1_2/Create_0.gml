event_inherited();
spriteName = "spr_enemy_abominion_swing";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 2;
limbKey = noone;
ds_map_replace(damages,SLASH,[8,10]);
ds_map_replace(damages,PIERCE,[12,15]);
ds_map_replace(damages,ICE,[5,5]);
isRanged = false;
staminaCost = 5;
staggerDuration = 22;
limbKey = noone;
type = AttackTypes.Standard;
minRange = 55;

attackSound = snd_sword1h_attack_1;
hitSound = snd_hit1;