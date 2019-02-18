event_inherited();
spriteName = "spr_enemy_speyeder_claw";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 2;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_add(damages,SLASH,[12,18]);
ds_map_add(damages,PIERCE,[5,10]);
isRanged = false;
staminaCost = 5;
staggerDuration = 18;
limbKey = noone;
type = AttackTypes.Standard;
minRange = 20;
coolDownFrames = [60,90];

attackSound = snd_sword1h_attack_1;	
hitSound = snd_hit1;