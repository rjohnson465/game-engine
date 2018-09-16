event_inherited();
spriteName = "spr_enemy_speyeder_aoe";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_add(damages,PHYSICAL,[1,3]);
isRanged = false;
staminaCost = 5;
staggerDuration = 2;
limbKey = noone;
type = AttackTypes.AOE;
minRange = 20;
numberOfProjectiles = 8;
projectileSpeed = 15;

part1 = part_type_create();
part_type_shape(part1, pt_shape_sphere);
part_type_alpha2(part1,1,.2);
part_type_color2(part1,c_dkgray,c_silver);
part_type_size(part1,0,0.10,0,0);
part_type_speed(part1,.5,2,0,0);
part_type_direction(part1,0,360,0,4); // set later
part_type_life(part1,5,15);