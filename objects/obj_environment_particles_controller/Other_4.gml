
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
		/*var dust2 = part_type_create();
		part_type_shape(dust2, pt_shape_sphere);
		part_type_alpha2(dust2,.8,0);
		part_type_color2(dust2,c_red,c_white);
		part_type_orientation(dust2,0,0,0,15,1);
		part_type_size(dust2,0,0.15,0,.01);
		part_type_speed(dust2,.3,1,0,0);
		part_type_direction(dust2,0,360,0,4);
		part_type_life(dust2,250,500);
		var dust3 = part_type_create();
		part_type_shape(dust3, pt_shape_sphere);
		part_type_alpha2(dust3,.8,0);
		part_type_color2(dust3,c_lime,c_white);
		part_type_orientation(dust3,0,0,0,15,1);
		part_type_size(dust3,0,0.15,0,.01);
		part_type_speed(dust3,.3,1,0,0);
		part_type_direction(dust3,0,360,0,4);
		part_type_life(dust3,250,500); */
		makeEnvironmentParticles(dust,noone,"instances_floor_1",-1,noone, 100);
		makeEnvironmentParticles(dust,noone,"instances_floor_2",-1,noone, 100);
		makeEnvironmentParticles(dust,noone,"instances_floor_3",-1,noone, 100);
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
		makeEnvironmentParticles(dust,noone,"instances_floor_1",1,noone);
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