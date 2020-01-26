//event_inherited();
neverDeactivate = true;
isObstacleLayerless = false;
origLayer = layer;
postX = x;
postY = y;
isWall = true;

stopsAttacks = false;

isActive = true;

system = part_system_create();
part_system_depth(system, layer_get_depth(origLayer));

part_system_depth(system, depth + 5);

emitter = part_emitter_create(system);
part_emitter_region(system, emitter, bbox_left, bbox_right, bbox_top, bbox_bottom, ps_shape_rectangle, ps_distr_gaussian);

var smoke = part_type_create();
part_type_shape(smoke, pt_shape_smoke);
part_type_color2(smoke,c_navy,c_aqua);
part_type_orientation(smoke,0,0,0,15,1);
part_type_alpha3(smoke, .3, .2, .1);
part_type_size(smoke,0.5,1.0,0,0);
part_type_speed(smoke,.1,.2,0,0);
part_type_direction(smoke,0,360,0,4);
part_type_life(smoke,60,90);

var snowflake = part_type_create();
part_type_shape(snowflake, pt_shape_snow);
part_type_orientation(snowflake,0,0,0,15,1);
part_type_size(snowflake,0,0.25,0,0);
part_type_speed(snowflake,1,1.5,0,0);
part_type_direction(snowflake,0,360,0,4);
part_type_life(snowflake,10,20);

partSmoke = smoke;
partSnowflake = snowflake;