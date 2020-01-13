event_inherited();
spriteName = "spr_enemy_wolf_bite";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = noone;
ds_map_add(damages,PIERCE,[15,20]);
isRanged = false;
staminaCost = 5;
staggerDuration = 7;
limbKey = noone;
type = AttackTypes.Charge;
movesDuringPrep = false;
chargePrepSpeed = 0;
minRange = 30;

staggersAgainstBlocks = false;

attackSound = snd_axe2h_attack_1;
prepSound = snd_thrust_attack_1;
prepSoundsVocals = [snd_enemy_wolf_growl_1];
mustVocalizeAttack = true;
attackSoundsVocals = [snd_enemy_wolf_growl_2, snd_enemy_wolf_growl_3];