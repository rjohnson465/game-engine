event_inherited();
spriteName = "spr_enemy_spore_hit";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_add(damages,CRUSH,[1,2]);
ds_map_add(damages,POISON,[2,3]);
isRanged = true;
projectileSpeed = 7;
staminaCost = 5;
staggerDuration = 0;
limbKey = noone;
type = AttackTypes.Standard;
minRange = 45;

attackSound = snd_sword1h_attack_1;
hitSound = snd_hit1;

usesWeapon = false;

part1 = part_type_create();
part_type_shape(part1, pt_shape_sphere);
part_type_alpha2(part1,1,.2);
part_type_color2(part1,c_olive,c_white);
part_type_size(part1,.05,.15,0,0);
part_type_speed(part1,.5,2,0,0);
part_type_direction(part1,0,360,0,4); // set later
part_type_orientation(part1,0,360,5,5,1);
part_type_life(part1,15,25);
part1Num = 15;

coolDownFrames = [60, 120];