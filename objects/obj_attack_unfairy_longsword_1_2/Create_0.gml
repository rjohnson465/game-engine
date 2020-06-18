event_inherited();
spriteName = "spr_enemy_unfairy_longsword";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 2;
limbKey = "r"; // default value
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
ds_map_add(damages,SLASH,[7,15]);
isRanged = false;
staminaCost = 10;
staggerDuration = 9;
turnSpeed = 5;

attackSound = snd_sword1h_attack_1;
hitSound = snd_hit1;

minRange = 30;