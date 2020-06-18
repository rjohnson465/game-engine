event_inherited();
spriteName = "spr_enemy_krampus_staff";
spriteAttackNumber = 2;
spriteAttackNumberInChain = 1;
limbKey = "r"; // default value
ds_map_add(damages,PIERCE,[25,25]);
ds_map_add(damages, ICE, [5, 5]);
isRanged = false;
staminaCost = 10;
staggerDuration = 10;

attackSound = snd_thrust_attack_1;
hitSound = snd_hit1;
minRange = 120;

attackSoundsVocals = [snd_enemy_krampuself_snarl_1, snd_enemy_krampuself_snarl_2];
prepSound = snd_thrust_attack_1;

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

trailPart = [smoke, snowflake];
trailPartNum = [20, 10];

staggersAgainstBlocks = false;