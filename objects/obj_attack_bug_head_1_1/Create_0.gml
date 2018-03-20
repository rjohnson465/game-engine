event_inherited();
spriteName = "spr_enemy_bug_melee";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_add(damages,PHYSICAL,[1,3]);
isRanged = false;
staminaCost = 5;