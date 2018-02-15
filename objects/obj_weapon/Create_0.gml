limb = global.limb;
limbKey = limb.limbKey;
owner = limb.owner;
limbItem = limb.limbItem;
depth = 5;
persistent = limb.persistent;

spriteString = "spr_"+owner.spriteString+"_"+limbItem.spriteName;
sprite_index = asset_get_index(spriteString);


if limbKey == "l" {
	image_yscale = -1;
}

// particle system for elemental effects
emitter = noone;
system = noone;
particle = noone;

if owner.type == CombatantTypes.Player {
	// iterate over weapon damages
	var currentDamageType = ds_map_find_first(limbItem.damages);
	var damageTypes = ds_list_create();
	for (var i = 0; i < ds_map_size(limbItem.damages); i++) {
		if currentDamageType != PHYSICAL {
			var damagesArray = ds_map_find_value(limbItem.damages,currentDamageType);
			if damagesArray[0] > 0 || damagesArray[1] > 0 {
				ds_list_add(damageTypes,currentDamageType);
			}
		}
		currentDamageType = ds_map_find_next(limbItem.damages,currentDamageType);
	}
		
	// create a particle emitter for the first damage type
	var damageType = ds_list_find_value(damageTypes,0);
	if damageType != undefined {
		system = part_system_create();
		part_system_depth(system,-4);
		emitter = part_emitter_create(system);

		var part = part_type_create();
		part_type_shape(part, pt_shape_sphere);
		part_type_orientation(part,0,359,0,15,1);
		part_type_size(part,0,.1,0,0);
		part_type_speed(part,1,2,0,0);
		part_type_direction(part,0,360,0,4);
		part_type_life(part,10,15);
		var c1; var c2;
		switch (damageType) {
				case FIRE: {
					c1 = c_orange;
					c2 = c_red;
					break;
				}
				case ICE: {
					c1 = c_white;
					c2 = c_aqua;
					break;
				}
				case POISON: {
					c1 = c_green;
					c2 = c_olive;
					break;
				}
				case LIGHTNING: {
					c1 = c_blue;
					c2 = c_white;
					break;
				}
			}
		part_type_color2(part,c1,c2);
		part_type_alpha3(part,1,.85,.75);
		particle = part;
	}
}