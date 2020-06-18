event_inherited();
spriteName = "spr_enemy_krampus_staff";
spriteAttackNumber = 5;
spriteAttackNumberInChain = 1;
limbKey = "r"; // default value
ds_map_add(damages,ICE,[4,6]);
ds_map_add(damages,PIERCE,[15,15]);
isRanged = false;
staminaCost = 5;
staggerDuration = 2;
type = AttackTypes.MultiRand;
minRange = 3000;
numberOfProjectiles = 1;

var snowflake = part_type_create();
part_type_shape(snowflake, pt_shape_snow);
part_type_orientation(snowflake,0,0,0,15,1);
part_type_size(snowflake,0,0.25,0,0);
part_type_speed(snowflake,1,1.5,0,0);
part_type_direction(snowflake,0,360,0,4);
part_type_life(snowflake,10,20);
part_type_color2(snowflake, c_aqua, c_white);

// icicle parts 1
var p1 = part_type_create();
part_type_sprite(p1,spr_iciclechunk_particles,0,0,1);
part_type_size(p1,1,1,0,0);
part_type_alpha3(p1,1, .5, .25);
part_type_speed(p1,5,6,0,0);
part_type_direction(p1,0,360,0,10);
part_type_orientation(p1,0,360,10,15,1);
part_type_blend(p1,0);
part_type_life(p1,15,30);

// icicle parts 2
var p2 = part_type_create();
part_type_sprite(p2,spr_iciclechunk_particles,0,0,1);
part_type_size(p2,1,1,0,0);
part_type_alpha3(p2,1, .5, .25);
part_type_speed(p2,5,6,0,0);
part_type_direction(p2,0,360,0,10);
part_type_orientation(p2,0,360,-10,15,1);
part_type_blend(p2,0);
part_type_life(p2,15,30);

// smoke
var smoke = part_type_create();
part_type_shape(smoke, pt_shape_smoke);
part_type_color2(smoke,c_navy,c_aqua);
part_type_orientation(smoke,0,0,0,15,1);
part_type_alpha3(smoke, .5, .25, .1);
part_type_size(smoke,0.5,1.0,0,0);
part_type_speed(smoke,.5,1,0,0);
part_type_direction(smoke,0,360,0,4);
part_type_life(smoke,45,60);

part1  = [[p1, 3], [p2, 3], [smoke, 5]];

prepPart1 = snowflake;
prepPartBoundingBox = [35, -0, 85, -100];

prepSoundsVocals = [snd_vox_snarl_1];

mrOffset = 100; // random projectiles within n px of target
mrPrepDuration = 35; // how long each projectile charges
mrAttackSound = snd_iceshatter;
mrPrepSound = snd_magic_ice_charge;
attackFunc = scr_krampus_summon_elf;