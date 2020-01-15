event_inherited();
spriteName = "spr_enemy_icetroll_drag";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
limbKey = noone;
ds_map_add(damages,CRUSH,[30,31]);
isRanged = false;
staminaCost = 5;
staggerDuration = 20;
limbKey = noone;
type = AttackTypes.Standard;
minRange = 65;

staggersAgainstBlocks = false;

attackSound = snd_scrape_1;
prepSound = snd_scrape_2;

attackSoundsVocals = [snd_enemy_troll_roar_1, snd_enemy_troll_roar_2];
prepSoundsVocals = [];

turnsDuringAttack = true;
turnSpeedAttack = 1;

// smoke
var smoke = part_type_create();
part_type_shape(smoke, pt_shape_smoke);
part_type_color2(smoke,c_olive,c_white);
part_type_orientation(smoke,0,0,0,15,1);
part_type_alpha3(smoke, .5, .25, .1);
part_type_size(smoke,0.2,0.3,0,0);
part_type_speed(smoke,2,6,0,0);
part_type_direction(smoke,0,360,0,4);
part_type_life(smoke,45,60);
trailPart = smoke;

/*
attackPartStartFrame = 4;
attackPartEndFrame = 5;
attackPartNum = 5;
attackPartBoundingBox = [100, -50, 125, -25];