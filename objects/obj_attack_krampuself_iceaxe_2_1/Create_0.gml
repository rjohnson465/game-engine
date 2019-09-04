event_inherited();
spriteName = "spr_enemy_krampuself_iceaxe";
spriteAttackNumber = 2;
spriteAttackNumberInChain = 1;
limbKey = "l"; // default value
ds_map_add(damages,SLASH,[18,20]);
ds_map_add(damages, ICE, [10, 10]);
isRanged = false;
staminaCost = 10;
staggerDuration = 15;

type = AttackTypes.Charge;

staggersAgainstBlocks = false;

attackSound = snd_sword1h_attack_1;
hitSound = snd_hit1;
minRange = 110;

attackSoundsVocals = [snd_enemy_krampuself_snarl_1, snd_enemy_krampuself_snarl_2];