event_inherited();
spriteName = "spr_enemy_funfairy_toyhammer";
spriteAttackNumber = 2;
spriteAttackNumberInChain = 1;
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

prepSoundsVocals = [snd_enemy_funfairy_prep_2];

minRange = 100;

weaponRequired = obj_hand_item_toyhammer;