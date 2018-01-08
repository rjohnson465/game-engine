condition = global.condition;
owner = global.owner;
emitter = noone;
system = noone;
particle = noone;

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
		particle = snowflake;
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
		break;
	}
	case POISON: {
		// poison clouds
		var poison = part_type_create();
		part_type_shape(poison, pt_shape_cloud);
		part_type_orientation(poison,0,359,0,15,1);
		part_type_size(poison,.25,1,0,0);
		part_type_speed(poison,.5,.75,0,0);
		part_type_direction(poison,0,360,0,4);
		part_type_life(poison,15,20);
		part_type_color2(poison,c_green,c_olive);
		part_type_alpha3(poison,.75,.5,.25);
		particle = poison;
	}
}