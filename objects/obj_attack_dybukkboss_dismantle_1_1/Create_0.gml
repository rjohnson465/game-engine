event_inherited();
spriteName = "spr_enemy_dybukkboss_dismantle";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = noone;
ds_map_add(damages,CRUSH,[15,15]);
ds_map_add(damages,ICE,[3,3]);
ds_map_add(damages,MAGIC,[10,10]);
isRanged = true;
staminaCost = 5;
staggerDuration = 15;
limbKey = noone;
type = AttackTypes.Standard;
minRange = 250;
projectileSpeed = 15;

staggersAgainstBlocks = false;

attackSound = snd_thrown_attack;
prepSound = snd_enemy_dybukk_squelch;
attackSoundsVocals = [snd_enemy_dybukk_scream_2];

// magic prep part
var magic = part_type_create();
part_type_shape(magic, pt_shape_sphere);
part_type_color2(magic,c_red,c_ltgray);
part_type_orientation(magic,0,0,0,15,1);
part_type_size(magic,0.07,0.15,0,0);
part_type_speed(magic,2,8,0,0);
part_type_direction(magic,0,360,0,4);
part_type_life(magic,10,15);
part1 = magic;

part1Num = -1;

prepPart1 = magic;
prepPart1Num = -2;
// prepPartBoundingBox = [100, 0, 110, 10];
stopsAtObstacles = false;