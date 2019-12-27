event_inherited();
spriteName = "spr_enemy_dybukkboss_beam";
limbKey = noone; 
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;

ds_map_add(damages,MAGIC,[6,8]);

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
turnSpeedAttack = .5;

var spark = part_type_create();
part_type_shape(spark, pt_shape_spark);
part_type_orientation(spark,0,359,0,15,1);
part_type_size(spark,0.02,.15,0,0);
part_type_speed(spark,4,7,0,0);
part_type_direction(spark,0,360,0,4);
part_type_life(spark,10,20);
part_type_color2(spark,c_aqua,c_white);
part_type_alpha3(spark,1,.85,.75);
beamHitParticlesArr = [[spark, 10]];
beamHitSoundLoop = snd_magic_lightning_condition;

refreshCombatantsHit = 10; // can be hit up to 3 times / second