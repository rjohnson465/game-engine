 event_inherited();
spriteName = "spr_enemy_icewyrm_spray";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_replace(damages,ICE,[3,6]);
// ds_map_replace(conditionsChances, POISON, .8); // 100% chance a hit will poison someone
isRanged = false;
staminaCost = 5;
staggerDuration = 2;
type = AttackTypes.Zone;
minRange = 30;
projectileSpeed = 15;
isVisible = false;
refreshCombatantsHit = 8; 
doesNotStagger = true;
staggersAgainstBlocks = false;

// ice clouds
part1 = part_type_create();
part_type_shape(part1, pt_shape_cloud);
part_type_orientation(part1,0,359,0,15,1);
part_type_size(part1,0.25,.65,0,0);
part_type_speed(part1,.5,.75,0,0);
part_type_direction(part1,0,360,0,4);
part_type_life(part1,25,50);
part_type_color2(part1,c_navy,c_silver);
part_type_alpha3(part1,.85,.5,.25);

part1Num = 20;

prepPart1Num = 2;
prepPart1 = part1;
prepPartBoundingBox = [15, 0, 16, 1];
// prepPartStartFrame = 5;
prepSound = snd_magic_ice_charge;

attackSound = snd_magic_ice_shoot;
attackSoundLoop = snd_magic_ice_loop;

turnsDuringAttack = true;
turnSpeedAttack = 4;

attackSoundsVocals = [noone, snd_enemy_icewyrm_attack_1];