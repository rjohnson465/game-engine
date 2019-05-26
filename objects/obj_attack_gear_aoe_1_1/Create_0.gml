event_inherited();
spriteName = "spr_enemy_gear_aoe";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_replace(damages,PIERCE,[15,30]);
isRanged = false;
staminaCost = 5;
staggerDuration = 18;
limbKey = noone;
type = AttackTypes.Standard;
minRange = 30;

prepSound = snd_thrust_attack_1;
attackSound = snd_sword_draw;
hitSound = snd_hit1;