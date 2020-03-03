event_inherited();
spriteName = "spr_enemy_dybukkboss_slash";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_add(damages,SLASH,[18,18]);
ds_map_add(damages,ICE,[5,5]);
ds_map_add(damages,MAGIC,[5,5]);
isRanged = false;
staminaCost = 5;
staggerDuration = 15;
limbKey = noone;
type = AttackTypes.Standard;
minRange = 50;

staggersAgainstBlocks = false;

attackSound = snd_axe2h_attack_1;
prepSound = snd_thrust_attack_1;
attackSoundsVocals = [snd_enemy_dybukk_scream_1];