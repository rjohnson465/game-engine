/// wishAtFountain(*performBlur)
/// @param performBlur*

var performBlur = true;
if argument_count > 0 performBlur = argument[0];
	
var fountain = id;

with obj_player {
	lastFountain = other.id;
	lastFountainRoom = room_get_name(room);
	lastFountainX = fountain.spawnX;
	lastFountainY = fountain.spawnY;
	lastFountainZ = fountain.layerName;
}

// activate fountain
if !isRunning {
	isRunning = true;
	sprite_index = asset_get_index("spr_fountain_filling");	
	audio_emitter_gain(fountainRunningSoundEmitter,1);
	audio_play_sound(snd_fountain_turnon,1,0);
	if performBlur {
		alarm[0] = 30; // trigger radial blur
		application_surface_draw_enable(false);
	}
}
	
// wish at fountain
		
audio_play_sound(snd_fountain_wish,1,0);
if performBlur {
	alarm[0] = 30; // trigger radial blur
	var vx = camera_get_view_x(view_camera[0]);
	var vy = camera_get_view_y(view_camera[0]);
	var sw = view_get_wport(view_camera[0]);
	var sh = view_get_hport(view_camera[0]);
	var_mouse_pos_x = vx+sw/2;
	var_mouse_pos_y = vy+sh/2;
	application_surface_draw_enable(false);
}
	
// despawn all itemDrops
with obj_item_drop {
	instance_destroy(id,1);
}
// destroy any remaining itemdrop data objects
with obj_itemdrop_data {
	instance_destroy(id,1);
}
	
// respawn all enemies
respawnEnemies();
		
// refill player health and stamina
with obj_player {
	hp = maxHp;
	stamina = maxStamina;
		
	// convert temp xp to real xp
	xp += xpTemp;
	xpTemp = 0;
		
	// cure any and all conditions
	/*	var currentCondition = ds_map_find_first(conditionPercentages);
	for (var i = 0; i < ds_map_size(conditionPercentages);i++) {
		ds_map_replace(conditionPercentages,currentCondition,0);
		var conditionEmitter = ds_map_find_value(conditionsEmittersMap,currentCondition);
		audio_emitter_gain(conditionEmitter,0);
		currentCondition = ds_map_find_next(conditionPercentages, currentCondition);
	}*/
	cureAllConditions();
		
	// refill all weapon charges / durability for inventory weapons, repair all durability
	for (var i = 0 ; i < ds_list_size(inventory); i++) {
		var item = ds_list_find_value(inventory,i);
		if item.type == ItemTypes.HandItem {
			if item.chargesMax > 0 {
				item.charges = item.chargesMax;
			}
			if item.durability > 0 {
				item.durability = item.durabilityMax;
			}
			item.hasIssuedDurabilityWarning = false;
			item.hasIssuedDurabilityObituary = false;
			item.ammo = item.ammoMax;

		}
	}
	
	lightRadiusColor = c_white;
}


// trigger a save 
with obj_game_manager {
	//ds_map_replace(other.data.properties, "isDoneFilling", true);
	updatePersistentElementProperty(other, "isDoneFilling", true);
	fs_save_game();
	alert("Saving " + currentSaveFile, c_yellow);
}
