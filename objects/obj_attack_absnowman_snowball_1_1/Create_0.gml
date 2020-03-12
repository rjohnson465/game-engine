event_inherited();
spriteName = "spr_enemy_absnowman_snowball";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = noone;
ds_map_replace(damages,ICE,[5,5]);
ds_map_replace(damages,CRUSH, [20,20]);
isRanged = true;
staminaCost = 5;
staggerDuration = 10;
type = AttackTypes.Standard;
minRange = 800;
projectileSpeed = 15;
isVisible = false;
refreshCombatantsHit = 8; 
doesNotStagger = true;
staggersAgainstBlocks = false;

// snowflake
var snowflake = part_type_create();
part_type_shape(snowflake, pt_shape_snow);
part_type_orientation(snowflake,0,0,0,15,1);
part_type_size(snowflake,0,0.1,0,0);
part_type_speed(snowflake,1,1.5,0,0);
part_type_direction(snowflake,0,360,0,4);
part_type_life(snowflake,10,20);
part_type_alpha3(snowflake,1,.75,.5);
part_type_color2(snowflake, c_navy, c_white);
part1 = snowflake;

part1Num = 14;

prepPart1 = part1;

prepPartBoundingBox = [15, 0, 25, 10];
// prepPartStartFrame = 0;
prepSound = snd_snow_crunch;

attackSound = snd_thrown_attack;
// attackSoundLoop = snd_magic_ice_loop;

attackSoundsVocals = [noone];
