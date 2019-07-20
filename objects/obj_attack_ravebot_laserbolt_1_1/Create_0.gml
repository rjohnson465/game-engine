event_inherited();
spriteName = "spr_enemy_ravebot_laserbolt";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_replace(damages,LIGHTNING,[5,8]);
isRanged = true;
projectileSpeed = 10;
staminaCost = 5;
staggerDuration = 3;
limbKey = noone;
type = AttackTypes.Standard;
minRange = 100;

// TODO
prepSound = snd_magic_lightning_charge;
attackSound = snd_laserbolt;

hitSound = snd_hit1;

usesWeapon = false;

// TODO
part1 = part_type_create();
part_type_shape(part1, pt_shape_spark);
part_type_alpha2(part1,1,.2);
part_type_color2(part1,make_color_rgb(255,110,148),c_white);
part_type_size(part1,.05,.15,0,0);
part_type_speed(part1,.5,2,0,0);
part_type_direction(part1,0,360,0,4); // set later
part_type_orientation(part1,0,360,5,5,1);
part_type_life(part1,15,25);
part1Num = 5;

prepPart1 = part1;
prepPart1Num = 2;
prepPart1BelowOwner = true;