event_inherited();
spriteName = "spr_enemy_mushroom_spores";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = noone;
ds_map_add(damages,CRUSH,[4,6]);
isRanged = false;
staminaCost = 5;
staggerDuration = 2;
limbKey = noone;
type = AttackTypes.MultiRand;
minRange = 300;
numberOfProjectiles = 8;
damageType = "Dust";

part1 = part_type_create();

part_type_shape(part1, pt_shape_sphere);
part_type_alpha2(part1,1,.2);
part_type_color2(part1,c_olive,c_white);
part_type_size(part1,.05,.15,0,0);
part_type_speed(part1,.5,2,0,0);
part_type_direction(part1,0,360,0,4); // set later
part_type_orientation(part1,0,360,5,5,1);
part_type_life(part1,15,25);
part1Num = 15;

attackSound = noone;
attackSoundsVocals = [snd_enemy_mushroom_spore_vocals];
prepSound = snd_enemy_speyeder_webprep;

prepPart1 = part1;
prepPart1BelowOwner = true;
prepPart1Num = 20;

mrOffset = 200; // random projectiles within n px of target
mrPrepDuration = 30; // how long each projectile charges
mrAttackSound = snd_enemy_mushroom_spore_crunch;