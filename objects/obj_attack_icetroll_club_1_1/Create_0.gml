event_inherited();
spriteName = "spr_enemy_icetroll_club";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_add(damages,CRUSH,[40,50]);
isRanged = false;
staminaCost = 5;
staggerDuration = 45;
limbKey = noone;
type = AttackTypes.Standard;
minRange = 65;

staggersAgainstBlocks = false;

attackSound = snd_axe2h_attack_1;
prepSound = snd_thrust_attack_1;

attackSoundsVocals = [snd_enemy_troll_roar_1];
prepSoundsVocals = [snd_enemy_troll_roar_3];