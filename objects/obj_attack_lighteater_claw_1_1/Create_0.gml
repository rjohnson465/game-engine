event_inherited();
spriteName = "spr_enemy_lighteater_claw";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_replace(damages,CRUSH,[20,25]);
// ds_map_replace(conditionsChances, POISON, .8); // 100% chance a hit will poison someone
isRanged = false;
staminaCost = 5;
staggerDuration = 25;
limbKey = noone;
type = AttackTypes.Standard;
minRange = 60;
isVisible = true;
refreshCombatantsHit = 5; 


prepSound = snd_enemy_lighteater_prep_1;
attackSound = snd_axe2h_attack_1;
attackSoundsVocals = [snd_enemy_lighteater_attack_1];
