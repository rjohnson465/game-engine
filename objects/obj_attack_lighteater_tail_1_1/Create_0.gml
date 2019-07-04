event_inherited();
spriteName = "spr_enemy_lighteater_tail";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = noone;
ds_map_replace(damages,PIERCE,[10,12]);
//isRanged = true;
staminaCost = 5;
staggerDuration = 10;
limbKey = noone;
type = AttackTypes.AOE;
minRange = 200;


numberOfProjectiles = 3; // TEST
/*spreadTotal = 180; // TEST
aoeStartOffset = -90; // TEST*/
aoeProjectilesDirectionOffsetArray = [-45, 0, 45];

projectileSpeed = 15;
damageType = "Dust";

part1 = part_type_create();
part_type_shape(part1, pt_shape_sphere);
part_type_alpha2(part1,1,.2);
part_type_color2(part1,make_color_rgb(151,135,167),c_dkgray);
part_type_size(part1,.15,.25,0,0);
part_type_speed(part1,.5,2,0,0);
part_type_direction(part1,0,360,0,4); // set later
part_type_orientation(part1,0,360,5,5,1);
part_type_alpha3(part1, 1, .7, .25);
part_type_life(part1,20,30);
part1Num = 15;

attackSound = snd_enemy_lighteater_tailshot;
prepSound = snd_enemy_lighteater_tailshot_prep;
attackSoundsVocals = [snd_enemy_lighteater_tailshot_vocals, snd_enemy_lighteater_tailshot_vocals];


/*
prepPart1 = part1;
prepPart1Num = 2;
prepPart1BelowOwner = false;

prepPartBoundingBox = [0, 1, 0, 1];