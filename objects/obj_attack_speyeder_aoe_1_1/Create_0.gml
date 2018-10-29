event_inherited();
spriteName = "spr_enemy_speyeder_aoe";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_add(damages,CRUSH,[5,15]);
isRanged = false;
staminaCost = 5;
staggerDuration = 2;
limbKey = noone;
type = AttackTypes.AOE;
minRange = 30;
numberOfProjectiles = 8;
projectileSpeed = 15;
damageType = "Dust";

part1 = part_type_create();
part_type_sprite(part1,spr_enemy_speyeder_aoe_1_1_particle,1,0,1);
part_type_alpha2(part1,1,.2);
part_type_color2(part1,c_white,c_silver);
part_type_size(part1,.5,1,0,0);
part_type_speed(part1,.5,2,0,0);
part_type_direction(part1,0,360,0,4); // set later
part_type_orientation(part1,0,360,5,5,1);
part_type_life(part1,15,25);
part1Num = 15;

attackSound = snd_enemy_speyeder_web_shoot;
prepSound = snd_enemy_speyeder_webprep;

prepPart1 = part1;
prepPart1Num = 2;