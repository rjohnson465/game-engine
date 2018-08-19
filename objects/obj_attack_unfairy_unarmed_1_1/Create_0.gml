event_inherited();
spriteName = "spr_enemy_unfairy_unarmed";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
ds_map_add(damages,CRUSH,[3,5]);
isRanged = false;
staminaCost = 5;
staggerDuration = 8;
//nextChoices = [];
attackSound = snd_sword1h_attack_1;
hitSound = snd_hit1;