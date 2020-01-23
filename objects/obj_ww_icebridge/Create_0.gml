global.bridgeAngle = image_angle;
global.bridgeSpriteIndex = sprite_index;
origLayer = layer;
angle = image_angle; // decided by placement in room
xscale = image_xscale; yscale = image_yscale;
event_inherited();

lever = noone;
bKey = "defaultBridgeKey";

system = part_system_create();
part_system_depth(system,layer_get_depth(origLayer));
emitter = part_emitter_create(system);
particle = part_type_create();
part_type_shape(particle, pt_shape_cloud);
part_type_color2(particle,c_aqua,c_white);
part_type_alpha2(particle,.55,.15);
part_type_orientation(particle,0,0,0,15,1);
part_type_size(particle,0.25,0.55,0,0);
part_type_speed(particle,.5,1,0,0);
part_type_direction(particle,0,360,0,4);
part_type_life(particle,45,60);

lightScaleX = image_xscale / 2;
lightScaleY = image_yscale / 2;
lightAlpha = .35;
scale = 1;
scaleFrame = 0;
scaleTotalFrames = 120;

light_create_layer_multiscale(spr_light_square, lightScaleX, lightScaleY, c_white, 0, 0, true);