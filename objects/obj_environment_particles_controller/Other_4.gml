
// look at what room we're in, then make particles accordingly
switch room {
	case room0: {
		var dust = part_type_create();
		part_type_shape(dust, pt_shape_sphere);
		part_type_alpha2(dust,.8,0);
		part_type_color2(dust,c_olive,c_ltgray);
		part_type_orientation(dust,0,0,0,15,1);
		part_type_size(dust,0,0.15,0,.01);
		part_type_speed(dust,.3,1,0,0);
		part_type_direction(dust,0,360,0,4);
		part_type_life(dust,250,500);
		makeEnvironmentParticles(dust,noone,"instances_floor_2",-1,noone);
		break;
	}
}