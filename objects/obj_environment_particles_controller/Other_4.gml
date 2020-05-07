with obj_environment_particles {
	instance_destroy(id, 1);
}


// look at what room we're in, then make particles accordingly
switch room {
	case rm_dungeon: {
		var dust = part_type_create();
		part_type_shape(dust, pt_shape_sphere);
		part_type_alpha2(dust,.8,0);
		part_type_color2(dust,c_olive,c_ltgray);
		part_type_orientation(dust,0,0,0,15,1);
		part_type_size(dust,0,0.15,0,.01);
		part_type_speed(dust,.3,1,0,0);
		part_type_direction(dust,0,360,0,4);
		part_type_life(dust,250,500);
		makeEnvironmentParticles(dust,noone,"instances_floor_1",-1,noone);
		break;
	}
	case rm_factory: {
		var dust = part_type_create();
		part_type_shape(dust, pt_shape_sphere);
		part_type_alpha2(dust,.8,0);
		part_type_color2(dust,c_aqua,c_white);
		part_type_orientation(dust,0,0,0,15,1);
		part_type_size(dust,0,0.15,0,.01);
		part_type_speed(dust,.3,1,0,0);
		part_type_direction(dust,0,360,0,4);
		part_type_life(dust,250,500);
		var dust2 = part_type_create();
		part_type_shape(dust2, pt_shape_sphere);
		part_type_alpha2(dust2,.8,0);
		part_type_color2(dust2,c_silver,c_white);
		part_type_orientation(dust2,0,0,0,15,1);
		part_type_size(dust2,0,0.15,0,.01);
		part_type_speed(dust2,.3,1,0,0);
		part_type_direction(dust2,0,360,0,4);
		part_type_life(dust2,250,500);
		makeEnvironmentParticles(dust2,noone,"instances_floor_0",-1,noone, 50);
		makeEnvironmentParticles(dust,noone,"instances_floor_1",-1,noone, 100);
		makeEnvironmentParticles(dust,noone,"instances_floor_2",-1,noone, 100);
		makeEnvironmentParticles(dust,noone,"instances_floor_3",-1,noone, 100);
		makeEnvironmentParticles(dust,noone,"instances_floor_4",-1,noone, 100);
		break;
	}
	case rm_boss_ravebot: {
		var dust = part_type_create();
		part_type_shape(dust, pt_shape_sphere);
		part_type_alpha2(dust,.8,0);
		part_type_color2(dust,c_aqua,c_white);
		part_type_orientation(dust,0,0,0,15,1);
		part_type_size(dust,0,0.15,0,.01);
		part_type_speed(dust,.3,1,0,0);
		part_type_direction(dust,0,360,0,4);
		part_type_life(dust,250,500);
		makeEnvironmentParticles(dust,noone,"instances_floor_2",-1,noone, 75);
		break;
	}
	case rm_boss_lighteater: {
		var dust = part_type_create();
		part_type_shape(dust, pt_shape_sphere);
		part_type_alpha2(dust,.8,0);
		part_type_color2(dust,c_aqua,c_white);
		part_type_orientation(dust,0,0,0,15,1);
		part_type_size(dust,0,0.15,0,.01);
		part_type_speed(dust,.3,1,0,0);
		part_type_direction(dust,0,360,0,4);
		part_type_life(dust,250,500);
		makeEnvironmentParticles(dust,noone,"instances_floor_4",-1,noone, 75);
		break;
	}
	case rm_forest: {
		var dust = part_type_create();
		part_type_shape(dust, pt_shape_sphere);
		part_type_alpha2(dust,.8,0);
		part_type_color2(dust,c_silver,c_olive);
		part_type_orientation(dust,0,0,0,15,1);
		part_type_size(dust,0,0.15,0,.01);
		part_type_speed(dust,.3,1,0,0);
		part_type_direction(dust,0,360,0,4);
		part_type_life(dust,250,500);
		
		var leaf = part_type_create();
		part_type_sprite(leaf, spr_part_leaf, true, false, true);
		part_type_alpha2(leaf,.7,0);
		part_type_color2(leaf,c_white,c_olive);
		part_type_orientation(leaf,0,0,1,1,1);
		part_type_size(leaf,.3,.6,0,.03);
		part_type_speed(leaf,.3,1,0,0);
		part_type_direction(leaf,0,360,0,0);
		part_type_life(leaf,250,500);
		makeEnvironmentParticles(dust,leaf,"instances_floor_1",1,-2);
		makeEnvironmentParticles(dust,leaf,"instances_floor_2",1,-2);
		break;
	}
	case rm_winter: {
		var snowflake1 = part_type_create();
		part_type_shape(snowflake1, pt_shape_snow);
		part_type_alpha2(snowflake1,.8,0);
		part_type_color2(snowflake1,c_silver,c_white);
		part_type_orientation(snowflake1,0,0,0,15,1);
		part_type_size(snowflake1,0,0.15,0,.01);
		part_type_speed(snowflake1,4,8,0,0);
		part_type_direction(snowflake1,0,360,4,10);
		part_type_life(snowflake1,150,200);
		
		var snowflake2 = part_type_create();
		part_type_shape(snowflake2, pt_shape_snow);
		part_type_alpha2(snowflake2,.8,0);
		part_type_color2(snowflake2,c_silver,c_white);
		part_type_orientation(snowflake2,0,0,0,15,1);
		part_type_size(snowflake2,0,0.15,0,.01);
		part_type_speed(snowflake2,4,8,0,0);
		part_type_direction(snowflake2,0,360,-4,10);
		part_type_life(snowflake2,150,200);
		makeEnvironmentParticles(snowflake1,snowflake2,"instances_floor_1",10,10, 100, 100);
		
		break;
	}
	case rm_abominable_lands: {
		var dust = part_type_create();
		part_type_shape(dust, pt_shape_sphere);
		part_type_alpha2(dust,.8,0);
		part_type_color2(dust,c_aqua,c_silver);
		part_type_orientation(dust,0,0,0,15,1);
		part_type_size(dust,0,0.15,0,.01);
		part_type_speed(dust,.3,1,0,0);
		part_type_direction(dust,0,360,0,4);
		part_type_life(dust,250,500);
		
		var crystal = part_type_create();
		part_type_sprite(crystal, spr_part_icecrystal, true, false, true);
		part_type_alpha2(crystal,.7,0);
		part_type_color2(crystal,c_white,c_olive);
		part_type_orientation(crystal,0,359,1,1,1);
		part_type_size(crystal,.3,.4,0,.03);
		part_type_speed(crystal,.3,1,0,0);
		part_type_direction(crystal,0,360,0,0);
		part_type_life(crystal,250,500);
		makeEnvironmentParticles(dust,crystal,"instances_floor_1",1,-2);
		makeEnvironmentParticles(dust,crystal,"instances_floor_2",1,-2);
		break;
	}
	case rm_xmas_town: {
		var snowflake1 = part_type_create();
		part_type_shape(snowflake1, pt_shape_snow);
		part_type_alpha2(snowflake1,.8,0);
		part_type_color2(snowflake1,c_silver,c_white);
		part_type_orientation(snowflake1,0,0,0,15,1);
		part_type_size(snowflake1,0,0.15,0,.01);
		part_type_speed(snowflake1,4,8,0,0);
		part_type_direction(snowflake1,0,360,4,10);
		part_type_life(snowflake1,150,200);
		
		var snowflake2 = part_type_create();
		part_type_shape(snowflake2, pt_shape_snow);
		part_type_alpha2(snowflake2,.8,0);
		part_type_color2(snowflake2,c_silver,c_white);
		part_type_orientation(snowflake2,0,0,0,15,1);
		part_type_size(snowflake2,0,0.15,0,.01);
		part_type_speed(snowflake2,4,8,0,0);
		part_type_direction(snowflake2,0,360,-4,10);
		part_type_life(snowflake2,150,200);
		makeEnvironmentParticles(snowflake1,snowflake2,"instances_floor_1",10,10, 100, 100);
		
		break;
	}
	case rm_hanukkah_village: {
		var snowflake1 = part_type_create();
		part_type_shape(snowflake1, pt_shape_snow);
		part_type_alpha2(snowflake1,.8,0);
		part_type_color2(snowflake1,c_silver,c_white);
		part_type_orientation(snowflake1,0,0,0,15,1);
		part_type_size(snowflake1,0,0.15,0,.01);
		part_type_speed(snowflake1,4,8,0,0);
		part_type_direction(snowflake1,0,360,4,10);
		part_type_life(snowflake1,150,200);
		
		var snowflake2 = part_type_create();
		part_type_shape(snowflake2, pt_shape_snow);
		part_type_alpha2(snowflake2,.8,0);
		part_type_color2(snowflake2,c_silver,c_white);
		part_type_orientation(snowflake2,0,0,0,15,1);
		part_type_size(snowflake2,0,0.15,0,.01);
		part_type_speed(snowflake2,4,8,0,0);
		part_type_direction(snowflake2,0,360,-4,10);
		part_type_life(snowflake2,150,200);
		makeEnvironmentParticles(snowflake1,snowflake2,"instances_floor_1",10,10, 100, 100);
		
		break;
	}
	case rm_tundra: {
		var snowflake1 = part_type_create();
		part_type_shape(snowflake1, pt_shape_snow);
		part_type_alpha2(snowflake1,.8,0);
		part_type_color2(snowflake1,c_silver,c_white);
		part_type_orientation(snowflake1,0,0,0,15,1);
		part_type_size(snowflake1,0,0.15,0,.01);
		part_type_speed(snowflake1,4,8,0,0);
		part_type_direction(snowflake1,0,360,4,10);
		part_type_life(snowflake1,150,200);
		
		var snowflake2 = part_type_create();
		part_type_shape(snowflake2, pt_shape_snow);
		part_type_alpha2(snowflake2,.8,0);
		part_type_color2(snowflake2,c_silver,c_white);
		part_type_orientation(snowflake2,0,0,0,15,1);
		part_type_size(snowflake2,0,0.15,0,.01);
		part_type_speed(snowflake2,4,8,0,0);
		part_type_direction(snowflake2,0,360,-4,10);
		part_type_life(snowflake2,150,200);
		makeEnvironmentParticles(snowflake1,snowflake2,"instances_floor_1",12,12, 100, 100);
		makeEnvironmentParticles(snowflake1,snowflake2,"instances_floor_2",12,12, 100, 100);
		break;
	}
	case rm_clayfields: {
		var snowflake1 = part_type_create();
		part_type_shape(snowflake1, pt_shape_snow);
		part_type_alpha2(snowflake1,.8,0);
		part_type_color2(snowflake1,c_silver,c_white);
		part_type_orientation(snowflake1,0,0,0,15,1);
		part_type_size(snowflake1,0,0.15,0,.01);
		part_type_speed(snowflake1,4,8,0,0);
		part_type_direction(snowflake1,0,360,4,10);
		part_type_life(snowflake1,150,200);
		
		var snowflake2 = part_type_create();
		part_type_shape(snowflake2, pt_shape_snow);
		part_type_alpha2(snowflake2,.8,0);
		part_type_color2(snowflake2,c_silver,c_white);
		part_type_orientation(snowflake2,0,0,0,15,1);
		part_type_size(snowflake2,0,0.15,0,.01);
		part_type_speed(snowflake2,4,8,0,0);
		part_type_direction(snowflake2,0,360,-4,10);
		part_type_life(snowflake2,150,200);
		makeEnvironmentParticles(snowflake1,snowflake2,"instances_floor_1",12,12, 100, 100);
		makeEnvironmentParticles(snowflake1,snowflake2,"instances_floor_2",12,12, 100, 100);
		break;
	}
	case rm_krampus: {
		var snowflake1 = part_type_create();
		part_type_shape(snowflake1, pt_shape_snow);
		part_type_alpha2(snowflake1,.8,0);
		part_type_color2(snowflake1,c_silver,c_white);
		part_type_orientation(snowflake1,0,0,0,15,1);
		part_type_size(snowflake1,0,0.15,0,.01);
		part_type_speed(snowflake1,4,8,0,0);
		part_type_direction(snowflake1,0,360,4,10);
		part_type_life(snowflake1,150,200);
		
		var snowflake2 = part_type_create();
		part_type_shape(snowflake2, pt_shape_snow);
		part_type_alpha2(snowflake2,.8,0);
		part_type_color2(snowflake2,c_silver,c_white);
		part_type_orientation(snowflake2,0,0,0,15,1);
		part_type_size(snowflake2,0,0.15,0,.01);
		part_type_speed(snowflake2,4,8,0,0);
		part_type_direction(snowflake2,0,360,-4,10);
		part_type_life(snowflake2,150,200);
		makeEnvironmentParticles(snowflake1,snowflake2,"instances_floor_1",12,12, 100, 100);
		makeEnvironmentParticles(snowflake1,snowflake2,"instances_floor_2",12,12, 100, 100);
		break;
	}
	case rm_golemking: {
		var snowflake1 = part_type_create();
		part_type_shape(snowflake1, pt_shape_snow);
		part_type_alpha2(snowflake1,.8,0);
		part_type_color2(snowflake1,c_silver,c_white);
		part_type_orientation(snowflake1,0,0,0,15,1);
		part_type_size(snowflake1,0,0.15,0,.01);
		part_type_speed(snowflake1,4,8,0,0);
		part_type_direction(snowflake1,0,360,4,10);
		part_type_life(snowflake1,150,200);
		
		var snowflake2 = part_type_create();
		part_type_shape(snowflake2, pt_shape_snow);
		part_type_alpha2(snowflake2,.8,0);
		part_type_color2(snowflake2,c_silver,c_white);
		part_type_orientation(snowflake2,0,0,0,15,1);
		part_type_size(snowflake2,0,0.15,0,.01);
		part_type_speed(snowflake2,4,8,0,0);
		part_type_direction(snowflake2,0,360,-4,10);
		part_type_life(snowflake2,150,200);
		makeEnvironmentParticles(snowflake1,snowflake2,"instances_floor_1",10,10, 100, 100);
		makeEnvironmentParticles(snowflake1,snowflake2,"instances_floor_2",10,10, 100, 100);
		break;
	}
	case rm_boss_funfairy: {
		var dust = part_type_create();
		part_type_shape(dust, pt_shape_sphere);
		part_type_alpha2(dust,.8,0);
		part_type_color2(dust,c_silver,c_olive);
		part_type_orientation(dust,0,0,0,15,1);
		part_type_size(dust,0,0.15,0,.01);
		part_type_speed(dust,.3,1,0,0);
		part_type_direction(dust,0,360,0,4);
		part_type_life(dust,250,500);
		makeEnvironmentParticles(dust,noone,"instances_floor_1",1,noone);
		break;
	}
}