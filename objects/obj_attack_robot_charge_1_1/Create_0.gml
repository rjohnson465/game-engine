event_inherited();
spriteName = "spr_enemy_robot_charge";
limbKey = noone; 
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
ds_map_add(damages,SLASH,[8,14]);
isRanged = false;
staminaCost = 10;
type = AttackTypes.Charge;
minRange = 50;
staggerDuration = 25;

attackSound = snd_dodge1;
hitSound = snd_hit1;

minRange = 65;

chargePrepSpeed = 1;
chargeSpeed = 12;

attackSoundsVocals = [];

prepSound = snd_thrust_attack_1;
prepSoundsVocals = [];
attackSound = snd_enemy_robot_charge;
recoverSound = snd_enemy_robot_charge_recover;