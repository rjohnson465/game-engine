/// wishAtDarkFountain(*performBlur)
/// @param performBlur*

var performBlur = true;
if argument_count > 0 performBlur = argument[0];

with obj_player {
	
	// give at most 1 health charge
	var healthFlask = instance_nearest(x,y,obj_item_health_flask);
	if instance_exists(healthFlask) {
		var chargesCount = ds_map_find_value(healthFlask.customItemProperties, hfs_charges);
		if chargesCount == 0 {
			ds_map_replace(healthFlask.customItemProperties, hfs_charges, 1);
		}
	}
}

/*
if performBlur {
	alarm[0] = 30; // trigger radial blur
	application_surface_draw_enable(false);
}*/
	
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

	
// respawn all bosses in room TODO
// respawnEnemies();
respawnEnemies(true);
		
// refill player health and stamina
with obj_player {
	hp = maxHp;
	stamina = maxStamina;
		
	// convert temp xp to real xp
	xp += xpTemp;
	xpTemp = 0;
		
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

// teleport player to boss start coordinates
with global.player {
	x = other.teleportX; 
	y = other.teleportY;
}

var p = global.player;
var l = p.layer;
var lname = layer_get_name(l);
var xx = p.x; 
var yy = p.y;

var a = 3;

// trigger a save 
with obj_game_manager {
	fs_save_game();
	alert("Saving " + currentSaveFile, c_yellow);
}
