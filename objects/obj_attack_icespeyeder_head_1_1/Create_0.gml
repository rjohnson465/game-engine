event_inherited();
spriteName = "spr_enemy_icespeyeder_head";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_add(damages,CRUSH,[15,25]);
ds_map_add(damages,ICE,[1,3]);
isRanged = false;
staminaCost = 5;
staggerDuration = 18;
limbKey = noone;
type = AttackTypes.Charge;
minRange = 30;

staggersAgainstBlocks = false;

attackSound = snd_axe2h_attack_1;
attackSoundsVocals = [snd_enemy_speyeder_jump];