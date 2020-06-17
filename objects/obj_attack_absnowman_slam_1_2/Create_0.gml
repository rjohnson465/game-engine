event_inherited();
spriteName = "spr_enemy_absnowman_slam";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 2;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_add(damages,CRUSH,[35,35]);
ds_map_add(damages,ICE,[1,1]);
isRanged = false;
staminaCost = 5;
staggerDuration = 45;
limbKey = noone;
type = AttackTypes.Zone;
minRange = 70;
turnSpeed = 8;

staggersAgainstBlocks = false;

attackSound = snd_crunchy_thud;
prepSound = snd_thrust_attack_1;

attackSoundsVocals = [snd_enemy_troll_roar_2];
prepSoundsVocals = [snd_enemy_troll_roar_3];

zoneCanHitShield = true;


// ice cloud
var smoke = part_type_create();
part_type_shape(smoke, pt_shape_smoke);
part_type_color2(smoke,c_aqua,c_white);
part_type_orientation(smoke,0,0,0,15,1);
part_type_alpha3(smoke, .5, .25, .1);
part_type_size(smoke,.35,.5,0,0);
part_type_speed(smoke,.2,1,0,0);
part_type_direction(smoke,0,360,0,4);
part_type_life(smoke,10,15 );
part1 = smoke;
zonePartNum = 20;
isVisible = false;