event_inherited();
spriteName = "spr_enemy_golemboss_mm";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = noone; // default value
ds_map_add(damages, FIRE, [10, 10]);
isRanged = true;
staminaCost = 10;
staggerDuration = 15;
projectileSpeed = 15;

type = AttackTypes.AOE;
numberOfProjectiles = 3;
aoeProjectilesDirectionOffsetArray = [-45, 0, 45];
isSpell = true;

prepSound = snd_magic_fire_charge;
attackSoundLoop = snd_magic_fire_loop;
attackSound = snd_magic_fire_shoot;

minRange = 250;

attackSoundsVocals = [snd_enemy_golem_attack_1];
prepSoundsVocals = [snd_enemy_golem_prep_1];

hasLightRadius = true;
lightRadiusScale = .25;
lightRadiusAlpha = noone;
lightRadiusColor = C_FIRELIGHT;

// cinder prep part
var cinder = part_type_create();
part_type_shape(cinder,pt_shape_flare);
part_type_size(cinder,0.01,.11,0,0);
part_type_color2(cinder,c_orange,c_red);
part_type_alpha3(cinder,1,1,0); 
part_type_speed(cinder,1,2,0,0);
part_type_direction(cinder,0,359,0,0);
part_type_blend(cinder,1);
part_type_life(cinder,38,45);
part1 = cinder;

part1Num = 10;

prepPart1 = cinder;
prepPart1Num = 10;
prepPartBoundingBox = [100, 0, 110, 10];

trackingMinDistance = 500;
tracksTargets = true;

aoeOnlyHitsOnce = false; // each projectile can hit
