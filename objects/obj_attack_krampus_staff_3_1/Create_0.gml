event_inherited();
spriteName = "spr_enemy_krampus_staff";
spriteAttackNumber = 3;
spriteAttackNumberInChain = 1;
limbKey = "l"; // default value
ds_map_add(damages, ICE, [15, 15]);
isRanged = false;
staminaCost = 10;
staggerDuration = 10;
type = AttackTypes.Zone;

attackSound = snd_magic_ice_shoot;
hitSound = snd_hit1;
minRange = 120;

attackSoundsVocals = [snd_enemy_krampuself_snarl_1, snd_enemy_krampuself_snarl_2];
prepSound = snd_magic_ice_charge;

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

var snowflake = part_type_create();
part_type_shape(snowflake, pt_shape_snow);
part_type_orientation(snowflake,0,0,0,15,1);
part_type_size(snowflake,0,0.25,0,0);
part_type_speed(snowflake,1,1.5,0,0);
part_type_direction(snowflake,0,360,0,4);
part_type_life(snowflake,10,20);
part_type_color2(snowflake, c_navy, c_aqua);

part1 = smoke;
part2 = snowflake;
zonePartNum = 10;
zonePartNum2 = 8;

prepPart1 = snowflake;
prepPartBoundingBox = [35, -0, 85, -100];

staggersAgainstBlocks = false;

isVisible = false;