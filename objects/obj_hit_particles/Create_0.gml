type = global.damageType;
x1 = global.x1;
y1 = global.y1;
shieldDirection = global.shieldDirection;

randomize();
var num = random_range(2,7); // maybe make this dependent on how hard the hit was?

system = part_system_create();
part_system_depth(system,-4);
emitter = part_emitter_create(system);
particle = noone;

switch type {
	case PHYSICAL: {
		// blood particle
		var blood = part_type_create();
		part_type_shape(blood, pt_shape_sphere);
		part_type_color2(blood,c_red,c_maroon);
		part_type_orientation(blood,0,0,0,15,1);
		part_type_size(blood,0,0.25,0,0);
		part_type_speed(blood,2,3,0,0);
		part_type_direction(blood,0,360,0,4);
		part_type_life(blood,10,20);
		particle = blood;
		break;
	}
	case "Block": {
		var spark = part_type_create();
		part_type_shape(spark, pt_shape_spark);
		part_type_color2(spark,c_yellow,c_white);
		part_type_orientation(spark,0,0,0,15,1);
		part_type_size(spark,0,0.25,0,0);
		part_type_speed(spark,2,3,0,0);
		var minDir = shieldDirection - 45;
		if minDir < 0 {
			minDir = 360+minDir;
		}
		var maxDir = (shieldDirection + 45)%360;
		part_type_direction(spark,minDir,maxDir,0,4);
		part_type_life(spark,10,20);
		particle = spark;
		break;
	}
	case POISON: {
		// poison clouds
		var poison = part_type_create();
		part_type_shape(poison, pt_shape_cloud);
		part_type_orientation(poison,0,359,0,15,1);
		part_type_size(poison,0.7,1,0,0);
		part_type_speed(poison,.5,.75,0,0);
		part_type_direction(poison,0,360,0,4);
		part_type_life(poison,18,25);
		part_type_color2(poison,c_green,c_olive);
		part_type_alpha3(poison,.95,.85,.75);
		particle = poison;
		num = 2;
		break;
	}
	case FIRE: {
		// fire particle
		var fire = part_type_create();
		part_type_sprite(fire,spr_particle_fire,0,0,1);
		part_type_size(fire,.2,.5,0,0);
		part_type_color2(fire,c_orange,c_red);
		part_type_alpha3(fire,1,1,0);
		part_type_speed(fire,4,10,0,0);
		part_type_direction(fire,0,360,0,5);
		part_type_orientation(fire,0,359,0,0,0);
		part_type_blend(fire,1);
		part_type_life(fire,10,20);
		particle = fire;
		break;
	}
	case ICE: {
		// snowflake particle
		var snowflake = part_type_create();
		part_type_shape(snowflake, pt_shape_snow);
		part_type_orientation(snowflake,0,0,0,15,1);
		part_type_size(snowflake,0,0.25,0,0);
		part_type_speed(snowflake,1,1.5,0,0);
		part_type_direction(snowflake,0,360,0,4);
		part_type_life(snowflake,10,20);
		particle = snowflake;
		break;
	}
}
if particle {
	part_emitter_region(system,emitter,x1,x1,y1,y1,0,0);
	part_emitter_burst(system,emitter,particle,num);
}
instance_destroy(id,false);