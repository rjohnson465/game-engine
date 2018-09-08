if owner.state == CombatantStates.Dodging || (owner.isShielding && limbItem.subType == HandItemTypes.Shield) {
	visible = false;
} else visible = true;
var leftHandItem = ds_map_find_value(owner.equippedLimbItems,"l");
x = limb.x;
y = limb.y;
image_angle = owner.facingDirection;
image_alpha = owner.alpha;
image_xscale = 1*owner.scale;
image_yscale = 1*owner.scale;
if !(limbKey == "r" || (leftHandItem.isRanged && leftHandItem.isTwoHanded)) {
	image_yscale = -1*owner.scale;
}
layer = owner.layer;
if owner.currentUsingSpell != noone {
	visible = false;
}
//depth = layer_get_depth(layer) + 1;

// switch weapon sprite
if limbItem != limb.limbItem || refreshParticles {
	limbItem = limb.limbItem;

	refreshParticles = false;
	if owner.type == CombatantTypes.Player {
		//if limbItem.subType != HandItemTypes.Shield {
			spriteString = "spr_"+owner.spriteString+"_"+limb.limbItem.spriteName;
			sprite_index = asset_get_index(spriteString);
		//} else sprite_index = -1;
	} else {
		spriteString = "spr_"+owner.spriteString+"_"+limb.limbItem.spriteName;
		sprite_index = asset_get_index(spriteString);
	}
	
	part_type_destroy(particle1);
	part_type_destroy(particle2);
	part_type_destroy(particle3);
	particle1 = noone;
	particle2 = noone;
	particle3 = noone;
	num1 = -3;
	num2 = -3;
	num3 = -3;
	part_emitter_destroy(system1,emitter1);
	part_emitter_destroy(system2,emitter3);
	part_emitter_destroy(system2,emitter3);
	part_system_destroy(system1);
	part_system_destroy(system2);
	part_system_destroy(system3);
	part_emitter_destroy(system1,emitter1);
	
	system1 = part_system_create();
	part_system_depth(system1,depth);
	emitter1 = part_emitter_create(system1);
	
	system2 = part_system_create();
	part_system_depth(system2,depth);
	emitter2 = part_emitter_create(system2);
	
	system3 = part_system_create();
	part_system_depth(system3,depth);
	emitter3 = part_emitter_create(system3);
	
	// iterate over weapon damages
	var currentDamageType = ds_map_find_first(limbItem.damages);
	var damageTypes = ds_list_create();
	for (var i = 0; i < ds_map_size(limbItem.damages); i++) {
		if !arrayIncludes(global.ALL_PHYSICAL_DAMAGE_TYPES,currentDamageType) {
			var damagesArray = ds_map_find_value(limbItem.damages,currentDamageType);
			if damagesArray[0] > 0 || damagesArray[1] > 0 {
				ds_list_add(damageTypes,currentDamageType);
			}
		}
		currentDamageType = ds_map_find_next(limbItem.damages,currentDamageType);
	}
		
	// particles for all elemental damages (up to 3)
	for (var i = 0; i < ds_list_size(damageTypes); i++) {
		var damageType = ds_list_find_value(damageTypes,i);
		switch damageType {
			case ICE: {
				// snowflake particle
				var snowflake = part_type_create();
				part_type_shape(snowflake, pt_shape_snow);
				part_type_orientation(snowflake,0,0,0,15,1);
				part_type_size(snowflake,0,0.1,0,0);
				part_type_speed(snowflake,1,1.5,0,0);
				part_type_direction(snowflake,0,360,0,4);
				part_type_life(snowflake,10,20);
				part_type_alpha3(snowflake,1,.75,.5);
				if i == 0 particle1 = snowflake;
				else if i == 1 particle2 = snowflake;
				else particle3 = snowflake;
				break;
			}
			case MAGIC: {
				num = random_range(10,15);
				// magic particle
				var magic = part_type_create();
				part_type_shape(magic, pt_shape_sphere);
				part_type_color2(magic,c_aqua,c_ltgray);
				part_type_orientation(magic,0,0,0,15,1);
				part_type_size(magic,0,0.07,0,0);
				part_type_speed(magic,1,2,0,0);
				part_type_direction(magic,0,360,0,4);
				part_type_life(magic,10,15);
				if i == 0 particle1 = magic;
				else if i == 1 particle2 = magic;
				else particle3 = magic;
				break;
			}
			case FIRE: {
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
				if i == 0 particle1 = cinder;
				else if i == 1 particle2 = cinder;
				else particle3 = cinder;
				break;
			}
			case POISON: {
				// poison clouds
				var poison = part_type_create();
				part_type_shape(poison, pt_shape_cloud);
				part_type_orientation(poison,0,359,0,15,1);
				part_type_size(poison,0.1,.45,0,0);
				part_type_speed(poison,.5,.75,0,0);
				part_type_direction(poison,0,360,0,4);
				part_type_life(poison,15,20);
				part_type_color2(poison,c_green,c_olive);
				part_type_alpha3(poison,.85,.65,.45);
				if i == 0 particle1 = poison;
				else if i == 1 particle2 = poison;
				else particle3 = poison;
				break;
			}
			case LIGHTNING: {
				var spark = part_type_create();
				part_type_shape(spark, pt_shape_spark);
				part_type_orientation(spark,0,359,0,15,1);
				part_type_size(spark,0.01,.15,0,0);
				part_type_speed(spark,5,8,0,0);
				part_type_direction(spark,0,360,0,4);
				part_type_life(spark,3,6);
				part_type_color2(spark,c_purple,c_white);
				part_type_alpha3(spark,1,.85,.75);
				if i == 0 {
					particle1 = spark;
					num1 = 2;
				}
				else if i == 1 {
					particle2 = spark;
					num2 = 2;
				}
				else {
					particle3 = spark;
					num3 = 2;
				}
				break;
			}
		}
	}
	ds_list_destroy(damageTypes); damageTypes = -1;
}

if owner.layer == global.player.layer && owner.currentUsingSpell == noone && owner.isAlive {
	if particle1 != noone {
		part_emitter_region(system1,emitter1,bbox_left,bbox_right,bbox_top,bbox_bottom,ps_shape_ellipse,ps_distr_gaussian);
		part_emitter_burst(system1,emitter1,particle1, num1);
	}
	if particle2 != noone {
		part_emitter_region(system2,emitter2,bbox_left,bbox_right,bbox_top,bbox_bottom,ps_shape_ellipse,ps_distr_gaussian);
		part_emitter_burst(system2,emitter2,particle2, num2);
	}
	if particle3 != noone {
		part_emitter_region(system3,emitter3,bbox_left,bbox_right,bbox_top,bbox_bottom,ps_shape_ellipse,ps_distr_gaussian);
		part_emitter_burst(system3,emitter3,particle3, num3);
	}
}

if ds_map_find_value(owner.preparingLimbs,limbKey) >= 0 {
	image_index = ds_map_find_value(owner.prepFrames,limbKey);
	sprite_index = getLimbSpriteIndex("prep");
}

else if ds_map_find_value(owner.attackingLimbs,limbKey) >= 0 {
	image_index = ds_map_find_value(owner.attackFrames,limbKey);
	sprite_index = getLimbSpriteIndex("attack");
}

else if ds_map_find_value(owner.recoveringLimbs,limbKey) >= 0 {
	image_index = ds_map_find_value(owner.recoverFrames,limbKey);
	sprite_index = getLimbSpriteIndex("recover");
} 

else {
	sprite_index = asset_get_index(spriteString);
}

