event_inherited();
spriteName = "spr_enemy_abominion_frostburst";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = noone; 
ds_map_add(damages,PIERCE,[18,20]);
ds_map_add(damages,ICE,[12,15]);
isRanged = false;
staminaCost = 10;
staggerDuration = 5;
type = AttackTypes.UnderPlayer;

prepSound = snd_magic_ice_loop;
underPlayerAttackSound = snd_snow_crunch;
underPlayerPrepDuration = 60;
lingerZoneSoundInit = snd_hit_ice_3;

hitSound = snd_hit1;

minRange = 600;


hasLingerZone = true;

var snowflake = part_type_create();
part_type_color2(snowflake, c_silver, c_white);
part_type_shape(snowflake, pt_shape_snow);
part_type_orientation(snowflake,0,0,0,15,1);
part_type_size(snowflake,0.2,0.3,0,0);
part_type_speed(snowflake,.2,.5,0,0);
part_type_direction(snowflake,0,360,0,4);
part_type_life(snowflake,25,50);

// dust
var dust = part_type_create();
part_type_shape(dust, pt_shape_sphere);
part_type_color2(dust,c_navy,c_aqua);
part_type_orientation(dust,0,0,0,15,1);
part_type_size(dust,0,0.15,0,0);
part_type_speed(dust,2,4,0,0);
part_type_direction(dust,0,360,0,4);
part_type_life(dust,20,40);

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



lingerZonePartTypes = [[snowflake, 3], [smoke, 3], [dust, 3]];
var lDamages = ds_map_create();
ds_map_replace(lDamages, ICE, [2,4]);
ds_map_replace(lDamages, PIERCE, [2,2]);
lingerZoneDamages = lDamages; // a map of damages the linger zone delivers
lingerZoneDuration = 150; // 5 seconds by default
lingerZoneDamageFrequency = 30; // damage every second, by default

coolDownFrames = [60, 90];