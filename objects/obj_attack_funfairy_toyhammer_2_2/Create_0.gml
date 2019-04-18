event_inherited();
spriteName = "spr_enemy_funfairy_toyhammer";
spriteAttackNumber = 2;
spriteAttackNumberInChain = 2;
limbKey = "l"; // default value
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
ds_map_add(damages,CRUSH,[15,20]);
ds_map_add(damages,MAGIC,[1,3]);
isRanged = false;
staminaCost = 15;
staggerDuration = 15;
type = AttackTypes.Charge;

attackSound = snd_axe2h_attack_1;
hitSound = snd_squeaky_hit;

minRange = 150;