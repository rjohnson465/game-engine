event_inherited();
spriteName = "spr_enemy_golemboss_dybbuk";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = noone; // default value
ds_map_add(damages, MAGIC, [10, 10]);
ds_map_add(damages, PIERCE, [10, 10]);
isRanged = true;
staminaCost = 10;
staggerDuration = 15;
projectileSpeed = 8;

life = 120;

stopsAtObstacles = false;

//mrOffset = 200;
//mrPrepDuration = 60;
//mrPrepSound = snd_magic_magic_charge;
//mrAttackSound = snd_magic_magic_shoot;

prepSound = snd_magic_magic_charge;
attackSoundLoop = snd_magic_magic_loop;
attackSound = snd_magic_magic_shoot;

attackStartInstance = global.player; 
attackStartOffsetX = 400;
attackStartOffsetY = 400;

minRange = 250;

attackSoundsVocals = [snd_enemy_dybukk_scream_1, snd_enemy_dybukk_scream_2];
prepSoundsVocals = [snd_enemy_golem_prep_1];

hasLightRadius = true;
lightRadiusScale = .4;
lightRadiusAlpha = noone;
lightRadiusColor = c_red;

// magic prep part
var magic = part_type_create();
part_type_shape(magic, pt_shape_sphere);
part_type_color2(magic,c_red,c_ltgray);
part_type_orientation(magic,0,0,0,15,1);
part_type_size(magic,0.1,0.2,0,0);
part_type_speed(magic,2,8,0,0);
part_type_direction(magic,0,360,0,4);
part_type_life(magic,10,15);
part1 = magic;

part1Num = 15;

prepPart1 = magic;
prepPart1Num = 10;
prepPartBoundingBox = [100, 0, 110, 10];

trackingMinDistance = 500;
tracksTargets = true;
