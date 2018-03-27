event_inherited();
spriteName = "spr_enemy_unfairy_longsword";
spriteAttackNumber = 2;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
ds_map_add(damages,PIERCE,[15,30]);
isRanged = false;
staminaCost = 10;
type = AttackTypes.Charge;
minRange = 50;
//nextChoices = [];
staggerDuration = 35;