condition = global.condition;
owner = global.owner;
emitter = noone;
system = noone;
particle = noone;
particle2 = noone;
particles = [];
alarm[0] = noone;
hasSetAlarm = false;

system = part_system_create();
//part_system_depth(system,layer_get_depth(owner.layer));
emitter = part_emitter_create(system);

if owner == global.player persistent = true;

switch condition {
	case ICE: {
		// snowflake particle
		var snowflake = part_type_create();
		part_type_shape(snowflake, pt_shape_snow);
		part_type_orientation(snowflake,0,0,0,15,1);
		part_type_size(snowflake,0,0.2,0,0);
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
	case MAGIC: {
		num = random_range(10,15);
		// magic particle
		var magic = part_type_create();
		part_type_shape(magic, pt_shape_sphere);
		part_type_color2(magic,c_aqua,c_ltgray);
		part_type_orientation(magic,0,0,0,15,1);
		part_type_size(magic,0,0.15,0,0);
		part_type_speed(magic,2,8,0,0);
		part_type_direction(magic,0,360,0,4);
		part_type_life(magic,10,15);
		particle = magic;
		break;
	}
	case FIRE: {
		// fire particle
		var fire = part_type_create();
		part_type_sprite(fire,spr_particle_fire,0,0,1);
		part_type_size(fire,.2,.5,0,0);
		part_type_color2(fire,c_orange,c_red);
		part_type_alpha3(fire,.5,.2,0);
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
		part_type_alpha3(poison,.5,.25,.05);
		particle = poison;
		break;
	}
	case LIGHTNING: {
		var spark = part_type_create();
		part_type_shape(spark, pt_shape_spark);
		part_type_orientation(spark,0,359,0,15,1);
		part_type_size(spark,0.1,.25,0,0);
		part_type_speed(spark,8,12,0,0);
		part_type_direction(spark,0,360,0,4);
		part_type_life(spark,3,6);
		part_type_color3(spark,c_purple, c_fuchsia, c_white);
		part_type_alpha3(spark,1,.85,.75);
		particle = spark;
		break;
	}
	case "FairyDodge": {
		// smoke particle
		var smoke = part_type_create();
		part_type_shape(smoke, pt_shape_smoke);
		part_type_color2(smoke,owner.dyingParticleColor1,owner.dyingParticleColor2);
		part_type_orientation(smoke,0,0,0,15,1);
		part_type_size(smoke,0.15,0.45,0,0);
		part_type_speed(smoke,2,4,0,0);
		part_type_direction(smoke,0,360,0,4);
		part_type_life(smoke,10,15);
		part_type_alpha3(smoke,.75,.5,.25);
		particle = smoke;
		break;
	}
	case "Death": {
		// death particle
		if !is_array(owner.dyingParticleColor1) {
			var blood = part_type_create();
			part_type_shape(blood, pt_shape_sphere);
			part_type_color2(blood,owner.dyingParticleColor1,owner.dyingParticleColor2);
			part_type_orientation(blood,0,0,0,15,1);
			part_type_size(blood,0,0.15,0,0);
			part_type_speed(blood,2,4,0,0);
			part_type_direction(blood,0,360,0,4);
			part_type_life(blood,10,15);
			particle = blood;
		} else {
			for (var i = 0; i < array_length_1d(owner.dyingParticleColor1); i++) {
				var dyingParticleColor = owner.dyingParticleColor1[i];
				var blood = part_type_create();
				part_type_shape(blood, pt_shape_sphere);
				part_type_color2(blood,dyingParticleColor,dyingParticleColor);
				part_type_orientation(blood,0,0,0,15,1);
				part_type_size(blood,0,0.15,0,0);
				part_type_speed(blood,2,4,0,0);
				part_type_direction(blood,0,360,0,4);
				part_type_life(blood,10,15);
				particles[i] = blood;
			}
		}
		break;
	}
	case "IceDeath": {
		// ice chunk particle
		var ice = part_type_create();
		part_type_sprite(ice,spr_particle_icechunk,0,0,1);
		part_type_size(ice,.01,.04,0,0);
		part_type_color2(ice,c_white,c_black);
		part_type_alpha3(ice,1,1,.2);
		part_type_speed(ice,4,8,0,0);
		part_type_direction(ice,0,359,0,5);
		part_type_orientation(ice,0,359,0,0,0);
		part_type_blend(ice,true);
		part_type_life(ice,15,25);
		particle = ice;
		
		// snowflake particle2
		var snowflake = part_type_create();
		part_type_shape(snowflake, pt_shape_snow);
		part_type_orientation(snowflake,0,0,0,15,1);
		part_type_size(snowflake,0,0.02,0,0);
		part_type_speed(snowflake,1,3,0,0);
		part_type_direction(snowflake,0,359,0,4);
		part_type_life(snowflake,30,50);
		part_type_alpha3(snowflake,1,.75,.5);
		particle2 = snowflake;
		
		randomize();
		var num  = random_range(7,10);
		var num2 = random_range(10,15);
		var sw = sprite_get_bbox_right(owner.sprite_index) - sprite_get_bbox_left(owner.sprite_index);
		var sh = sprite_get_bbox_bottom(owner.sprite_index) - sprite_get_bbox_top(owner.sprite_index);
		var x1 = owner.x - (.5*sw);
		var y1 = owner.y - (.5*sh);
		var x2 = owner.x + (.5*sw);
		var y2 = owner.y + (.5*sh);
		part_system_depth(system,0);
		part_emitter_region(system,emitter,x1,x2,y1,y2,ps_shape_ellipse,0);
		part_emitter_burst(system,emitter,particle, num);
		part_emitter_burst(system,emitter,particle2, num2);
		//instance_destroy(id);
	}
}