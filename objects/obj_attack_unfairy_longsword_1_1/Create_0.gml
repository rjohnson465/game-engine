event_inherited();
spriteName = "spr_enemy_unfairy_unarmed";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
ds_map_add(damages,PHYSICAL,[15,30]);
isRanged = false;
staminaCost = 10;
//nextChoices = [];