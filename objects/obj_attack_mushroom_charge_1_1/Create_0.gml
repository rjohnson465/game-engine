event_inherited();
spriteName = "spr_enemy_mushroom_charge";
limbKey = noone; 
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
ds_map_add(damages,CRUSH,[10,15]);
isRanged = false;
staminaCost = 10;
type = AttackTypes.Charge;
minRange = 50;
staggerDuration = 25;

attackSound = snd_dodge1;
hitSound = snd_hit1;

minRange = 65;

chargePrepSpeed = 1;
chargeSpeed = 10;

attackSoundsVocals = [snd_enemy_mushroom_hit2];

prepSound = snd_thrust_attack_1;
prepSoundsVocals = [snd_enemy_mushroom_charge_prep];