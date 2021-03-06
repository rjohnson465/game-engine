event_inherited();
spriteName = "spr_enemy_icetroll_slam";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = noone;
ds_map_add(damages,CRUSH,[40,40]);
isRanged = false;
staminaCost = 5;
staggerDuration = 30;
limbKey = noone;
type = AttackTypes.Standard;
minRange = 65;

staggersAgainstBlocks = false;

attackSound = snd_axe2h_attack_1;
prepSound = snd_thrust_attack_1;

attackSoundsVocals = [snd_enemy_troll_roar_2];
prepSoundsVocals = [snd_enemy_troll_roar_3];

attackSoundMid = snd_crunchy_thud;
attackSoundMidFrame = 5;

turnsDuringAttack = true;
turnSpeedAttack = 3;

// smoke
var smoke = part_type_create();
part_type_shape(smoke, pt_shape_smoke);
part_type_color2(smoke,c_olive,c_silver);
part_type_orientation(smoke,0,0,0,15,1);
part_type_alpha3(smoke, .5, .25, .1);
part_type_size(smoke,0.2,0.6,0,0);
part_type_speed(smoke,2,6,0,0);
part_type_direction(smoke,0,360,0,4);
part_type_life(smoke,45,60);
attackPart = smoke;
attackPartStartFrame = 5;
attackPartEndFrame = 5;
attackPartNum = 5;
attackPartBoundingBox = [100, -50, 125, -25];