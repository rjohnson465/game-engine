event_inherited();
spriteName = "spr_enemy_funfairy_toyhammer";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = "l"; // default value
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
ds_map_add(damages,CRUSH,[20,25]);
ds_map_add(damages,MAGIC,[1,5]);
isRanged = false;
staminaCost = 15;
staggerDuration = 20;

attackSound = snd_axe2h_attack_1;
hitSound = snd_squeaky_hit;

minRange = 100;

weaponRequired = obj_hand_item_toyhammer;

staggersAgainstBlocks = false;