event_inherited();
spriteName = "spr_enemy_funfairy_pie";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = "l"; // default value
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
//ds_map_add(damages,CRUSH,[15,20]);
ds_map_add(damages,CRUSH,[10,20]);

isRanged = true;
staminaCost = 5;
projectileSpeed = 16;
staggerDuration = 8;

prepSound = snd_thrust_attack_1;
attackSound = snd_thrown_attack;
hitSound = snd_enemy_funfairy_piesplat;
prepSoundsVocals = [noone, snd_enemy_funfairy_prep_1];

minRange = 400;

weaponRequired = obj_hand_item_pie;

part1 = part_type_create();
part_type_shape(part1,pt_shape_sphere);
part_type_alpha2(part1,1,.2);
part_type_color2(part1,make_color_rgb(217,207,181),c_white);
part_type_size(part1,.1,.15,0,0);
part_type_speed(part1,.5,2,0,0);
part_type_direction(part1,0,360,0,4); // set later
part_type_orientation(part1,0,360,5,5,1);
part_type_life(part1,10,15);
part1Num = -2;