event_inherited();
spriteName = "spr_enemy_icecursedfairy_baxe";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 2;
limbKey = "r"; // default value
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
ds_map_add(damages,CRUSH,[25,30]);
isRanged = false;
staminaCost = 15;
staggerDuration = 30;

attackSound = snd_axe2h_attack_1;
hitSound = snd_hit1;

minRange = 45;