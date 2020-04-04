/// scr_absnowman_summon_iceshooter

// summon a iceshooter at x / y
// called by multirand attack on Create event

// make sure there is a line between player and iceshooter ??
/*
var grid = ds_map_find_value(global.grids, 1);
var associatedTeleObj = noone;
with obj_teleport_point {
	var p = path_add();	
	var pathExists = mp_grid_path(grid, p, other.x, other.y, x, y, true);
	
	if pathExists {
		
		// set this teleport point to be the elf's associatedTeleportPoint
		associatedTeleObj = id;
	}
	path_delete(p);
}
*/

var numShooters = instance_number(obj_enemy_iceshooter);
if numShooters >= 3 exit;

var iceshooter = instance_create_layer(x, y, global.player.layer, obj_enemy_iceshooter);
iceshooter.isMinion = true;

var lr = noone;
with obj_light_radius {
	if owner == iceshooter.id {
		lr = id;
	}
}
if lr != noone {
	with lr {
		event_perform(ev_other, ev_room_start);
	}
}