condition = global.condition;
owner = global.owner;
emitter = noone;
system = noone;
particle = noone;
particle2 = noone;

xOff = owner.__x - owner.x;
yOff = owner.__y - owner.y;

system = part_system_create();
part_system_depth(system,-4);
emitter = part_emitter_create(system);

switch condition {
	case ICE: {
		// snowflake particle
		var snowflake = part_type_create();
		part_type_shape(snowflake, pt_shape_snow);
		part_type_orientation(snowflake,0,0,0,15,1);
		part_type_size(snowflake,0,0.25,0,0);
		part_type_speed(snowflake,1,1.5,0,0);
		part_type_direction(snowflake,0,360,0,4);
		part_type_life(snowflake,10,20);
		part_type_alpha3(snowflake,1,.75,.5);
		particle = snowflake;
		
		// tiny snowflake Particle
		var smallflake = part_type_create();
		part_type_shape(smallflake,pt_shape_sphere);
		part_type_size(smallflake,0,.1,0,0);
		part_type_color2(smallflake,c_white,c_ltgray);
		part_type_alpha3(smallflake,1,.75,.5); 
		part_type_speed(smallflake,1,2,0,0);
		part_type_direction(smallflake,0,360,0,0);
		part_type_blend(smallflake,1);
		part_type_life(smallflake,15,25);
		particle2 = smallflake;
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
		part_type_direction(fire,85,95,0,5);
		part_type_orientation(fire,0,359,0,0,0);
		part_type_blend(fire,1);
		part_type_life(fire,8,12);
		particle = fire;
		
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
		particle2 = cinder;
		break;
	}
	case POISON: {
		// poison clouds
		var poison = part_type_create();
		part_type_shape(poison, pt_shape_cloud);
		part_type_orientation(poison,0,359,0,15,1);
		part_type_size(poison,0.25,.75,0,0);
		part_type_speed(poison,.5,.75,0,0);
		part_type_direction(poison,0,360,0,4);
		part_type_life(poison,15,20);
		part_type_color2(poison,c_green,c_olive);
		part_type_alpha3(poison,.75,.5,.25);
		particle = poison;
		break;
	}
	case LIGHTNING: {
		var spark = part_type_create();
		part_type_shape(spark, pt_shape_spark);
		part_type_orientation(spark,0,359,0,15,1);
		part_type_size(spark,0.25,.35,0,0);
		part_type_speed(spark,8,12,0,0);
		part_type_direction(spark,0,360,0,4);
		part_type_life(spark,3,6);
		part_type_color2(spark,c_blue,c_white);
		part_type_alpha3(spark,1,.85,.75);
		particle = spark;
		break;
	}
	/*case "Stagger": {
		
		var star = part_type_create();
		part_type_shape(star, pt_shape_star);
		part_type_color2(star,c_olive,c_ltgray);
		
		part_type_orientation(star,0,0,0,15,1);
		part_type_size(star,0,0.2,0,0);
		part_type_speed(star,2,3,0,0);
		part_type_direction(star,0,359,0,4);
		part_type_life(star,10,15);
		particle = star;
		break;
	}*/
	
	/*// blood particle
		var blood = part_type_create();
		part_type_shape(blood, pt_shape_sphere);
		part_type_color2(blood,c_red,c_maroon);
		
		part_type_orientation(blood,0,0,0,15,1);
		part_type_size(blood,0,0.15,0,0);
		part_type_speed(blood,2,8,0,0);
		randomize();
		var dir = random_range(0,359);
		part_type_direction(blood,dir-25,dir+25,0,4);
		part_type_life(blood,10,15);
		particle = blood;*/
}