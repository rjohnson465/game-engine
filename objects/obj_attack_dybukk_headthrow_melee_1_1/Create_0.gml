event_inherited();
spriteName = "spr_enemy_dybukk_headthrow";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_add(damages,CRUSH,[12,12]);
ds_map_add(damages,ICE,[2,3]);
ds_map_add(damages,MAGIC,[10,12]);
isRanged = true;
staminaCost = 5;
staggerDuration = 15;
limbKey = noone;
type = AttackTypes.Standard;
minRange = 50;
projectileSpeed = 15;

staggersAgainstBlocks = false;

attackSound = snd_thrown_attack;
prepSound = snd_enemy_dybukk_squelch;
attackSoundsVocals = [snd_enemy_dybukk_scream_2];