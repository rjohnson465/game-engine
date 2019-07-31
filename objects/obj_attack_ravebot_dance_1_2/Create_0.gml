event_inherited();
spriteName = "spr_enemy_ravebot_dance";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 2;
ds_map_add(damages,SLASH,[8,12]);
isRanged = false;
staminaCost = 10;
staggerDuration = 5;

attackSound = snd_sword1h_attack_1;
hitSound = snd_hit1;

minRange = 65;

turnSpeed = 20;
type = AttackTypes.Standard;