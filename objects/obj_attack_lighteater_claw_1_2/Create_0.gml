event_inherited();
spriteName = "spr_enemy_lighteater_claw";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 2;
limbKey = noone;
ds_map_replace(damages,CRUSH,[22,25]);
isRanged = false;
staminaCost = 5;
staggerDuration = 30;
limbKey = noone;
type = AttackTypes.Standard;
minRange = 60;
isVisible = true;
refreshCombatantsHit = 5; 


prepSound = snd_enemy_lighteater_prep_1;
attackSound = snd_axe2h_attack_1;
attackSoundsVocals = [snd_enemy_lighteater_attack_1];
