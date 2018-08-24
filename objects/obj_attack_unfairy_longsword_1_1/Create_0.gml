event_inherited();
spriteName = "spr_enemy_unfairy_longsword";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = "l"; // default value
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
ds_map_add(damages,SLASH,[15,30]);
isRanged = false;
staminaCost = 10;
//nextChoices = [];
staggerDuration = 18;

attackSound = snd_sword1h_attack_1;
hitSound = snd_hit1;