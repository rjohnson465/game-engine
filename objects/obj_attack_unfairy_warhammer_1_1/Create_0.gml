event_inherited();
spriteName = "spr_enemy_unfairy_warhammer";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = "l"; // default value
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
ds_map_add(damages,CRUSH,[15,30]);
isRanged = false;
staminaCost = 15;
staggerDuration = 20;

attackSound = snd_axe2h_attack_1;
hitSound = snd_hit1;

minRange = 45;