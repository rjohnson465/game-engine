event_inherited();
spriteName = "spr_enemy_speyeder_claw";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_replace(damages,SLASH,[10,15]);
ds_map_replace(damages,PIERCE,[5,10]);
isRanged = false;
staminaCost = 5;
staggerDuration = 18;
limbKey = noone;
type = AttackTypes.Standard;
minRange = 30;

attackSound = snd_sword1h_attack_1;
hitSound = snd_hit1;