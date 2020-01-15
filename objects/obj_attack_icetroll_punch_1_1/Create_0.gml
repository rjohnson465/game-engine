event_inherited();
spriteName = "spr_enemy_icetroll_punch";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = noone;
ds_map_add(damages,CRUSH,[25,25]);
isRanged = false;
staminaCost = 5;
staggerDuration = 20;
limbKey = noone;
type = AttackTypes.Charge;
chargeSpeed = 15;
minRange = 65;

staggersAgainstBlocks = false;

attackSound = snd_axe2h_attack_1;
prepSound = snd_thrust_attack_1;

attackSoundsVocals = [snd_enemy_troll_roar_1, snd_enemy_troll_roar_2];
prepSoundsVocals = [snd_enemy_troll_roar_3];

turnsDuringAttack = true;
turnSpeedAttack = 1;
