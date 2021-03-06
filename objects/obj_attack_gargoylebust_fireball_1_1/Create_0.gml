event_inherited();
spriteName = "spr_enemy_gargoylebust_fireball";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_replace(damages,FIRE,[30,30]);
// ds_map_replace(conditionsChances, POISON, .8); // 100% chance a hit will poison someone
isRanged = true;
isSpell = true;
staminaCost = 5;
staggerDuration = 5;
type = AttackTypes.Standard;
minRange = 720;
projectileSpeed = 15;
doesNotStagger = true;
staggersAgainstBlocks = false;
turnSpeed = 7;


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

part1Num = 14;

prepPart1 = part1;
prepPart1Num = 13;
prepPartBoundingBox = [60, -5, 64, 5];
prepSound = snd_magic_fire_charge;

attackSound = snd_magic_fire_shoot;
attackSoundLoop = snd_magic_fire_loop;

hasLightRadius = true;
lightRadiusScale = .25;
lightRadiusAlpha = noone;
lightRadiusColor = C_FIRELIGHT;

