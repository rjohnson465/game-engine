event_inherited();
spriteName = "spr_enemy_dybukk_slash";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 2;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_add(damages,SLASH,[14,15]);
ds_map_add(damages,ICE,[7,7]);
ds_map_add(damages,MAGIC,[7,7]);
isRanged = false;
staminaCost = 5;
staggerDuration = 15;
limbKey = noone;
type = AttackTypes.Standard;
minRange = 50;
turnSpeed = 10;

staggersAgainstBlocks = false;

attackSound = snd_axe2h_attack_1;
prepSound = snd_thrust_attack_1;
attackSoundsVocals = [snd_enemy_dybukk_scream_2];