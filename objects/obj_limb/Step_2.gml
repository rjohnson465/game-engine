if room == game_menu exit;
if owner.state == CombatantStates.Dodging {
	visible = false;
} else visible = true;

// switch hand sprites if weapon changes and uses different weapon art
if ds_map_find_value(owner.equippedLimbItems,limbKey) != limbItem {
	limbItem = ds_map_find_value(owner.equippedLimbItems,limbKey);
	
	if owner.type != CombatantTypes.Player /*&& !isLimbLimited*/ {
		spriteString = "spr_"+owner.spriteString + "_limb_" + limbItem.spriteName;
	} else if !isLimbLimited {
		spriteString = limbItem.handSpriteString;
	}
	
	sprite_index = asset_get_index(spriteString);
}


// if we currently have a 2h weapon equipped, make the right hand fuck off
var leftHandItem = ds_map_find_value(owner.equippedLimbItems,"l");

if leftHandItem {
	if owner == global.player && owner.currentUsingSpell != noone {
		x = owner.x;
		y = owner.y;
	}
	else if (leftHandItem.isTwoHanded || owner.state == CombatantStates.Healing) && limbKey == "r" && owner.currentUsingSpell == noone {
		x = -1000;
		y = -1000;
	} else {
		x = owner.x;
		y = owner.y;
	}
}
image_angle = owner.facingDirection;
image_alpha = owner.alpha;

if !owner.visible {
	visible = false;
}

image_xscale = 1*owner.scale;
image_yscale = 1*owner.scale;
if !(limbKey == "r" || (leftHandItem.isRanged && leftHandItem.isTwoHanded && owner.currentUsingSpell == noone)) {
	image_yscale = -1*owner.scale;
}
if limbKey == "l" && owner.currentUsingSpell != noone {
	image_yscale = -1*owner.scale;
}
layer = owner.layer;
//depth = layer_get_depth(layer) + 1;


if limbItem.subType == HandItemTypes.Shield && owner.isShielding {
	if owner.type == CombatantTypes.Player /*&& !isLimbLimited*/ {
		spriteString = limbItem.handSpriteString+"_block";
	} else {
		spriteString = "spr_"+owner.spriteString + "_limb_" + limbItem.spriteName + "_block";
	}
	sprite_index = asset_get_index(spriteString);
} else {
	if owner.type != CombatantTypes.Player /*&& !isLimbLimited*/ {
		spriteString = "spr_"+owner.spriteString + "_limb_" + limbItem.spriteName;
	} else {
		spriteString = limbItem.handSpriteString;
	}
	
	sprite_index = asset_get_index(spriteString);
}
image_angle = owner.facingDirection;

// TODO factor for "limited" limbs
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
			var wallsBetween = scr_collision_line_list_layer(x, y, other.x, other.y, obj_wall_parent, true, true);
			var doorsBetween = scr_collision_line_list_layer(x, y, other.x, other.y, obj_door, true, true);
			var wallsBetweenAreSolid = false;
				
			if ds_exists(wallsBetween, ds_type_list) {
				for (var i = 0; i < ds_list_size(wallsBetween); i++) {
					var w = ds_list_find_value(wallsBetween, i);
					if w.stopsAttacks {
						wallsBetweenAreSolid = true;
					}
				}
			}
				
			// disallow attacking through doors and walls
			if (wallsBetween == noone || !wallsBetweenAreSolid) && doorsBetween == noone {
				calculateDamage();
			}
			if ds_exists(wallsBetween, ds_type_list) {
				ds_list_destroy(wallsBetween); wallsBetween = -1;
			}
			if ds_exists(doorsBetween, ds_type_list) {
				ds_list_destroy(doorsBetween); doorsBetween = -1;
			}
		}
	}
}


if owner.currentUsingSpell != noone {
	// TODO enemy spells
	sprite_index = asset_get_index("spr_player_hand_spellprep");
	
	var atn = owner.currentSpellAttunement;
	var num = 2;
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
			part_type_size(spark,0.05,.15,0,0);
			part_type_speed(spark,8,12,0,0);
			part_type_direction(spark,0,360,0,4);
			part_type_life(spark,3,6);
			part_type_color2(spark,c_purple,c_white);
			part_type_alpha3(spark,1,.85,.75);
			num = 1;
			particle = spark;
			break;
		}
	}
	part_system_depth(system,depth);
	part_emitter_region(system,emitter,bbox_left,bbox_right,bbox_top,bbox_bottom,ps_shape_ellipse,ps_distr_gaussian);
	part_emitter_burst(system,emitter,particle, num);
}
