event_inherited();
spriteName = "spr_enemy_unfairy_dagger";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = "r"; 
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
ds_map_add(damages,SLASH,[4,8]);
isRanged = false;
staminaCost = 10;
staggerDuration = 2;

attackSound = snd_dagger_attack_1;
hitSound = snd_hit1;

minRange = 20;

turnSpeed = 10;