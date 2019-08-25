event_inherited();
spriteName = "spr_enemy_unfairy_greatsword";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = "l"; // default value
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
ds_map_add(damages,SLASH,[25,40]);
isRanged = false;
staminaCost = 10;
staggerDuration = 5;

attackSound = snd_axe2h_attack_1;
hitSound = snd_hit1;

minRange = 30;

staggersAgainstBlocks = false;