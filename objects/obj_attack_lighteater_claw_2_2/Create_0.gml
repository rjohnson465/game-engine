event_inherited();
spriteName = "spr_enemy_lighteater_claw";
spriteAttackNumber = 2;
spriteAttackNumberInChain = 2;
limbKey = noone;
ds_map_replace(damages,CRUSH,[25,30]);
isRanged = false;
staminaCost = 5;
staggerDuration = 30;
limbKey = noone;
type = AttackTypes.Charge;
minRange = 60;
isVisible = true;
refreshCombatantsHit = 5; 
chargeSpeed = 15;


prepSound = snd_enemy_lighteater_prep_1;
attackSound = snd_thrust_attack_1;
attackSoundsVocals = [snd_enemy_lighteater_attack_1];
