event_inherited();
spriteName = "spr_enemy_absnowman_swing";
spriteAttackNumber = 2;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_add(damages,CRUSH,[45,45]);
ds_map_add(damages,ICE,[3,3]);
isRanged = false;
staminaCost = 5;
staggerDuration = 45;
limbKey = noone;
type = AttackTypes.Charge;
chargeSpeed = 15;
minRange = 70;

staggersAgainstBlocks = false;

attackSound = snd_axe2h_attack_1;
prepSound = snd_thrust_attack_1;

attackSoundsVocals = [snd_enemy_troll_roar_1];
prepSoundsVocals = [snd_enemy_troll_roar_3];

// ice cloud
var smoke = part_type_create();
part_type_shape(smoke, pt_shape_smoke);
part_type_color2(smoke,c_aqua,c_white);
part_type_orientation(smoke,0,0,0,15,1);
part_type_alpha3(smoke, .5, .25, .1);
part_type_size(smoke,.35,.5,0,0);
part_type_speed(smoke,.2,1,0,0);
part_type_direction(smoke,0,360,0,4);
part_type_life(smoke,10,15 );

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

trailPart = [smoke, snowflake];
trailStarts = 0;
trailEnds = 4;
trailPartNum = [5, 10];