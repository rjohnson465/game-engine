event_inherited();
spriteName = "spr_enemy_speyeder_poison";
spriteAttackNumber = 1;
spriteAttackNumberInChain = 1;
//hand = owner.leftHandItem.type == HandItemTypes.Shield ? "r" : "e"; // l | r | s | e | o
limbKey = noone;
ds_map_replace(damages,POISON,[1,3]);
ds_map_replace(conditionsChances, POISON, .8); // 100% chance a hit will poison someone
isRanged = false;
staminaCost = 5;
staggerDuration = 2;
limbKey = noone;
type = AttackTypes.Zone;
minRange = 30;
projectileSpeed = 15;
//damageType = "Dust";
isVisible = false;
refreshCombatantsHit = 5; 
doesNotStagger = true;

// poison clouds
part1 = part_type_create();
part_type_shape(part1, pt_shape_cloud);
part_type_orientation(part1,0,359,0,15,1);
part_type_size(part1,0.25,.65,0,0);
part_type_speed(part1,.5,.75,0,0);
part_type_direction(part1,0,360,0,4);
part_type_life(part1,25,50);
part_type_color2(part1,c_lime,c_olive);
part_type_alpha3(part1,.85,.5,.25);

attackSound = snd_magic_poison_shoot;
attackSoundLoop = snd_magic_poison_loop;