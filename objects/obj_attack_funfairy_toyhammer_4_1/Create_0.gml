event_inherited();
spriteName = "spr_enemy_funfairy_toyhammer";
spriteAttackNumber = 4;
spriteAttackNumberInChain = 1;
limbKey = "r"; // default value
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
ds_map_add(damages,CRUSH,[7,15]);
ds_map_add(damages,MAGIC,[5,10]);
isRanged = false;
staminaCost = 15;
staggerDuration = 15;
type = AttackTypes.Charge;

attackSound = snd_enemy_funfairy_3swings;
hitSound = snd_squeaky_hit;

minRange = 200;

chargeSpeed = 17;

weaponRequired = obj_hand_item_toyhammer;

staggersAgainstBlocks = false;