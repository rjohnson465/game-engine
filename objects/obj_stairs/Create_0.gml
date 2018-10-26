event_inherited();
postX = x;
postY = y;
upDirectionString = noone;
upDirectionMin = 0;
upDirectionMax = 180;
floorUp = 0;
floorDown = 0;

part = part_type_create();
system = part_system_create();
part_system_depth(system, layer_get_depth(layer)-1);
emitter = part_emitter_create(system);
part = part_type_create();
part_type_shape(part, pt_shape_sphere);
part_type_alpha2(part,.5,.2);
part_type_color2(part,c_navy,c_aqua);
part_type_orientation(part,0,0,0,15,1);
part_type_size(part,0,0.10,0,0);
part_type_speed(part,.5,1,0,0);
part_type_direction(part,0,360,0,4);
part_type_life(part,25,50);

scale = 1;
floatingFrame = 0;

randomize();
glowMin = 1;
glowMax = 8;
glowAmount = random_range(glowMin,glowMax); // (px offset for "glow" effect)
isGlowIncreasing = true;