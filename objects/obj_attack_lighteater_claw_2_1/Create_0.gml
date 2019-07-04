event_inherited();
spriteName = "spr_enemy_lighteater_claw";
spriteAttackNumber = 2;
spriteAttackNumberInChain = 1;
limbKey = noone;
ds_map_replace(damages,CRUSH,[8,10]);
isRanged = false;
staminaCost = 5;
staggerDuration = 15;
limbKey = noone;
type = AttackTypes.Standard;
minRange = 60;
isVisible = true;
refreshCombatantsHit = 5; 


prepSound = snd_enemy_lighteater_prep_1;
attackSound = snd_sword1h_attack_1;
attackSoundsVocals = [snd_enemy_lighteater_attack_1];
