event_inherited();
spriteName = "spr_enemy_golemboss_slam";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_add(damages,CRUSH,[5,10]);
isRanged = false;
staminaCost = 5;
staggerDuration = 30;
limbKey = noone;
type = AttackTypes.Charge;
minRange = 100;

staggersAgainstBlocks = false;

attackSound = snd_axe2h_attack_1;
prepSound = snd_rock_rumbling_prep;

attackSoundMid = snd_crunchy_thud;
attackSoundMidFrame = 5;

attackSoundsVocals = [snd_enemy_golem_attack_1];
prepSoundsVocals = [snd_enemy_golem_prep_1];

prepPart1 = part_type_create();
part_type_sprite(prepPart1,spr_enemy_golemboss_slam_1_2_projectile,1,1,1);
part_type_size(prepPart1,.15,.25,0,0);
part_type_color2(prepPart1,c_white,c_white);
part_type_alpha3(prepPart1,1,1,0);
part_type_speed(prepPart1,2,4,0,0);
part_type_direction(prepPart1,0,359,0,5);
part_type_orientation(prepPart1,0,359,0,0,0);
// part_type_blend(prepPart1,1);
part_type_life(prepPart1,8,11);
prepPart1Num = 8;