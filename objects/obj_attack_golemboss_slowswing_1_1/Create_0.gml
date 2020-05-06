event_inherited();
spriteName = "spr_enemy_golemboss_slowswing";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = noone; // default value
ds_map_add(damages,SLASH,[35,35]);
ds_map_add(damages, FIRE, [15, 15]);
type = AttackTypes.Charge;
isRanged = false;
staminaCost = 10;
staggerDuration = 45;

attackSound = snd_axe2h_attack_1;
hitSound = snd_hit1;
minRange = 80;

attackSoundsVocals = [snd_enemy_golem_attack_1];
prepSoundsVocals = [snd_enemy_golem_roar_2];
prepSound = snd_magic_fire_charge;

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

prepPart1 = cinder;

prepPart1Num = 10;

chargeSpeed = 18;