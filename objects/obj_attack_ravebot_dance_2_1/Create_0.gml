event_inherited();
spriteName = "spr_enemy_ravebot_dance";
spriteAttackNumber = 2;
spriteAttackNumberInChain = 1;
ds_map_add(damages,SLASH,[15,18]);
isRanged = false;
staminaCost = 10;
staggerDuration = 5;

attackSound = snd_sword1h_attack_1;
hitSound = snd_hit1;


staggersAgainstBlocks = false;
turnSpeed = 20;
type = AttackTypes.Charge;

minRange = 65;