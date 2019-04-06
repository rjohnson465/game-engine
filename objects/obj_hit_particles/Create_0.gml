layer = global.hitParticlesLayer;
type = global.damageType;
victim = global.victim;
if type == SLASH || type == PIERCE || type == CRUSH {
	type = PHYSICAL;
}
x1 = global.x1;
y1 = global.y1;
particleDirection = global.particleDirection;

randomize();
var num = random_range(7,10); // maybe make this dependent on how hard the hit was?

system = part_system_create();
part_system_depth(system,layer_get_depth(layer));
emitter = part_emitter_create(system);
particle = noone;
particle2 = noone;
particle3 = noone;
particle4 = noone;

particles = [];

// special: if type is an instance of obj_attack_data_parent, use its part1 for particle
if !is_string(type) && instance_exists(type) && object_is_ancestor(type.object_index, obj_attack_data_parent) {
	particle = type.part1;
	num = type.part1Num;
} else {

	switch type {
		case PHYSICAL: {
			num = random_range(25,50);
			if (!is_array(victim.dyingParticleColor1)) {
				
				// blood particle
				var blood = part_type_create();
				part_type_shape(blood, pt_shape_sphere);
				part_type_color2(blood,victim.dyingParticleColor1,victim.dyingParticleColor2);
				part_type_orientation(blood,0,0,0,15,1);
				part_type_size(blood,0,0.15,0,0);
				part_type_speed(blood,2,8,0,0);
				part_type_direction(blood,0,360,0,4);
				part_type_life(blood,10,15);
				particle = blood;
			} else {
				for (var i = 0; i < array_length_1d(victim.dyingParticleColor1); i++) {
					var particleColor = victim.dyingParticleColor1[i];
					var blood = part_type_create();
					part_type_shape(blood, pt_shape_sphere);
					part_type_color2(blood,particleColor,particleColor);
					part_type_orientation(blood,0,0,0,15,1);
					part_type_size(blood,0,0.15,0,0);
					part_type_speed(blood,2,8,0,0);
					part_type_direction(blood,0,360,0,4);
					part_type_life(blood,10,15);
					particles[i] = blood;
				}
			}
			break;
		}
		case LIGHTNING: {
			var spark = part_type_create();
			part_type_shape(spark, pt_shape_spark);
			part_type_orientation(spark,0,359,0,15,1);
			part_type_size(spark,0.02,.15,0,0);
			part_type_speed(spark,8,12,0,0);
			part_type_direction(spark,0,360,0,4);
			part_type_life(spark,4,7);
			part_type_color2(spark,c_purple,c_white);
			part_type_alpha3(spark,1,.85,.75);
			num = 3;
			particle = spark;
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
		case "Block": {
			var spark = part_type_create();
			part_type_shape(spark, pt_shape_spark);
			part_type_color2(spark,c_yellow,c_white);
			part_type_orientation(spark,0,0,0,15,1);
			part_type_size(spark,0,0.15,0,0);
			part_type_speed(spark,4,6,0,0);
			var pd = (particleDirection+180)%360;
			var minDir = pd - 45;
			if minDir < 0 {
				minDir = 360+minDir;
			}
			var maxDir = (particleDirection + 45)%360;
			part_type_direction(spark,minDir,maxDir,0,4);
			part_type_life(spark,5,15);
			particle = spark;
			break;
		}
		case "Dust": {
			// dust particle
			var dust = part_type_create();
			part_type_shape(dust, pt_shape_sphere);
			part_type_color2(dust,c_olive,c_dkgray);
			part_type_orientation(dust,0,0,0,15,1);
			part_type_size(dust,0,0.15,0,0);
			part_type_speed(dust,2,8,0,0);
			part_type_direction(dust,0,360,0,4);
			part_type_life(dust,10,15);
			particle = dust;
			break;
		}
		case "Ground": {
			// dust particle
			var dust = part_type_create();
			part_type_shape(dust, pt_shape_smoke);
			part_type_color2(dust,c_olive,c_dkgray);
			part_type_orientation(dust,0,0,0,15,1);
			part_type_size(dust,0,0.35,0,0);
			part_type_speed(dust,2,8,0,0);
			part_type_direction(dust,0,360,0,4);
			part_type_life(dust,10,15);
			particle = dust;
		
			// set the particle system depth to less than the current warhammer attack
			var atkObj = noone;
			with obj_attack {
				if weapon != noone && weapon.weaponType == BLUNT2H && attackNumber == 3 {
					atkObj = id;
				}
			}
			if atkObj != noone {
				part_system_depth(system,atkObj.depth+1);
			}
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
		case "LevelUp": {
			// confetti particle
			particle = makeConfettiParticle(c_blue);
			particle2 = makeConfettiParticle(c_yellow);
			particle3 = makeConfettiParticle(c_lime);
			particle4 = makeConfettiParticle(c_red);
			num = 4;
			break;
		}
	}
}

if part_type_exists(particle) {
	part_emitter_region(system,emitter,x1,x1,y1,y1,0,0);
	part_emitter_burst(system,emitter,particle,num);
	if type == "LevelUp" {
		part_emitter_burst(system,emitter,particle2,num);
		part_emitter_burst(system,emitter,particle3,num);
		part_emitter_burst(system,emitter,particle4,num);
	}
} else if array_length_1d(particles) > 0 {
	for (var i = 0; i < array_length_1d(particles); i++) {
		var part = particles[i];
		part_emitter_region(system,emitter,x1,x1,y1,y1,0,0);
		part_emitter_burst(system,emitter,part,num / array_length_1d(particles));
	}
}

if type != LIGHTNING {
	//instance_destroy(id,false);
	alarm[1] = 14;
	part_emitter_clear(system,emitter);
} else alarm[0] = 15;