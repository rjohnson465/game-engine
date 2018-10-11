/// defineWeaponParticles()
// returns a map with all the item weapon particles

var map = ds_map_create();

var snowflake = part_type_create();
part_type_shape(snowflake, pt_shape_snow);
part_type_orientation(snowflake,0,0,0,15,1);
part_type_size(snowflake,0,0.1,0,0);
part_type_speed(snowflake,1,1.5,0,0);
part_type_direction(snowflake,0,360,0,4);
part_type_life(snowflake,10,20);
part_type_alpha3(snowflake,1,.75,.5);

var magic = part_type_create();
part_type_shape(magic, pt_shape_sphere);
part_type_color2(magic,c_aqua,c_ltgray);
part_type_orientation(magic,0,0,0,15,1);
part_type_size(magic,0,0.07,0,0);
part_type_speed(magic,1,2,0,0);
part_type_direction(magic,0,360,0,4);
part_type_life(magic,10,15);

// cinder Particle
var cinder = part_type_create();
part_type_shape(cinder,pt_shape_flare);
part_type_size(cinder,0,.1,0,0);
part_type_color2(cinder,c_orange,c_red);
part_type_alpha3(cinder,1,1,0); 
part_type_speed(cinder,1,2,0,0);
part_type_direction(cinder,85,95,0,0);
part_type_blend(cinder,1);
part_type_life(cinder,25,50);

// poison clouds
var poison = part_type_create();
part_type_shape(poison, pt_shape_cloud);
part_type_orientation(poison,0,359,0,15,1);
part_type_size(poison,0.1,.45,0,0);
part_type_speed(poison,.5,.75,0,0);
part_type_direction(poison,0,360,0,4);
part_type_life(poison,15,20);
part_type_color2(poison,c_lime,c_olive);
part_type_alpha3(poison,.75,.5,.25);

var spark = part_type_create();
part_type_shape(spark, pt_shape_spark);
part_type_orientation(spark,0,359,0,15,1);
part_type_size(spark,0.04,.16,0,0);
part_type_speed(spark,3,6,0,0);
part_type_direction(spark,0,360,0,4);
part_type_life(spark,5,8);
part_type_color2(spark,c_purple,c_white);
part_type_alpha3(spark,1,.85,.75);

ds_map_replace(map,MAGIC,magic);
ds_map_replace(map,FIRE,cinder);
ds_map_replace(map,ICE,snowflake);
ds_map_replace(map,POISON,poison);
ds_map_replace(map,LIGHTNING,spark);

return map;