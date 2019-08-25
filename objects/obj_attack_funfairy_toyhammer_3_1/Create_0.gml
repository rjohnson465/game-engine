event_inherited();
spriteName = "spr_enemy_funfairy_toyhammer";
spriteAttackNumber = 3;
spriteAttackNumberInChain = 1;
limbKey = "l"; // default value
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
//ds_map_add(damages,CRUSH,[15,20]);
ds_map_add(damages,MAGIC,[10,20]);

isRanged = true;
isSpell = true;
spellName = "magicmissile";

staminaCost = 5;
projectileSpeed = 14;
staggerDuration = 8;

prepSound = snd_magic_magic_charge;
attackSound = snd_magic_magic_shoot;
hitSound = snd_magic_magic_hit;

attackObjectIndex = obj_attack_funfairy_magicmissile;

minRange = 400;

part1 = part_type_create();

part_type_shape(part1, pt_shape_sphere);
part_type_alpha2(part1,1,.2);
part_type_color2(part1,c_aqua,c_white);
part_type_size(part1,.05,.15,0,0);
part_type_speed(part1,.5,2,0,0);
part_type_direction(part1,0,360,0,4); // set later
part_type_orientation(part1,0,360,5,5,1);
part_type_life(part1,15,25);
part1Num = 15;

prepPart1 = part1;
prepPartBoundingBox = [75, 0, 76, 1];
prepPartStartFrame = 5;

weaponRequired = obj_hand_item_toyhammer;

staggersAgainstBlocks = false;