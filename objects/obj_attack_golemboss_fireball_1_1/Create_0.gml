 event_inherited();
spriteName = "spr_enemy_golemboss_fireball";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_replace(damages,FIRE,[10,10]);
movesDuringPrep = false;
staminaCost = 5;
staggerDuration = 2;
type = AttackTypes.Zone;
minRange = 30;
projectileSpeed = 15;
isVisible = false;
refreshCombatantsHit = 8; 
doesNotStagger = true;
staggersAgainstBlocks = false;

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


var fire = part_type_create();
part_type_sprite(fire,spr_particle_fire,0,0,1);
part_type_size(fire,.5,.75,0,0);
part_type_color2(fire,c_orange,c_red);
part_type_alpha3(fire,1,1,0);
part_type_speed(fire,4,7,0,0);
part_type_direction(fire,85,95,0,5);
part_type_orientation(fire,0,359,0,0,0);
part_type_blend(fire,1);
part_type_life(fire,5,8);
part1 = fire;
// part2 = cinder;

prepPart1 = cinder;

zonePartNum = 20;
// zonePartNum2 = 10;


prepPart1Num = 10;

prepPartBoundingBox = [145, 0, 160, 10];
// prepPartStartFrame = 5;
prepSound = snd_magic_fire_charge;
prepSoundsVocals = [snd_enemy_golem_roar_1];

attackSound = snd_magic_fire_shoot;
attackSoundLoop = snd_magic_fire_loop;

turnSpeed = 0;


// attackSoundsVocals = [noone, snd_enemy_icewyrm_attack_1];