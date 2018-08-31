// unblockable, slightly faster turnSpeed
// can only occur after longsword_2_1
event_inherited();
spriteName = "spr_enemy_unfairy_longsword";
limbKey = "l"; // default value
spriteAttackNumber = 2;
spriteAttackNumberInChain = 1;
ds_map_add(damages,PIERCE,[15,30]);
isRanged = false;
staminaCost = 10;
type = AttackTypes.Charge;
minRange = 50;
staggerDuration = 25;
isBlockable = false;
turnSpeed = 10;

attackSound = snd_thrust_attack_1;
hitSound = snd_hit1;