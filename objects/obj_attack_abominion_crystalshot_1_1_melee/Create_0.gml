event_inherited();
spriteName = "spr_enemy_abominion_crystalshot";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = noone; 
ds_map_add(damages,PIERCE,[20,20]);
ds_map_add(damages,ICE,[12,12]);
isRanged = true;
staminaCost = 10;
staggerDuration = 5;
type = AttackTypes.Standard;
projectileSpeed = 15;

prepSound = snd_magic_ice_charge;
attackSoundLoop = snd_magic_ice_loop;
attackSound = snd_iu_icecrack;

hitSound = snd_hit1;

minRange = 45;

// smoke
var smoke = part_type_create();
part_type_shape(smoke, pt_shape_smoke);
part_type_color2(smoke,c_aqua,c_silver);
part_type_orientation(smoke,0,0,0,15,1);
part_type_alpha3(smoke, .5, .25, .1);
part_type_size(smoke,0.2,0.5,0,0);
part_type_speed(smoke,.5,2,0,0);
part_type_direction(smoke,0,360,0,4);
part_type_life(smoke,45,60);

part1 = smoke;
part1Num = 15;
prepPart1 = smoke;
prepPart1Num = 2;
prepPart1BelowOwner = true;