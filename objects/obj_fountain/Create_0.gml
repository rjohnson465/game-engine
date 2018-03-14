isRunning = false;
isDoneFilling = false;

fountainData = noone;

lightRadius = 256;
lightRadiusAlpha = .35;
lightRadiusScale = .75;
lightRadiusColor = c_aqua;
lightRadiusSprite = spr_light_point;
isShowingLightRadius = true;
nativeRoom = room;

postX = x;
postY = y;
// override on instance creation
spawnX = postX + 100;
spawnY = postY + 100;

system = part_system_create();
part_system_depth(system,-4);
emitter = part_emitter_create(system);
particle = noone;

num = random_range(10,25);
// water particle
var water = part_type_create();
part_type_shape(water, pt_shape_sphere);
part_type_color2(water,c_aqua,c_ltgray);
part_type_orientation(water,0,0,0,15,1);
part_type_size(water,0,0.05,0,0);
part_type_speed(water,2,3,0,0);
part_type_direction(water,0,360,0,4);
part_type_life(water,7,11);
particle = water;

origLayer = layer;
layerName = layer_get_name(layer);

