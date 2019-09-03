event_inherited();
spriteName = "spr_enemy_wolf_lunge";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_add(damages,SLASH,[15,20]);
isRanged = false;
staminaCost = 5;
staggerDuration = 7;
limbKey = noone;
type = AttackTypes.Charge;
minRange = 30;

staggersAgainstBlocks = false;

attackSound = snd_axe2h_attack_1;
prepSound = snd_thrust_attack_1;
prepSoundsVocals = [snd_enemy_wolf_growl_1];
mustVocalizeAttack = true;
attackSoundsVocals = [snd_enemy_wolf_growl_2, snd_enemy_wolf_growl_3];