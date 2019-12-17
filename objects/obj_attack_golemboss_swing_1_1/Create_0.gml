event_inherited();
spriteName = "spr_enemy_golemboss_swing";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = noone; // default value
ds_map_add(damages,SLASH,[20,25]);
ds_map_add(damages, FIRE, [5, 5]);
isRanged = false;
staminaCost = 10;
staggerDuration = 15;

attackSound = snd_axe2h_attack_1;
hitSound = snd_hit1;
minRange = 80;

attackSoundsVocals = [snd_enemy_golem_attack_1];
prepSoundsVocals = [snd_enemy_golem_prep_1];