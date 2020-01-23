event_inherited();
spriteName = "spr_enemy_krampusmage_wand";
spriteAttackNumber = 2;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = "l";
ds_map_replace(damages,ICE,[8,10]);
ds_map_replace(damages,PIERCE, [20,25]);
// ds_map_replace(conditionsChances, POISON, .8); // 100% chance a hit will poison someone
isRanged = true;
staminaCost = 5;
staggerDuration = 2;
type = AttackTypes.Standard;
minRange = 800;
projectileSpeed = 15;
isVisible = false;
refreshCombatantsHit = 8; 
doesNotStagger = true;
staggersAgainstBlocks = false;

// snowflake
var snowflake = part_type_create();
part_type_shape(snowflake, pt_shape_snow);
part_type_orientation(snowflake,0,0,0,15,1);
part_type_size(snowflake,0,0.1,0,0);
part_type_speed(snowflake,1,1.5,0,0);
part_type_direction(snowflake,0,360,0,4);
part_type_life(snowflake,10,20);
part_type_alpha3(snowflake,1,.75,.5);
part_type_color2(snowflake, c_silver, c_white);
part1 = snowflake;

part1Num = 14;

prepPart1 = part1;
prepPartBoundingBox = [45, 0, 46, 1];
prepPartStartFrame = 5;
prepSound = snd_magic_ice_charge;

attackSound = snd_magic_ice_shoot;
attackSoundLoop = snd_magic_ice_loop;
