event_inherited();
spriteName = "spr_enemy_dybukkboss_beam";
limbKey = noone; 
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;

ds_map_add(damages,MAGIC,[3,3]);

isRanged = false;
staminaCost = 10;
type = AttackTypes.Beam;
minRange = 350;
staggerDuration = 1;

attackSound = snd_dodge1;
hitSound = snd_hit1;

attackSoundsVocals = [];

prepSound = snd_magic_magic_charge;
prepSoundsVocals = [];
attackSound = snd_magic_magic_shoot;
attackSoundLoop = snd_magic_magic_condition;

beamHasLight = true;
beamLightColor = c_aqua
beamWidthWaverArray = [.2,1.2];
beamHitLightColor = c_aqua;

turnsDuringAttack = true;
turnSpeedAttack = 1;

var spark = part_type_create();
part_type_shape(spark, pt_shape_spark);
part_type_orientation(spark,0,359,0,15,1);
part_type_size(spark,0.02,.15,0,0);
part_type_speed(spark,4,7,0,0);
part_type_direction(spark,0,360,0,4);
part_type_life(spark,10,20);
part_type_color2(spark,c_red,c_white);
part_type_alpha3(spark,1,.85,.75);
beamHitParticlesArr = [[spark, 10]];
beamHitSoundLoop = snd_magic_lightning_condition;

// magic prep part
var magic = part_type_create();
part_type_shape(magic, pt_shape_sphere);
part_type_color2(magic,c_red,c_ltgray);
part_type_orientation(magic,0,0,0,15,1);
part_type_size(magic,0.1,0.2,0,0);
part_type_speed(magic,2,8,0,0);
part_type_direction(magic,0,360,0,4);
part_type_life(magic,10,15);

prepPart1 = magic;
prepPart1Num = 5;
prepPartBoundingBox = [100, 0, 110, 10];

refreshCombatantsHit = 10; // can be hit up to 3 times / second