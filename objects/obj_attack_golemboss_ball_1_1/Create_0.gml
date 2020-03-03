event_inherited();
spriteName = "spr_enemy_golemboss_ball";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_add(damages,CRUSH,[25,30]);
ds_map_add(damages,FIRE,[8,10]);
staminaCost = 5;
staggerDuration = 45;
limbKey = noone;
type = AttackTypes.Charge;
minRange = 100;

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

// smoke particle
var smoke = part_type_create();
part_type_shape(smoke,pt_shape_smoke);
part_type_size(smoke,.1,.2,0,0);
part_type_color2(smoke,c_dkgray,c_ltgray);
part_type_alpha3(smoke,.7,.4,0); 
part_type_speed(smoke,.5,1.5,0,0);
part_type_direction(smoke,85,95,0,0);
part_type_blend(smoke,1);
part_type_life(smoke,25,50);

part1Num = 6;

prepPart1 = part1;
prepPart1Num = 13;
prepSound = snd_magic_fire_charge;
prepSoundsVocals = [snd_enemy_golem_roar_1];
attackSound = snd_golem_roll;

hasLightRadius = true;
lightRadiusScale = .25;
lightRadiusAlpha = noone;
lightRadiusColor = C_FIRELIGHT;

trailPart = [cinder, smoke];
trailPartNum = [12, 7];
trailStarts = 0;
trailEnds = 9;

chargeSpeed = 20;