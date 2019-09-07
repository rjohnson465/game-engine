event_inherited();
spriteName = "spr_enemy_lighteater_aoe";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_replace(damages,POISON,[2,5]);
ds_map_replace(damages,FIRE,[1,1]);
isRanged = false;
staminaCost = 5;
staggerDuration = 2;
limbKey = noone;
type = AttackTypes.Zone;
minRange = 60;
projectileSpeed = 15;
//damageType = "Dust";
isVisible = false;
refreshCombatantsHit = 6; 
// doesNotStagger = true;

// poison clouds
part1 = part_type_create();
part_type_shape(part1, pt_shape_cloud);
part_type_orientation(part1,0,359,0,15,1);
part_type_size(part1,0.25,.65,0,0);
part_type_speed(part1,.5,.75,0,0);
part_type_direction(part1,0,360,0,4);
part_type_life(part1,25,50);
part_type_color2(part1,c_black,c_green);
part_type_alpha3(part1,.85,.5,.25);

var cinder = part_type_create();
part_type_shape(cinder,pt_shape_flare);
part_type_size(cinder,0,.1,0,0);
part_type_color2(cinder,c_orange,c_red);
part_type_alpha3(cinder,1,1,0); 
part_type_speed(cinder,1,2,0,0);
part_type_direction(cinder,0,359,0,0);
part_type_blend(cinder,1);
part_type_life(cinder,25,50);
part2 = cinder;

prepSound = snd_enemy_lighteater_prep_1;
attackSound = snd_magic_poison_shoot;
attackSoundsVocals = [snd_enemy_lighteater_attack_1];
attackSoundLoop = snd_magic_poison_loop;

zonePartNum = 15;

zonePartNum2 = 5;