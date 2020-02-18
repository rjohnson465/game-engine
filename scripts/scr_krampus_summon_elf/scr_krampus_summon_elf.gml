/// scr_krampus_summon_elf

// summon a krampus elf at x / y
// called by multirand attack on Create event

//  are any elves currently engaging with the player, or able to do so?
with obj_enemy_krampuself {
	var p = path_add();
	var pathExists = mp_grid_path(personalGrid, p, x, y, global.player.x, global.player.y, true);
	if pathExists {
		path_delete(p);
		exit;
	}
}

// ALSO player must be someplace krampus cant walk to
/*
with obj_enemy_krampus {
	var p = path_add();
	var pathExists = mp_grid_path(personalGrid, p, x, y, global.player.x, global.player.y, true);
	if pathExists {
		path_delete(p);
		exit;
	}
	path_delete(p);
}*/

// make sure there is a "teleport point" this elf can path to
var grid = ds_map_find_value(global.grids, 1);
var associatedTeleObj = noone;
with obj_teleport_point {
	var p = path_add();	
	var pathExists = mp_grid_path(grid, p, other.x, other.y, x, y, true);
	
	if pathExists {
		// make sure this teleport point is not one krampus can currently walk to
		/*with obj_enemy_krampus {
			var p2 = path_add();
			var pathExists2 = mp_grid_path(personalGrid, p2, x, y, global.player.x, global.player.y, true);
			if pathExists2 {
				path_delete(p2);
				exit;
			}
			path_delete(p2);
		} */
		
		// set this teleport point to be the elf's associatedTeleportPoint
		associatedTeleObj = id;
	}
	path_delete(p);
}
// if we cant path to any tele point, dont spawn elf
if associatedTeleObj = noone exit;

// make sure no other krampus elf is guarding this area
with obj_enemy_krampuself {
	if variable_instance_exists(id, "associatedTeleportObj") && associatedTeleportObj == associatedTeleObj && x > 0 && y > 0 && hp > 0 {
		exit;
	}
}

var elf = instance_create_layer(x, y, global.player.layer, obj_enemy_krampuself);
elf.attackFrequencyTotalFramesMeleeDefault = [60, 90];
elf.attackFrequencyTotalFramesMelee = [60, 90];
var possibleCreateScripts = [ei_krampuself_iceaxes, ei_krampuself_iceclubs, ei_krampuself_icespears];

randomize();
var index = round(random_range(0, array_length_1d(possibleCreateScripts) - 1));
var script = possibleCreateScripts[index];
with elf {
	script_execute(script);
}
elf.lockOnTarget = global.player;
elf.sightAngleDelta = 360;
elf.associatedTeleportObj = associatedTeleObj;