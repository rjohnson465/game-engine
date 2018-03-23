if owner.state == CombatantStates.Dodging {
	visible = false;
} else visible = true;

// switch hand sprites if weapon changes and uses different weapon art
if ds_map_find_value(owner.equippedLimbItems,limbKey) != limbItem {
	limbItem = ds_map_find_value(owner.equippedLimbItems,limbKey);
	
	if owner.type != CombatantTypes.Player {
		spriteString = "spr_"+owner.spriteString + "_limb_" + limbItem.spriteName;
	} else {
		spriteString = limbItem.handSpriteString;
	}
	
	sprite_index = asset_get_index(spriteString);
}

// if we currently have a 2h weapon equipped, make the right hand fuck off
var leftHandItem = ds_map_find_value(owner.equippedLimbItems,"l");
if leftHandItem {
	if leftHandItem.isTwoHanded && limbKey == "r" {
		x = -1000;
		y = -1000;
	} else {
		x = owner.x;
		y = owner.y;
	}
}
image_angle = owner.facingDirection;
image_alpha = owner.alpha;
image_xscale = 1*owner.scale;
image_yscale = 1*owner.scale;
if limbKey == "l" {
	image_yscale = -1*owner.scale;
}
layer = owner.layer;
//depth = layer_get_depth(layer) + 1;


if limbItem.subType == HandItemTypes.Shield && owner.isShielding {
	if owner.type == CombatantTypes.Player {
		spriteString = limbItem.handSpriteString+"_block";
	} else {
		spriteString = "spr_"+owner.spriteString + "_limb_" + limbItem.spriteName + "_block";
	}
	sprite_index = asset_get_index(spriteString);
} else {
	if owner.type != CombatantTypes.Player {
		spriteString = "spr_"+owner.spriteString + "_limb_" + limbItem.spriteName;
	} else {
		spriteString = limbItem.handSpriteString;
	}
	
	sprite_index = asset_get_index(spriteString);
}
image_angle = owner.facingDirection;


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


with obj_attack {
	if place_meeting_layer(x,y,other.id) {
		with other.owner {
			calculateDamage();
		}
	}
}


if owner.currentUsingSpell != noone {
	// TODO enemy spells
	sprite_index = asset_get_index("spr_player_hand_spellprep");
	
	var atn = owner.currentSpellAttunement;
	switch atn {
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
			particle = snowflake;
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
			particle = magic;
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
			part_type_direction(cinder,0,359,0,0);
			part_type_blend(cinder,1);
			part_type_life(cinder,25,50);
			particle = cinder;
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
			particle = poison;
			break;
		}
		case LIGHTNING: {
			var spark = part_type_create();
			part_type_shape(spark, pt_shape_spark);
			part_type_orientation(spark,0,359,0,15,1);
			part_type_size(spark,0.1,.2,0,0);
			part_type_speed(spark,8,12,0,0);
			part_type_direction(spark,0,360,0,4);
			part_type_life(spark,3,6);
			part_type_color2(spark,c_blue,c_white);
			part_type_alpha3(spark,1,.85,.75);
			particle = spark;
			break;
		}
	}
	part_system_depth(system,depth);
	part_emitter_region(system,emitter,bbox_left,bbox_right,bbox_top,bbox_bottom,ps_shape_ellipse,ps_distr_gaussian);
	part_emitter_burst(system,emitter,particle, 2);
	
}

/*
if owner.type != CombatantTypes.Player && sprite_index != asset_get_index(spriteString) {
	show_debug_message(string(sprite_index) + string(image_index));
}