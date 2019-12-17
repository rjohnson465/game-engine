event_inherited();
spriteName = "spr_enemy_golemboss_slam";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 2;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_add(damages,CRUSH,[20,25]);
isRanged = true;
staminaCost = 5;
staggerDuration = 45;
limbKey = noone;
type = AttackTypes.AOE;
minRange = 50;
numberOfProjectiles = 16;

projectileSpeed = 15;
damageType = "Dust";

var smoke = part_type_create();
part_type_shape(smoke,pt_shape_smoke);
part_type_size(smoke,.3,.4,0,0);
part_type_color2(smoke,c_olive,c_ltgray);
part_type_alpha3(smoke,.8,.55,0); 
part_type_speed(smoke,.5,1.5,0,0);
part_type_direction(smoke,85,95,0,0);
// part_type_blend(smoke,1);
part_type_life(smoke,40,55);
part1 = smoke;
part1Num = 15;

staggersAgainstBlocks = false;

attackSound = snd_dodge1;