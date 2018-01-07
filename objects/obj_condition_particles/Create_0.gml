condition = global.condition;
owner = global.owner;
emitter = noone;
system = noone;
particle = noone;
switch condition {
	case ICE: {
		var snow = part_system_create();
		part_system_depth(snow,-4);
		system = snow;
		
		// snowflake particle
		var snowflake = part_type_create();
		part_type_shape(snowflake, pt_shape_snow);
		part_type_orientation(snowflake,0,0,0,15,1);
		part_type_size(snowflake,0,0.25,0,0);
		part_type_speed(snowflake,1,1.5,0,0);
		part_type_direction(snowflake,0,360,0,4);
		part_type_life(snowflake,10,20);
		particle = snowflake;
		// emit
		var snow_emitter = part_emitter_create(snow);
		/*var x1 = owner.x - (owner.sprite_width*.5);
		var y1 = owner.y - (owner.sprite_height*.5);
		var x2 = owner.x + (owner.sprite_width*.5);
		var y2 = owner.y + (owner.sprite_height*.5);*/
		//part_emitter_region(snow,snow_emitter,x1,y1,x2,y2,ps_shape_ellipse,ps_distr_linear);
		//part_emitter_stream(snow,snow_emitter,snowflake,-500);
		emitter = snow_emitter;
		break;
	}
}